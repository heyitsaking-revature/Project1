public class ContactLookupController {
   Private final Contact con;
    
   //public id userId = UserInfo.getUserId();    
 
    public id userId = '0054S000001373A';
    Public contact currentUser;
    
    public ContactLookupController(){
    
       User userContactId = [SELECT Contact.id FROM User WHERE ID = :userId];
        Id contactid = userContactId.ContactId;
        this.con = [SELECT Id, firstname, Lastname, phone, email, MailingStreet, MailingCity, MailingState, MailingPostalCode,Mailingaddresscombined__c FROM contact WHERE ID =:contactId];
        
        }
    
   public Contact getCon(){
        
      return this.con;
    }
    
    
    public PageReference ContactSearch(){
        
        return Page.ContactSearch;
    }
    

    public PageReference showResults(){
                     
        return Page.showResults;
    }
    
    public PageReference save() {
        upsert con;
        return null;
    }

    public PageReference updateResults(){
        
        return page.updateResults;
      
    }
}