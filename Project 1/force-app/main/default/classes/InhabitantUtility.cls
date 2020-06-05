public class InhabitantUtility {

    @InvocableMethod
    public static List<Inhabitant__c> findAccounts(List<Inhabitant__c> c){
        
        //Variable declaration: Note that many variables are both in a Map and a List so they can be compared using the list
        //but used to linked back through the chain using the Map
        List<String> conName = new List<String>();

        List<Contact> conList = new List<Contact>();

        List<String> adrsName = new List<String>();

        List<String> shipAdrs = new List<String>();

        Map<String, String> adrsConMap = new Map<String, String>();

        Map<String, String> conIdMailsMap = new Map<String, String>();

        Map<Contact, String> conObjMailMap = new Map<Contact , String>();

        Map<String, String> accAdrMap = new Map<String, String>();

        for (Inhabitant__c i : c) {
            
            //A link between address ids and contact ids is made in order to make a link between contact ids and mailing addresses later
            adrsConMap.put(i.Address__c, i.Contact__c);

            //Address ids will be used to pull the address records in order to get the mailing addresses
            adrsName.add(i.Address__c);

            //This is only the contact id and needs to be placed seperate to allow us to look up the Contact records
            conName.add(i.Contact__c);
            
            
        }

        for (Address__c a : [SELECT Mailing_Address__c, Id FROM Address__c WHERE Id IN :adrsName]) {

            //Contact ids are linked with the associated mailing addresses 
            conIdMailsMap.put(adrsConMap.get(a.Id), a.Mailing_Address__c);
            
        }

        for (Contact con : [SELECT Name, Id, AccountId FROM Contact WHERE Id IN :conName]) {

            //List of contacts that have possible associated accounts
            conList.add(con);

            //Contact ids are used with their linked mailing addresses to link the contact records with the mailing addresses
            conObjMailMap.put(con, conIdMailsMap.get(con.Id));
            
        }

        for (Account a : [SELECT ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, Name, Id FROM Account]) {

            //Shipping address is saved for comparative reasons
            shipAdrs.add(a.ShippingStreet+', '+a.ShippingCity+', '+a.ShippingState+' '+a.ShippingPostalCode);

            //Shipping address is being used as the key to place the Account ids on contacts in a later step
            accAdrMap.put(a.ShippingStreet+', '+a.ShippingCity+', '+a.ShippingState+' '+a.ShippingPostalCode, a.Id);
            
        }

        for (Contact con : conList) {
            
            Integer count = 0;

            //This then sets the Account on a Contact where the Contact's mailing address matches the accounts shipping address
            while (count < shipAdrs.size()) {

                if (conObjMailMap.get(con) == shipAdrs.get(count) && con.AccountId == null){

                	con.AccountId = accAdrMap.get(conObjMailMap.get(con));

                }
                
                count++;
                
            }
            
        }

        //While not best practice there is currently no trigger on the contact object to cause recursion
        Database.update(conList, false);

        return c;
    }
}