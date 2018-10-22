({
    init: function (component, event, helper) {
        let button = component.find('disableButtonId');
        button.set('v.disabled', true);
    },
    validate: function (component) {
        let timeout = component.get('v.timer');
        clearTimeout(timeout);
        let button = component.find('disableButtonId');
        let content = component.get('v.content');
        let title = component.get('v.title');
        timeout = setTimeout(() => {
            if (content && title) {
                button.set('v.disabled', false);
            } else {
                button.set('v.disabled', true);
            }
        }, 1000);
        component.set('v.timer', timeout);
    },
    createDocument: function (component, event, helper) {
        let action = component.get('c.generateDocument');
        let content = component.get('v.content');
        let title = component.get('v.title');
        let account = component.get('v.account');
        let accountId = '';
        if (account) {
            accountId = account.Id;
        }
        action.setParams({ accountId: accountId, title: title, content: content });
        action.setCallback(this, (response) => {
            let state = response.getState();
            if (state === 'SUCCESS') {
                let contentDocumentId = response.getReturnValue();
                component.set('v.documentId', contentDocumentId);
                component.set('v.title', title);
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
