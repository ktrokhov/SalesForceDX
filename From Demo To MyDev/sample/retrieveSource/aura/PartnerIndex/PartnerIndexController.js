({
	 doInit : function(component, event, helper) {
         var recordID = component.get("v.recordId");
         
         
         var action = component.get("c.getPartnerIndex");
         
          action.setParams({
            "accId": recordID
        }); 
         
         action.setCallback(this, function(response) {
            var state = response.getState();    
            if (state === "SUCCESS") {
                component.set('v.listPartnerIndex', response.getReturnValue());
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
        $A.enqueueAction(action);  
    },
    
    createPartner : function(component, event, helper) {
          
        var recordID = component.get("v.recordId");
		 alert('Создать показатели на следующий год');
         var action = component.get("c.createPartnerIndex");
          action.setParams({
            "accId": recordID
        }); 

         action.setCallback(this, function(response) {
            var state = response.getState();    
            if (state === "SUCCESS") {
                component.set('v.listPartnerIndex', response.getReturnValue());
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
        $A.enqueueAction(action);  
    },
    
 
    // click link deteai view
    doView: function(component, event, helper) {
        var editRecordEvent = $A.get("e.force:navigateToSObject");
        editRecordEvent.setParams({
            "recordId": event.target.id
        });
        editRecordEvent.fire();
    },
    
        doEdit: function(component, event, helper) {
        var recordId = event.getParam("recordId");
        window.location.href = '/one/one.app#/sObject/'+recordId+'/view';
 
    },

    getNowYearIndex : function(component, event, helper) {
        var recordID = component.get("v.recordId");
        
        
        var action = component.get("c.getPartIndNow");
        
         action.setParams({
           "accId": recordID
       }); 
        
        action.setCallback(this, function(response) {
           var state = response.getState();    
           if (state === "SUCCESS") {
               component.set('v.listPartnerIndex', response.getReturnValue());
           }
           else if (state === "INCOMPLETE") {
               // do something
           }
               else if (state === "ERROR") {
                   var errors = response.getError();
                   if (errors) {
                       if (errors[0] && errors[0].message) {
                           console.log("Error message: " + 
                                       errors[0].message);
                       }
                   } else {
                       console.log("Unknown error");
                   }
               }
       });
       $A.enqueueAction(action);  
   },

   getAllYearIndex : function(component, event, helper) {
    var recordID = component.get("v.recordId");
    
    
    var action = component.get("c.getPartIndAll");
    
     action.setParams({
       "accId": recordID
   }); 
    
    action.setCallback(this, function(response) {
       var state = response.getState();    
       if (state === "SUCCESS") {
           component.set('v.listPartnerIndex', response.getReturnValue());
       }
       else if (state === "INCOMPLETE") {
           // do something
       }
           else if (state === "ERROR") {
               var errors = response.getError();
               if (errors) {
                   if (errors[0] && errors[0].message) {
                       console.log("Error message: " + 
                                   errors[0].message);
                   }
               } else {
                   console.log("Unknown error");
               }
           }
   });
   $A.enqueueAction(action);  
}


})