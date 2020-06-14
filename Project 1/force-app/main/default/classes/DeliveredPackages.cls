public with sharing class DeliveredPackages {
    private final Package__c pack;
    Id userId = UserInfo.getUserId();
    
    public DeliveredPackages(ApexPages.StandardSetController controller) {
        this.pack = (Package__c)controller.getRecord();
    }

    public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                User userContactId = [SELECT Contact.id FROM USER WHERE ID = :userId];
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Name, Destination__c, Receiver__c , 
                                                                                                Destination__r.Street_Address__c,
                                                                                                Destination__r.city__c,
                                                                                                Destination__r.State__c, 
                                                                                                Destination__r.Zip_Code__c                                                                                                
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
<<<<<<< HEAD
=======
    
     
    public ID getUserId(){
        return this.userId;
    }
>>>>>>> 8b84030717e35279c0ccd21fcde20770282180ed
}