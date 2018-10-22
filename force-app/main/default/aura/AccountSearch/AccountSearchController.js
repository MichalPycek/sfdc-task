({
    searchAccount: function (component, event, helper) {
        let searchText = component.get('v.searchText');
        let action = component.get('c.searchForIds');
        let searchEvent = component.getEvent("searchEvent");
        if (event.keyCode === 13 && searchText.length > 1) {
            component.set('v.isSearching', true);
            action.setParams({ searchText: searchText });
            action.setCallback(this, (response) => {
                let state = response.getState();
                component.set('v.isSearching', false);
                if (state === 'SUCCESS') {
                    let accountIds = response.getReturnValue();
                    searchEvent.setParam("accountIds", accountIds);
                    searchEvent.fire();
                } else if (state === "ERROR") {
                    let errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
            });
            $A.enqueueAction(action);
        }
    }
})
