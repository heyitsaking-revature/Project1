public class ShippingPackage {

    
<<<<<<< HEAD
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
                                                                                        WHERE Status__c = 'Shipping' 
                                                                                        AND Receiver__c = :userContactId.ContactId] ));
            }
            return setCon;
        }
        set;
    }
    
    public List<Package__c> getShippingPackage() {
        return (List<Package__c>) setCon.getRecords();
    }    
    
=======
    public static List<Package__c> getShippingPackage(Id userId){
        
        User userContactId = [Select Contact.id FROM USER WHERE ID = :userId] ;   
        
        List<Package__C> listPack = [SELECT Name, Destination__c, Destination__r.Street_Address__c,
                                            Destination__r.city__c, Destination__r.State__c, Destination__r.Zip_Code__c
                                     FROM Package__c
                                  WHERE Status__c = 'Shipping'] ; 
        
        return listPack;
>>>>>>> 37cf249369bcab3893c34bdb651f76ac0ab3fa3e

    }
   
}