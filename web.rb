require 'json'
require 'iron_mq'
require 'rest-client'
require 'sinatra'
require 'slack-notifier'

get '/' do
  "This is a thing"
end

post '/webhook/slack' do

  # Verify all environment variables are set
  return [403, "No slack token setup"] unless slack_token = ENV['SLACK_TOKEN']
  
  # Verify slack token matches environment variable
  return [401, "No authorized for this command"] unless slack_token == params['token']

  # Split command text
  text_parts = params['text'].split(' ')

  # Split command text - job
  job = text_parts[0]

  # Split command text - parameters
  parameters = []
  if text_parts.size > 1
    all_params = text_parts[1..-1]
    all_params.each do |p|
      p_thing = p.split('=')
      parameters << { :name => p_thing[0], :value => p_thing[1] }
    end
  end

  # Build url
  build_url = post_to_jenkins(job, parameters)
  post_to_iron_mq(job, parameters)

  build_url
end

def post_to_jenkins(job, parameters)
  jenkins_url= ENV['JENKINS_URL']
  jenkins_token= ENV['JENKINS_TOKEN']

  return false if jenkins_url.nil? || jenkins_token.nil?

  # Jenkins url
  jenkins_job_url = "#{jenkins_url}/job/#{job}"

  # Get next jenkins job build number
  resp = RestClient.get "#{jenkins_job_url}/api/json"
  resp_json = JSON.parse( resp.body )
  next_build_number = resp_json['nextBuildNumber']

  # Make jenkins request
  json = JSON.generate( {:parameter => parameters} )
  resp = RestClient.post "#{jenkins_job_url}/build?token=#{jenkins_token}", :json => json

  build_url = "#{jenkins_job_url}/#{next_build_number}"

  slack_webhook_url = ENV['SLACK_WEBHOOK_URL']
  if slack_webhook_url
    notifier = Slack::Notifier.new slack_webhook_url
    notifier.ping "Started job '#{job}' - #{build_url}"
  end

  return build_url
end

def post_to_iron_mq(job, parameters)
  iron_token = ENV['IRON_TOKEN']
  iron_project_id = ENV['IRON_PROJECT_ID']
  iron_queue = ENV['IRON_QUEUE']
  
  return false if iron_token.nil? || iron_project_id.nil? || iron_queue.nil?

  ironmq = IronMQ::Client.new(:token => iron_token, :project_id => iron_project_id)
  queue = ironmq.queue(iron_queue)

  message = {job_name: job, job_parameter: {:parameter => parameters} }

  json = JSON.generate message
  queue.post json
end