public with sharing class OpenTickets {

    private final Case openCase;

    public ID userId = System.UserInfo.getUserId();

    public OpenTickets(ApexPages.StandardSetController controller){

        this.openCase = (Case)controller.getRecord();
    }

    public ApexPages.StandardSetController setcon {

        get{
            if (setcon == null) {
                User userContactId = [Select Contact.id FROM USER WHERE ID = :userId] ;
                setcon = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Subject, Description, 
                                                                                              External_Comments__c, ContactId 
                                                                                        FROM Case 
                                                                                        WHERE ContactId = :userContactId.ContactId]));
            }
            return setcon;
        }
        set;
    }

    public List<Case> getOpenTicket() {
        return (List<Case>) setcon.getRecords();
    }
}