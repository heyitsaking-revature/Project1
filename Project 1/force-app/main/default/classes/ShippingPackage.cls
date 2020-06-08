public class ShippingPackage {

    
    public static List<Package__c> getShippingPackage(Id userId){
		
        User userContactId = [Select Contact.id FROM USER WHERE ID = :userId] ;   
        
        List<Package__C> listPack = [SELECT Name, Destination__c, Receiver__c , Destination__r.Street_Address__c,
                                            Destination__r.city__c, Destination__r.State__c, Destination__r.Zip_Code__c
                                     FROM Package__c
                                     WHERE Status__c = 'Shipping' AND
                                        (Sender__c = :userContactId.ContactId OR
                                    	Receiver__c = :userContactId.ContactId)] ; 
        
        return listPack;

    }
   
}