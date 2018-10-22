# SFDX  App
<!-- 1. install sfdx -->
npm install sfdx --global
<!-- 2. authorize with your Dev Hub -->
sfdx force:auth:web:login -d -a DevHub
<!-- 3. update users email address:
./config/manager.json 
./config/office-clerk.json -->
<!-- 4. run this script for simplicity -->
chmod +x ./init.sh
./init.sh
<!-- 5. check users credentials and login with different users to test solution -->
sfdx force:user:list
sfdx force:user:display -u {username}
