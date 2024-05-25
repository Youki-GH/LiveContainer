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

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options {
    // Parse the URL
    NSURLComponents *urlComponents = [NSURLComponents componentsWithURL:url resolvingAgainstBaseURL:NO];

    // Check the path of the URL and call the appropriate function
    if ([urlComponents.host isEqualToString:@"deselectapp"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:[specifier propertyForKey:@"deselect_app"]];
        exit(0);
    }

    return YES;
}
@end
