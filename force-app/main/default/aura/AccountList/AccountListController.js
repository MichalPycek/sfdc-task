({
    onSearchResultChange: function (component, event, helper) {
        console.log("Old value: " + event.getParam("oldValue"));
        console.log("Current value: " + event.getParam("value"));
        let accountIds = event.getParam("value");
        helper.fetchData(component, accountIds);
        let selectedAccountEvent = component.getEvent("selectedAccountEvent");
        console.log('Reset selectedAccount');
        selectedAccountEvent.setParam("selectedAccount", { 'Id': '', 'Name': '' });
        selectedAccountEvent.fire();
    },
    init: function (component, event, helper) {
        let accountIds = [];
        component.set('v.columns', [
            { label: 'Account name', fieldName: 'Name', type: 'text' }
        ]);
        helper.fetchData(component, accountIds);
    },
    updateSelectedText: function (component, event, helper) {
        let selectedAccountEvent = component.getEvent("selectedAccountEvent");
        let selectedRows = event.getParam('selectedRows');
        let selectedAccount = selectedRows[0];
        console.log('Select Account selectedAccount ', selectedAccount);
        selectedAccountEvent.setParam("selectedAccount", selectedAccount);
        selectedAccountEvent.fire();
    }
})
