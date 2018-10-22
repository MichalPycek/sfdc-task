({
    updateAccountIds: function (component, event, helper) {
        let accountIds = event.getParam("accountIds");
        component.set('v.accountIds', accountIds);
    },
    updateSelectedAccount: function (component, event, helper) {
        let acc = event.getParam("selectedAccount");
        component.set('v.selectedAccount', acc);
    }
})
