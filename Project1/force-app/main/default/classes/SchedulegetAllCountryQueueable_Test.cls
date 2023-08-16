@isTest
public class SchedulegetAllCountryQueueable_Test {
    
    @isTest static void executeTest(){
        
        Test.setMock(HttpCalloutMock.class, new MockHttpCountryGenerator());
         
        SchedulableContext sc = null;
        SchedulegetAllCountryQueueable tsc = new SchedulegetAllCountryQueueable();
        tsc.execute(sc);
         
    }  
    
}