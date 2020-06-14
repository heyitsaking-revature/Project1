public with sharing class OpenTickets {

    private final Case openCase;

    public OpenTickets(ApexPages.StandardSetController controller){

        this.openCase = (Case)controller.getRecord();
    }

    public static List<Case> getOpenTickets(){

        String currentUser = userInfo.getUserId();

        User currentContactInfo = [SELECT Contact.Id, Id From User WHERE Id = :currentUser];

        return [SELECT Subject, Description, External_Comments__c, ContactId FROM Case WHERE ContactId = :currentContactInfo.Contact.Id];

    }
}
