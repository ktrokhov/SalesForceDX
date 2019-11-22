({
    /*call apex controller method "fetchContentDocument" to get salesforce file records*/
    doInit : function(component, event, helper) {
        var action = component.get("c.getContentDocuments");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set('v.lstContentDoc', response.getReturnValue());
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
    getSelected : function(component,event,helper){
        // get rec
        var recordID = component.get("v.recordId");
        var action2 = component.get("c.updatePresentationTime");
        action2.setParams({
            "eventId": recordID
        });
        action2.setCallback(this, function(response) {
           // var state = response.getState();
            $A.get('e.force:refreshView').fire();
        });
        
        
        
        //console.log(JSON.stringify(recordID));
        $A.enqueueAction(action2);  
        
        // display modle and set seletedDocumentId attribute with selected record Id   
        component.set("v.hasModalOpen" , true);
        component.set("v.selectedDocumentId" , event.currentTarget.getAttribute("data-Id")); 
       
        
    },
    
    downloadfile : function (component, event, helper){                 
    var id = event.target.getAttribute("data-id");       
    //alert('Document ID:' +id);
    var actiondownload = component.get("c.DownloadAttachment");

    actiondownload.setParams({ "DownloadAttachmentID": id});

      actiondownload.setCallback(this, function(response){
          component.set("v.Baseurl", response.getReturnValue());
          console.log(JSON.stringify(response.getReturnValue()));
          var urlEvent = $A.get("e.force:navigateToURL");
          urlEvent.setParams({
              "url": b.getReturnValue()
          });
          urlEvent.fire();
      });

      },      
    
    closeModel: function(component, event, helper){
        // for Close Model, set the "hasModalOpen" attribute to "FALSE"  
        component.set("v.hasModalOpen", false);
        component.set("v.selectedDocumentId" , null); 
    },

 handleClick : function(component, event, helper) {
    var action = component.get("c.getFile"); //getting attachment from apex

    action.setCallback(this, function(response) {
       let state = response.getState();
       if (state === "SUCCESS") {
           let downloadLink = document.createElement("a");
           downloadLink.href = "data:text/html;base64,"+response.getReturnValue();
           downloadLink.download = "filename.html";
           downloadLink.click(); 
               // console.log(response.getReturnValue());
           } else {
                console.log("Failed with state: " + state);
           }
    })

    $A.enqueueAction(action);
  
  },
    
 
})