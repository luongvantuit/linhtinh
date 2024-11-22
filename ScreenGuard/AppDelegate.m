//
//  AppDelegate.m
//  ScreenGuard
//
//  Created by tus on 7/11/24.
//

#import "AppDelegate.h"

@interface AppDelegate ()
//@property (strong, nonatomic) UIView *privacyView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

//- (void)applicationWillResignActive:(UIApplication *)application {
//    // Add a privacy screen when the app goes to the background
//    if (!self.privacyView) {
//        self.privacyView = [[UIView alloc] initWithFrame:self.window.bounds];
//        self.privacyView.backgroundColor = [UIColor blackColor]; // You can use a blurred image here too
//    }
//    [self.window addSubview:self.privacyView];
//}
//
//- (void)applicationDidBecomeActive:(UIApplication *)application {
//    // Remove the privacy screen when the app becomes active
//    [self.privacyView removeFromSuperview];
//    self.privacyView = nil;
//}


@end
