trigger OpportunityTrigger on Opportunity (after insert, after update) {
    if (Trigger.isUpdate) {        
        OpportunityHelper.createChildOpportunity(Trigger.new, Trigger.oldMap);
        OpportunityHelper.createNewTask(Trigger.new, Trigger.oldMap);
        OpportunityHelper.createNewAssets(Trigger.new);
    }
    if (Trigger.IsInsert) {
        //OpportunityHelper.createJunk(Trigger.new);
    }
}