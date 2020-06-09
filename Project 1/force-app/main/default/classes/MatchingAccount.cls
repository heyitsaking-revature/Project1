public class MatchingAccount {
    public static void check(List<Contact> contacts) {
        Contact c;
        if(contacts.size() == 1) {
            c = contacts[0];
        }
        System.debug(c);
        if(c.AccountId == null) {
            String address = c.MailingStreet + c.MailingCity + c.MailingState + 
                c.MailingPostalCode;
            String billingAddress = '';
            String shippingAddress = '';
            
            List<Account> accounts = [SELECT id, Name, BillingStreet, BillingCity,
                                      BillingState, BillingPostalCode,
                         			  ShippingStreet, ShippingCity, ShippingState,
                                      ShippingPostalCode, Phone FROM account];
            
            for(Account a : accounts){
                billingAddress = a.BillingStreet + a.BillingCity +
                    a.BillingState + a.BillingPostalCode;
                shippingAddress = a.ShippingStreet + a.ShippingCity +
                    a.ShippingState + a.ShippingPostalCode;
                System.debug(a.name + ': ' + billingAddress + '\n' + shippingAddress);
                
                if((c.MailingStreet != null && (address == billingAddress ||
                  address == shippingAddress)) ||
                  (c.phone != null && c.Phone == a.Phone)) {
                    c.AccountId = a.Id;
                }
            }
            if(c.AccountId != null) {
                Account test = [SELECT Name FROM account WHERE id = :c.AccountId];
                System.debug(test);
            }
        }
    }
}