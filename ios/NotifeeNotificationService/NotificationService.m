//
//  NotificationService.m
//  NotifeeNotificationService
//
//  Created by sushil bansal on 28/01/2024.
//

#import "NotificationService.h"
// @notifee/react-native changes Start - custom Extension 
#import "NotifeeExtensionHelper.h"
// @notifee/react-native changes End  - custom Extension 

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    // self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    
    // self.contentHandler(self.bestAttemptContent);
    // @notifee/react-native changes Start - custom Extension  
    [NotifeeExtensionHelper populateNotificationContent:request
                                withContent: self.bestAttemptContent
                                withContentHandler:contentHandler];
    // @notifee/react-native changes End  - custom Extension 

}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
