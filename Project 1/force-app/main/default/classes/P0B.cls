/////////////////////////////////////////////////////////////////
 //
 // Name: Project 0 Bravo
 // Author: Gabriel Cohavy (gcohavy@ucla.edu)
 // Date: 05/20/2020
 // Description: Series of apex methods to demonstrate
 // basic understanding of coding concepts.
 //
 /////////////////////////////////////////////////////////////////

public with sharing class P0B {
    //Method #1
    public static Integer nFibonacci(Integer n){
        if ( n==0 ) {
            return 0;
        } else if ( n==1 ) {
            return 1;
        } else {
            Double phi = ( Math.sqrt(5) + 1 ) / 2;
            Double temp = ( Math.pow(phi,n) - Math.pow(-phi,-n) ) / Math.sqrt(5);
            Integer result = Integer.valueOf( Math.rint(temp) );
            System.debug( 'Result: ' + result );
            return result;
        }
    }

    //Method #2
    public static List<Integer> sortList(List<Integer> intList){
        System.debug('Inputed list: ' + intList);
        List<Integer> resultList = new List<Integer>();
        Integer size = intList.size();
        Integer temp;
        
        for(Integer i = 0; i < size; i++){
            temp = intList[0];
            for ( Integer j = 0; j < intlist.size(); j++ ) {
                if(temp > intList[j]) {
                    temp = intList[j];
                }
            }
            resultList.add(temp);
            for ( Integer j = 0; j < intlist.size(); j++ ) {
                if ( temp == intList[j] ) {
                    intList.remove(j);
                    break;
                }
            }
        }
        
        System.debug('Final list: ' + resultList);
        return resultList;
    }

    //Method #3
    public static Integer nFactorial(Integer n) {
        if ( n == 0 ) {
            return 1;
        } else {
            Integer result = 1;
            for (Integer i = 1; i <= n ; i++) {
                result = result * i;
            }
            System.debug('Final result: ' + result);
            return result;
        }
    }

    //Method #4
    public static List<Integer> rotateLeftNTimes (List<Integer> nList, Integer n){
        Integer temp;
        List<Integer> newList = nList.clone();
        System.debug('Start: ' + newList);
        for ( Integer i = 0; i < n; i++ ) {
            temp = newList[0];
            newList.remove(0);
            newList.add(temp);
        }
        System.debug('End: ' + newList);
        return newList;
    }
    
    //Function to check brackets in Exercise # 5
    private static Boolean checker(List<String> ls, String ch) {
        if ( ls[ls.size() - 1] == ch) {
            ls.remove(ls.size() - 1);
            return true;
        } else {
            return false;
        }
    }
    
    //Method #5
    public static Boolean bracketsAreBalanced(String s){
        System.debug('String input: ' + s);
        String[] temp = s.split('');
        List<String> arr = new List<String>();
        Boolean result = true;
       
        for ( Integer i = 0; i < temp.size(); i++ ) {
            if (result == false) {
                System.debug('Result was false');
                return result;
            }
            switch on temp[i] {
                when '(', '{', '[' {
                    arr.add(temp[i]);
                }
                when ')' {
                    result = checker(arr, '(');
                }
                when '}' {
                    result = checker(arr, '{');
                }
                when ']' {
                    result = checker(arr, '[');
                }
            }
        }
        System.debug('Final check array: ' + arr);
        if(arr.size() > 0) result = false;
        System.debug('Result: ' + result);
        return result;
    }

    //Method #6
    public static void updateAccountSize(){
        Account[] accounts = [SELECT Name, NumberOfEmployees, Size__c FROM Account ];
        for (Account acc : accounts) {
            if (acc.NumberOfEmployees <= 1000 && acc.NumberOfEmployees > 0 ) {
                acc.size__c = 'Small';
            } else if (acc.NumberOfEmployees > 1000 && acc.NumberOfEmployees <= 10000) {
                acc.size__c = 'Medium';
            } else if (acc.NumberOfEmployees > 10000) {
                acc.size__c = 'Large';
            } else {
                System.debug('Number of employees is below 1');
            }
            System.debug('Account: ' + acc);
        }
        update accounts;
    }

    //Method #7
    public static void updateCALeads( ) {
        Lead[] leads = [SELECT ID, Name, Lead.State, Status, Description FROM Lead WHERE Lead.State LIKE '%ca%'];
        for (Lead L : leads) {
            System.debug('Before: ' + L);
            L.Status = 'Closed - Not Converted';
            L.Description = 'We are no longer doing business in California';
            System.debug('After: ' + L);
        }
        update leads;
    }   

    //Method #8
    public static void closePastDueOpportunities( ) {
        Date tod = Date.today();
        Opportunity[] opportunities = [SELECT Name, StageName, CloseDate FROM Opportunity WHERE CloseDate < :tod AND StageName != 'Closed Won'];
        for (Opportunity o : opportunities) {
            System.debug('Before: ' + o);
            o.StageName = 'Closed Lost';
            System.debug('After: ' + o);
        }
        update opportunities;
    }
}