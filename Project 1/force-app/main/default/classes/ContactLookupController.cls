public class ContactLookupController {
    public string inputEmail { get; set; }
    public string inputFirstName { get; set; }        
    public string inputLastName { get; set; }
    public Contact con {get;set;}
    
    //con =[SELECT Name, Email, Phone, MailingAddresscombined__c FROM Contact WHERE Email like :inputEmail LIMIT 1];
    
    public ContactLookupController(){
        con =[SELECT firstName, lastname, Email, Phone, MailingAddresscombined__c FROM Contact WHERE Email =:inputEmail LIMIT 1];
    }
    
    public PageReference ContactLookupInputPage(){
            
            return Page.ContactLookupInputPage;
        }
    

    public PageReference showResults(){
  	con =[SELECT firstName, lastname, Email, Phone, MailingAddresscombined__c, MailingStreet, MailingState, MailingPostalCode FROM Contact WHERE Email = :inputEmail LIMIT 1];
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