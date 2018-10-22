public class LoggerService {
    public static AppLogger getAppLoggerInterface() {
        Logger_Setting__mdt activeLogger = [SELECT LoggerService__c FROM Logger_Setting__mdt LIMIT 1];
        return (AppLogger)Type.forName(activeLogger.LoggerService__c).newInstance();
    }
}
