public class getAllCountryQueueable implements Queueable,Database.AllowsCallouts{
    
    public void execute(QueueableContext qc){
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:GetAllCountryLayer');
        req.setMethod('GET');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        System.debug('res'+res);
        Map<String, Country__c > countryMap = new Map<String, Country__c>(); 
        
        for(Country__c obj : [SELECT Id,Name, alpha2code__c, alpha3code__c, Capital_city__c, Region__c ,regionalBlocs__c FROM Country__c]){
            countryMap.put(obj.Name,obj);
        }
        
        List<Country__c> upertList = new List<Country__c>();
        if(res.getStatusCode() == 200){
        
            List<JSONcountrylayer> countries = JSONcountrylayer.parse(res.getBody());
            for(JSONcountrylayer obj : countries){
                String acronym = obj.regionalBlocs != null && !obj.regionalBlocs.isEmpty() ? obj.regionalBlocs[0].acronym : '';
                if(countryMap.containsKey(obj.name)){
                    Country__c oldRecord = countryMap.get(obj.name);
                    if(oldRecord.Name != obj.name || oldRecord.alpha2code__c != obj.alpha2Code || oldRecord.alpha3code__c != obj.alpha3Code || oldRecord.Capital_city__c != obj.region || oldRecord.Region__c != obj.region || oldRecord.regionalBlocs__c != acronym){
                        
                        Country__c newrecord = new Country__c(Id = oldRecord.Id ,Name = obj.name, alpha2code__c = obj.alpha2Code, alpha3code__c = obj.alpha3Code, Capital_city__c = obj.region, Region__c = obj.region, regionalBlocs__c = acronym);
                        upertList.add(newrecord);
                    
                    }
                
                } else {
                
                    Country__c newrecord = new Country__c(Name = obj.name, alpha2code__c = obj.alpha2Code, alpha3code__c = obj.alpha3Code, Capital_city__c = obj.region, Region__c = obj.region, regionalBlocs__c = acronym);
                    upertList.add(newrecord);
                   
                }
            }
            
            if(!upertList.isEmpty()){
                upsert upertList;
            }
            
         }   
        
    }
    
   
}