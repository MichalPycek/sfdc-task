List<User> userList = new List<User>();
List<Id> managerList = new List<Id>();
Map<String, Id> userNameRoleMap = new Map<String, Id>();
for(User u : [SELECT Id, Name, Username, UserRoleId, ManagerId FROM User WHERE Username LIKE 'manager%']){
    managerList.add(u.id);
}
for(UserRole userRole : [SELECT Id, Name FROM UserRole WHERE Name = 'Manager' OR Name = 'Clerk']) {
    userNameRoleMap.put(userRole.Name, userRole.Id);
}
for(User user : [SELECT Id, Name, Username, UserRoleId, ManagerId FROM User WHERE Username LIKE 'office-clerk%' OR Username LIKE 'manager%']) {
    Double d = math.random() * managerList.size() -1;
    Integer c = d.intValue();
    if(user.Username.startsWith('office-clerk')) {
        user.ManagerId = managerList.get(c);
        user.UserRoleId = userNameRoleMap.get('Clerk');
    } else if(user.Username.startsWith('manager')){
        user.UserRoleId = userNameRoleMap.get('Manager');
    }
    userList.add(user);
}
update userList;