#!/bin/bash
echo creating scratch org
sfdx force:org:create -s -f config/project-scratch-def.json -a scratchOrg
echo pushing source code
sfdx force:source:push
echo importing test data
sfdx force:data:tree:import --sobjecttreefiles data/Account.json
echo creating users and generating passwords
for i in {1..2}; do sfdx force:user:create --setalias office-clerk-$RANDOM --definitionfile config/office-clerk.json username=office-clerk-$RANDOM@sfdc-task.org; done
sfdx force:user:create --setalias manager --definitionfile config/manager.json username=manager-$RANDOM@sfdc-task.org
echo assigning permissions to your system administrator user
sfdx force:user:permset:assign -n DocGenerator
echo assigning roles to users
sfdx force:apex:execute -f ./anonymous/assignRoles.apex
echo scheduling apex job
sfdx force:apex:execute -f ./anonymous/scheduleJob.apex
echo openning scratch org
sfdx force:org:open