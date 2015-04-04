# jenkins-slack-command
A Jenkins command for Slack to start a build

**Slack Command**
![](screenshots/command.png)

**Incoming Webhook**
![](screenshots/incoming_webhook.png)

## Features
- Start a build
  - `/jenkins MyAwesomeApp`
- Start a parameterized build
  - `/jenkins MyAwesomeApp param1=value1 param2=value2`

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
