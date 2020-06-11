public class PackageLookupController {
    public list <Package__c> pack {get;set;}
    public String name {get;set;}
    public PackageLookupController( ) {
    }
    public void search(){
        pack= [SELECT Name, Receiver__r.Name, Destination__r.Mailing_Address__c, Status__c FROM Package__c WHERE Name = :name];
    }
    public void clear(){
        pack.clear();
    }
}