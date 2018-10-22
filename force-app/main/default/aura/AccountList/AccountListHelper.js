({
    fetchData: function (component, accountIds) {
        let action = component.get("c.getAccounts");
        action.setParams({
            "accountIds": accountIds
        });
        action.setCallback(this, (response) => {
            let state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.data', response.getReturnValue());
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
})