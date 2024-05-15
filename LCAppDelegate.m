#import "LCAppDelegate.h"
#import "LCJITLessSetupViewController.h"
#import "LCTabBarController.h"

@implementation LCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIViewController *viewController;
    UIApplicationShortcutItem *shortcutItem = [launchOptions objectForKey:UIApplicationLaunchOptionsShortcutItemKey];
    if (shortcutItem) {
        [self handleShortcutItem:shortcutItem];
    }
    if ([NSBundle.mainBundle.executablePath.lastPathComponent isEqualToString:@"JITLessSetup"]) {
        viewController = [[LCJITLessSetupViewController alloc] init];
        _rootViewController = [[UINavigationController alloc] initWithRootViewController:viewController];
    } else {
        _rootViewController = [[LCTabBarController alloc] init];
    }
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController = _rootViewController;
    [_window makeKeyAndVisible];
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    BOOL handled = [self handleShortcutItem:shortcutItem];
    if (completionHandler) {
        completionHandler(handled);
    }
}

- (BOOL)handleShortcutItem:(UIApplicationShortcutItem *)shortcutItem {
    BOOL handled = NO;
    
    if ([shortcutItem.type isEqualToString:@"com.kdt.livecontainer-clone.settings"]) {
        lcUserDefaults = NSUserDefaults.standardUserDefaults;
        [lcUserDefaults removeObjectForKey:@"selected"];
        [lcUserDefaults synchronize];
        handled = YES;
    }
    
    return handled;
}
@end
