#import "LCSettingsListController.h"
#import "LCUtils.h"
#import "UIViewController+LCAlert.h"

@implementation LCSettingsListController

- (NSMutableArray*)specifiers {
    if(!_specifiers) {
        _specifiers = [NSMutableArray new];
        
        PSSpecifier* jitlessGroup = [PSSpecifier emptyGroupSpecifier];
        jitlessGroup.name = @"JIT-less";
        [jitlessGroup setProperty:@"JIT-less allows you to use LiveContainer without having to enable JIT. Requires SideStore." forKey:@"footerText"];
        [_specifiers addObject:jitlessGroup];

        NSString *setupJITLessButtonName = LCUtils.certificateData ? @"Renew JIT-less certificate" : @"Setup JIT-less certificate";
        PSSpecifier* setupJITLessButton = [PSSpecifier preferenceSpecifierNamed:setupJITLessButtonName target:self set:nil get:nil detail:nil cell:PSButtonCell edit:nil];
        setupJITLessButton.identifier = @"setup-jitless";
        setupJITLessButton.buttonAction = @selector(setupJITLessPressed);
        [_specifiers addObject:setupJITLessButton];

        PSSpecifier* signTweaksButton = [PSSpecifier preferenceSpecifierNamed:@"Sign tweaks" target:self set:nil get:nil detail:nil cell:PSButtonCell edit:nil];
        signTweaksButton.identifier = @"sign-tweaks";
        [signTweaksButton setProperty:@(!!LCUtils.certificateData) forKey:@"enabled"];
        signTweaksButton.buttonAction = @selector(signTweaksPressed);
        [_specifiers addObject:signTweaksButton];

        PSSpecifier* generalGroup = [PSSpecifier emptyGroupSpecifier];
        generalGroup.name = @"General";
        [generalGroup setProperty:@"You can deselect app by iOS Settings.app" forKey:@"footerText"];
        [_specifiers addObject:generalGroup];

         // Add a new toggleable setting
        PSSpecifier* launchSelectedAppToggle = [PSSpecifier preferenceSpecifierNamed:@"Always Launch Selected App" target:self set:@selector(setToggleState:specifier:) get:@selector(getToggleState:) detail:nil cell:PSSwitchCell edit:nil];
        launchSelectedAppToggle.identifier = @"toggleLaunchSelectedApps";
        [launchSelectedAppToggle setProperty:@"toggleLaunchSelected" forKey:@"key"];
        [launchSelectedAppToggle setProperty:@NO forKey:@"default"];
        [_specifiers addObject:launchSelectedAppToggle];

        PSSpecifier* generalGroup = [PSSpecifier emptyGroupSpecifier];
        generalGroup.name = @"Sort";
        [_specifiers addObject:generalGroup];

        PSSpecifier* sortAscending = [PSSpecifier preferenceSpecifierNamed:@"Sort Ascending" target:self set:@selector(setSortOrder:specifier:) get:@selector(getSortOrder:) detail:nil cell:PSSwitchCell edit:nil];
        sortAscending.identifier = @"sort-ascending";
        [sortAscending setProperty:@YES forKey:@"default"];
        [_specifiers addObject:sortAscending];

        // Add descending sorting option
        PSSpecifier* sortDescending = [PSSpecifier preferenceSpecifierNamed:@"Sort Descending" target:self set:@selector(setSortOrder:specifier:) get:@selector(getSortOrder:) detail:nil cell:PSSwitchCell edit:nil];
        sortDescending.identifier = @"sort-descending";
        [sortDescending setProperty:@NO forKey:@"default"];
        [_specifiers addObject:sortDescending];
    }
    return _specifiers;
}

- (void)setupJITLessPressed {
    if (!LCUtils.isAppGroupSideStore) {
        [self showDialogTitle:@"Error" message:@"Unsupported installation method. Please use SideStore to setup this feature."];
        return;
    }

    NSError *error;
    NSURL *url = [LCUtils archiveIPAWithSetupMode:YES error:&error];
    if (!url) {
        [self showDialogTitle:@"Error" message:error.localizedDescription];
        return;
    }

    [UIApplication.sharedApplication openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sidestore://install?url=%@", url]] options:@{} completionHandler:nil];
}

- (void)signTweaksPressed {
    
}

- (void)setToggleState:(id)value specifier:(PSSpecifier*)specifier {
    [[NSUserDefaults standardUserDefaults] setBool:[value boolValue] forKey:[specifier propertyForKey:@"key"]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)getToggleState:(PSSpecifier*)specifier {
    return @([[NSUserDefaults standardUserDefaults] boolForKey:[specifier propertyForKey:@"key"]]);
}

- (void)setSortOrder:(id)value specifier:(PSSpecifier*)specifier {
    [[NSUserDefaults standardUserDefaults] setBool:[value boolValue] forKey:@"sort-ascending"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (id)getSortOrder:(PSSpecifier*)specifier {
    return @([[NSUserDefaults standardUserDefaults] boolForKey:@"sort-ascending"]);
}

@end
