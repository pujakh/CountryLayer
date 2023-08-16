public class SchedulegetAllCountryQueueable implements Schedulable {

    public void execute(SchedulableContext sc) {
        ID jobId = System.enqueueJob(new getAllCountryQueueable());
    }
}