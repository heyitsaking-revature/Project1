public class DeliveredPackages {
    private final Package__c pack;
    Id userId = UserInfo.getUserId();;
    
    public DeliveredPackages(StandardController stdController) {
        this.pack = (Package__c)stdController.getRecord();
    }

    public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                Contact contactInfo = [SELECT MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry FROM Contact WHERE Id IN (SELECT ContactId FROM User WHERE Id = :userId)];

                setCon = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Name, Destination__c.MailingAddress
                                                                                        FROM Package__c
                                                                                        WHERE Status__c = 'Delivered' AND
                                                                                            (Destination__c.Street == contactInfo.MailingStreet AND
                                                                                            Destination__c.City == contactInfo.MailingCity AND
                                                                                            Destination__c.State == contactInfo.MailingState AND
                                                                                            Destination__c.PostalCode == contactInfo.MailingPostalCode AND
                                                                                            Destination__c.Country == contactInfo.MailingCountry)]));
            }
            return setCon;
        }
        set ;
    }
    
    public static List<Package__c> getDeliveredPackage() {
        return (List<Package__c>) setCon.getRecords();
    }
}
