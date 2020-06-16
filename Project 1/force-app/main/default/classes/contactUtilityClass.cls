public with sharing class contactUtilityClass {
    
    public static List<Contact> newAddress(List<Contact> cons){

        List<Address__c> addressList = new List<Address__c>();

        for (Contact c : cons) {
            Address__c newAddress = new Address__c(Name = c.FirstName + ' ' + c.LastName, Street_Address__C = c.MailingStreet,
                                                    City__c = c.MailingCity, State__c = c.MailingState,
                                                    Zip_Code__c = c.MailingPostalCode, Contact__c = c.Id);
            addressList.add(newAddress);
        }

        insert addressList;

        return cons;

    }

    public static List<Contact> updateAddress(List<Contact> cons){

        List<Id> conIds = new List<Id>();

        for (Contact c : cons) {

            conIds.add(c.Id);
            
        }

        List<Address__c> conAddresses = new List<Address__c>([SELECT Street_Address__C, City__c, State__c, Zip_Code__C
                                                                FROM Address__c WHERE Contact__c IN :conIds]);

        for (Address__c a: conAddresses){
            
            for (Contact c : cons){

                if (a.Street_Address__C != c.MailingStreet || 
                    a.City__c != c.MailingCity||
                    a.State__c != c.MailingState||
                    a.Zip_Code__c != c.MailingPostalCode) {

                        a.Street_Address__C = c.MailingStreet; 
                        a.City__c = c.MailingCity;
                        a.State__c = c.MailingState;
                        a.Zip_Code__c = c.MailingPostalCode;
                    
                }
            }
        }

        update conAddresses;

        return cons;

    }

}
