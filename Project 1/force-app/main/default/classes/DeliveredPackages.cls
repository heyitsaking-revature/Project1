public class DeliveredPackages {
    private final Package__c pack;
    Id userId = UserInfo.getUserId();
    
    public DeliveredPackages(ApexPages.StandardSetController controller) {
        this.pack = (Package__c)controller.getRecord();
    }

    public ApexPages.StandardSetController setCon {
        get {
            if(setCon == null) {
                User userContactId = [SELECT Contact.id FROM USER WHERE ID = :userId];
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT Destination__c, Receiver__c , 
                                                                                                Destination__r.Street_Address__c,
                                                                                                Destination__r.city__c,
                                                                                                Destination__r.State__c, 
                                                                                                Destination__r.Zip_Code__c                                                                                                
                                                                                        FROM Package__c
                                                                                        WHERE Status__c = 'Delivered'
                                                                                        AND Receiver__c = :userContactId.Contact.id]));
            }
            return setCon;
        }
        set;
    }

    public Boolean deliveredNext {
        get {
            return setCon.getHasNext();
        }
        set;
    }

    public Boolean deliveredPrevious {
        get {
            return setCon.getHasPrevious();
        }
        set;
    }
    
    public List<Package__c> getDeliveredPackage() {
        return (List<Package__c>) setCon.getRecords();
    }
}
