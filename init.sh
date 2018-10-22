#!/bin/bash
echo creating scratch org
sfdx force:org:create -s -f config/project-scratch-def.json -a scratchOrg
echo pushing source code
sfdx force:source:push
echo importing test data
sfdx force:data:tree:import --sobjecttreefiles data/Account.json
echo creating users and generating passwords
sfdx force:user:create --setalias office-clerk --definitionfile config/office-clerk.json username=office-clerk-$RANDOM@sfdc-task.org
sfdx force:user:password:generate --targetusername office-clerk
sfdx force:user:create --setalias manager --definitionfile config/manager.json username=manager-$RANDOM@sfdc-task.org
sfdx force:user:password:generate --targetusername manager
echo assigning permissions to your system administrator user
sfdx force:user:permset:assign -n DocGenerator
echo openning scratch org
sfdx force:org:open