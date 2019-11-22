({
    doInit  : function(component, event, helper) {
        var idO = component.get("v.recordId"); 
        var action = component.get("c.sendEmail1");
        action.setParams({'idOpp':idO});

        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var dismissActionPanel = $A.get("e.force:closeQuickAction");
                dismissActionPanel.fire();

            }
        });
        
        $A.enqueueAction(action);
        var dismissActionPanel = $A.get("e.force:closeQuickAction");
        dismissActionPanel.fire();

    }
})