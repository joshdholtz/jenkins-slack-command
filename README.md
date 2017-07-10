# jenkins-slack-command

[![Twitter: @KauseFx](https://img.shields.io/badge/contact-@joshdholtz-blue.svg?style=flat)](https://twitter.com/joshdholtz)
[![License](http://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/joshdholtz/exportation/blob/master/LICENSE)

Start a build in Jenkins using a Slack Command

**Slack Command**
![](screenshots/command.png)

**Incoming Webhook**
![](screenshots/incoming_webhook.png)

## Features
- Start a build
  - `/jenkins MyAwesomeApp`
- Start a parameterized build
  - `/jenkins MyAwesomeApp param1=value1 param2=value2`
  
## In Progress
- Error handling when staring the build fails

## Installation

### 1. Setup Slack integrations

- Create a new "Slash Command"
  - Name command `/jenkins`
  - Set the URL to the url of your Heroku instance (created in [step 3](#3-spin-up-heroku-instance))
  - Method should be POST
  - Label should be 'Jenkins' or whatevs
- Create a new "Inbound Webhook" (Optional)
  - Set the channel you would like to post to
  - Set the bot name `Jenkins` or whatevs

### 2. Setup environment variables on your Heroku instance

- Required environment variables
 - `SLACK_TOKEN` - token from your "Slash Command"
 - `JENKINS_URL` - URL to your Heroku instnace
 - `JENKINS_TOKEN` - API token of your user in Jenkins
   - The API token is available in your personal configuration page. Click your name on the top right corner on every page, then click "Configure" to see your API token. (The URL $root/me/configure is a good shortcut.) You can also change your API token from here.
- Optional environment variables
  - `SLACK_WEBHOOK_URL` - your incoming webhook URL
  
### 3. Spin up Heroku instance

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy?template=https://github.com/joshdholtz/jenkins-slack-command)
  
### 4. Execute command in Slack

```
/jenkins MyAwesomeApp
```

## FAQ

### How do I access my Jenkins server from behind a router?
I used [ngrok.com](https://ngrok.com/) with basic authentication to expose my Jenkins server

### Can I integrate with `fastlane` and call different lanes?
You can! Make a parameterized build with a name called `lane` (or whatever you want to call it). Make this a string or choice parameter with all your build lanes available as choices (beta, inhouse, app_store). Then use this `$lane` in your build shell command in your job's configuration - `bundle exec fasltane $lane`.

To call this from Slack, all you need to do is send `/jenkins MyAwesomeApp lane=beta`.

## Author

Josh Holtz, me@joshholtz.com, [@joshdholtz](https://twitter.com/joshdholtz)

## License

jenkins-slack-command is available under the MIT license. See the LICENSE file for more info.
