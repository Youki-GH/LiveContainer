#import "LCAppDelegate.h"
#import "LCJITLessSetupViewController.h"
#import "LCTabBarController.h"

@implementation LCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIViewController *viewController;
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

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIApplicationShortcutItem *shortcutItem = [launchOptions objectForKey:UIApplicationLaunchOptionsShortcutItemKey];
    if (shortcutItem) {
        [self handleShortcutItem:shortcutItem];
        return NO;
    }
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
        [NSUserDefaults.standardUserDefaults removeObjectForKey:@"selected"];
        handled = YES;
    }
    
    return handled;
}
@end
