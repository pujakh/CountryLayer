@isTest
private class getAllCountryQueueableTest {

     @isTest static void testgetAllCountryQueueable() {
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpCountryGenerator());
        ID jobID = System.enqueueJob(new getAllCountryQueueable());
     }
     
     @isTest static void testUpdategetAllCountryQueueable() {
     
        Country__c countryGen = new Country__c();
        countryGen.Name = 'Germany';
        
        insert countryGen;
         
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MockHttpCountryGenerator());
        ID jobID = System.enqueueJob(new getAllCountryQueueable());
     }
}