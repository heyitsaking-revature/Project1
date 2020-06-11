public with sharing class ShippingPackage {
    private final Package__c pack;
 	ID userID = System.UserInfo.getUserId();
           
    public ShippingPackage(ApexPages.StandardSetController controller) {
        this.pack = (Package__c)controller.getRecord(); 
    }
    
<<<<<<< HEAD
    public ApexPages.StandardSetController setCon{
       
=======
    public ApexPages.StandardSetController setCon {
>>>>>>> 47199e246e2bc8727aee5222ebf275d432b89af3
        get {
            if(setCon == null) {
                
                User userContactId = [Select Contact.id FROM USER WHERE ID = :userId] ;   
                System.debug(userContactId); 
                setCon = new ApexPages.StandardSetController(Database.getQueryLocator(
                    [SELECT  Receiver__r.Name , Destination__r.Street_Address__c,
                                            Destination__r.city__c, Destination__r.State__c, Destination__r.Zip_Code__c, Insurance__c
                                     FROM Package__c
                                  WHERE Status__c = 'Shipping' 
                                    AND Receiver__c = :userContactId.ContactId
                                    	] ));
            }
            return setCon;
        }
        set;
        
    }
    
    public List<Package__c> getShippingPackage() {

        return (List<Package__c>) setCon.getRecords();

    }  
    
<<<<<<< HEAD
    public Boolean hasNext{
        get {
            return setCon.getHasNext();
        }
        set;
    }
=======
>>>>>>> 47199e246e2bc8727aee5222ebf275d432b89af3

    public Boolean hasPrevious {
        get {
            return setCon.getHasPrevious();
        }
        set;
    }
    

}