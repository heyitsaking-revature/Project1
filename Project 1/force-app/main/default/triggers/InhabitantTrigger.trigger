trigger InhabitantTrigger on Inhabitant__c (before insert) {

    InhabitantUtility.findAccounts(Trigger.new);
    
}