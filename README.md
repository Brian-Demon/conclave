# Conclave
Conclave is an old school forum programmed in Ruby on Rails with basic functionality. This repo is meant to be a jumping off point for anyone who wants to create a forum that harkens back to the days of dial-up modems and ecto coolers.

## Example
A demo of this app can be found [here](https://conclave-forum.herokuapp.com/)

## Setup
This forum uses [Google Oauth 2](https://developers.google.com/identity/protocols/oauth2) for the session's authentication and access.
### Google Oauth 2
To get Google Oauth access visit [console.cloud.google.com](https://console.cloud.google.com/) and follow the steps below:
1. Select "APIs & Services" from the menu on the left and select "Credentials"
![1 - Google API   Services - Credentials](https://user-images.githubusercontent.com/74803363/138534234-ad90c278-2857-4c2e-bb73-6df1d126c3c8.png)
2. Click "Create Project"
![2 - Google API   Services - Credentials - Create Project](https://user-images.githubusercontent.com/74803363/138534297-517dec16-e8de-4682-9c7b-cb2973cd56d9.PNG)
3. Select "Oauth client ID
![3 - Google API   Services - Credentials - Create Project - Create Credntials - OAuth client ID](https://user-images.githubusercontent.com/74803363/138534313-7c22327f-cd28-4426-8fa4-7bc5f659c01b.png)
4. If you have not created a project before with Googgle Cloud Platform you will need to complete the "Configure Consent Screen" form (it's a few pages but fairly self explanitory) For more help on that visit [here](https://support.google.com/cloud/answer/6158849?hl=en#zippy=%2Cuser-consent)
![4 - Google API   Services - Credentials - Create Project - Create Credntials - OAuth client ID - Configure Consent Screen](https://user-images.githubusercontent.com/74803363/138534431-ab817b77-cef1-4c9c-adb6-9bea643d41d5.png)
5. You will be now promted with the application type. Select "Web Application." (If you had to do step 4, you may need to go back to step 3 before continuing)
![5 - Google API   Services - Credentials - Create Project - Create Credntials - OAuth client ID - Application Type](https://user-images.githubusercontent.com/74803363/138534469-574aede3-7534-4364-836d-6fa3970da677.PNG)
6. Give the web client a name of your choice and then click "ADD URI" at the bottom of the screen. For development, you will want to put your server domain (i.e. `http://localhost:3000/`). You are able to add as many URIs as you need (like when the app is deployed to production, i.e. heroku). Append each domain with `auth/google_oauth_2/callback`. Then click the blue "CREATE" button at the bottom of the form.
![6 - Google API   Services - Credentials - Create Project - Create Credntials - OAuth client ID - Authorized redirect URIs](https://user-images.githubusercontent.com/74803363/138534589-71362020-c91a-4d7a-94a5-f78c5876ddfe.PNG)
7. If done correctly you will recieve your Oauth client info (Client ID & Client Secret). *DO NOT GIVE OUT YOUR CREDENTIALS*
![7 - Google API   Services - Credentials - Create Project - Create Credntials - OAuth client ID - Oauth client created](https://user-images.githubusercontent.com/74803363/138534645-0db8e4dd-a417-49a5-9483-e24c94f379db.PNG)
8. In the terminal of your editor type `rails credentials:edit` to access where you're going to put the google oauth client info. After it is placed use the key combination to "Write Out" then press [enter]
   ```
   google_oauth2:
    client_id: [YOUR CLIENT ID]
    client_secret: [YOUR CLIENT SECRET]
   ```
### First time admin
When you first setup this envornment, create your database and run up your dev server. Login so the first User is you. Then run `rails admin:set [login of the first User]` to make yourself an admin and thus you can start creating Cateories. Note that this command will only work as long as there is no other admin. Subsequent admins can be set to an admin role via the "User Roles" button in the header.

## Styling
Conclave uses [Tailwind CSS](https://github.com/tailwindlabs/tailwindcss) for the styling.

## Authorization Layer
Conclave uses [CanCanCan](https://github.com/CanCanCommunity/cancancan) for authorization.

## Features
This old school forums is pretty bare bones with the intention to add more functionality on your own. Features included are:
- pin/unpin a Discussion
- lock/unlock a Discussion
- ban/unban a User

## Want to Contribute?
If you'd like to contribute to this repo please make a fork, test your new functionality or what you'd like to add/take away/change, and PR the main repo.
