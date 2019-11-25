({
	init: function(component, event, helper) {
	    var createRecordEvent = $A.get("e.force:createRecord");
	    createRecordEvent.setParams({
	        "entityApiName": "Event"
	    });
	    createRecordEvent.fire();	   
	}
})