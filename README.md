# Document Generator App

sfdx app to create documents

## Getting Started

These instructions will get you a copy of the project up and running on your scratch org. See deployment for notes on how to deploy the project.

### Prerequisites

Install sfdx

```
npm install sfdx --global
```

Authorize with your Dev Hub, get trial from here: 
https://developer.salesforce.com/promotions/orgs/dx-signup

```
sfdx force:auth:web:login -d -a DevHub
```

### Deployment

Update users email address

```
./config/manager.json 
./config/office-clerk.json
```

Run deployment script

```
chmod +x ./init.sh
./init.sh
```

Check users credentials and login with different users to test solution

```
sfdx force:user:list
sfdx force:user:display -u {username}
```
