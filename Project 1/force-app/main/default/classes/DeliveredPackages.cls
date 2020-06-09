public class DeliveredPackages {
    private final Package__c pack;
    Id userId = UserInfo.getUserId();
    
    public DeliveredPackages(ApexPages.StandardSetController controller) {
        this.pack = (Package__c)controller.getRecord();
    }

    public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                Contact contactInfo = [SELECT MailingStreet, MailingCity, MailingState, MailingPostalCode FROM Contact WHERE Id IN (SELECT ContactId FROM User WHERE Id = :userId)];

                setCon = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Name, Destination__r.Mailing_Address__c
                                                                                        FROM Package__c
                                                                                        WHERE Status__c = 'Delivered' AND
                                                                                            ((Destination__r.Street_Address__c = :contactInfo.MailingStreet) AND
                                                                                            (Destination__r.City__c = :contactInfo.MailingCity) AND
                                                                                            (Destination__r.State__c = :contactInfo.MailingState))]));
            }
            return setCon;
        }
        set;
    }
    
    public List<Package__c> getDeliveredPackage() {
        return (List<Package__c>) setCon.getRecords();
    }
}
