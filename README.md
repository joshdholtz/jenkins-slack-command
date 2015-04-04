# jenkins-slack-command
A Jenkins command for Slack

```
/jenkins MyAwesomeApp
```

## Installation

### 1. Spin up instance Heroku

### 2. Setup Slack integrations

- Create a new "Slash Command"
  - Name command `/jenkins`
  - Set the URL to the url of your Heroku instance
  - Method should be POST
  - Label should be 'Jenkins' or whatevs
- Create a new "Inbound Webhook" (Optional)
  - Set the channel you would like to post to
  - Set the bot name `Jenkins` or whatevs

### 3. Setup environment variables on your Heroku instance

- Required environment variables
 - `SLACK_TOKEN` - token from your "Slash Command"
 - `JENKINS_URL` - URL to your Heroku instnace
 - `JENKINS_TOKEN` - API token of your user in Jenkins
- Optional environment variables
  - `SLACK_WEBHOOK_URL` - your incoming webhook URL
  
### 4. Execute command in Slack

```
/jenkins MyAwesomeApp
```
