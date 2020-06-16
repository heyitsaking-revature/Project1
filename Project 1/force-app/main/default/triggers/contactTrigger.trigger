trigger contactTrigger on Contact (after insert, before update) {

    if (trigger.isInsert) {
        contactUtilityClass.newAddress(trigger.new);
    }
    else if (trigger.isupdate) {
        contactUtilityClass.updateAddress(trigger.new);
    }

}