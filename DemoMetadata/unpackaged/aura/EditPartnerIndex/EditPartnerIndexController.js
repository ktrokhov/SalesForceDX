({
    doInit : function(component, event, helper) {
        
        component.set('v.columns', [
            {label: 'Причина', fieldName: 'Reason__c', editable:'true', type: 'text'},
            {label: 'Объём продаж (план)', fieldName: 'PeriodSalesVolumePlan__c', editable:'true', type: 'currency'}
        ]);        
        
        
        var recordID = component.get("v.recordId");
        
        var action = component.get("c.getIndex");
        
        action.setParams({
            "partnerId": recordID
        }); 
        
        action.setCallback(this, function(response) {
            var state = response.getState();    
            if (state === "SUCCESS") {
                component.set('v.data', response.getReturnValue());
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
    
    
    onSave : function(component, event, helper){
        var editedRecords =  component.find("indexDataTable").get("v.draftValues");
        var totalRecordEdited = editedRecords.length;
        var action = component.get("c.upsertIndex");
        action.setParams({
            'IndexList' : editedRecords
        });
        action.setCallback(this,function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                //if update is successful
                if(response.getReturnValue() === true){
                    helper.showToast({
                        "title": "Изменение плана:",
                        "type": "success",
                        "message": " запись была изменена"
                    });
                    helper.reloadDataTable();
                } else{ //if update got failed
                    helper.showToast({
                        "title": "Ошибка",
                        "type": "error",
                        "message": "Поле Причина не может быть пустым "
                    });
                }
            }
        });
        $A.enqueueAction(action);
        $A.get("e.force:closeQuickAction").fire();
    }
 
 
 })