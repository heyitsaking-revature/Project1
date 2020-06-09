trigger CheckForRelatedAccount on Contact (before insert) {
    if (Trigger.isBefore){
        if(Trigger.isInsert) {
            MatchingAccount.check(Trigger.New);
        }
    }
}