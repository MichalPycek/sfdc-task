# SFDX  App
<!-- 1. authorize your Dev Hub -->
sfdx force:auth:web:login -d -a DevHub
<!-- 2. create scratch org -->
sfdx force:org:create -s -f config/project-scratch-def.json -a yourScratchOrgName
<!-- 3. push source code -->
sfdx force:source:push
<!-- 4. import test data -->
sfdx force:data:tree:import --sobjecttreefiles data/Account.json

<!-- create users -->
<!-- about 20 clerks per manager -->
sfdx force:user:create --setalias office-clerk --definitionfile config/office-clerk.json
sfdx force:user:password:generate --targetusername office-clerk
<!-- override param Username=tester345@sfdx.org  -->
<!-- few managers -->
sfdx force:user:create --setalias manager --definitionfile config/manager.json
sfdx force:user:password:generate --targetusername manager
<!-- 5. assign permissions to your system administrator user -->
sfdx force:user:permset:assign -n DocGenerator
<!-- 6. open scratch org -->
sfdx force:org:open
<!-- 7. go to App Launcher and select Document App-->


<!-- OR run as a script -->
chmod +x ./init.sh
./init.sh

