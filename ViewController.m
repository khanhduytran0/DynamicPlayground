@import Darwin;
#import "PrivateAPI.h"
#import "ViewController.h"
#include <dlfcn.h>
#include <mach/mach.h>
#include <sys/mman.h>

@implementation SBReachabilityManager(hack)
+ (instancetype)sharedInstance {
    return nil;
}
@end

@implementation SBSystemApertureLayoutMonitorServer(hack)
- (id)initWithDelegate:(id)delegate {
    return nil;
}
@end

@implementation SBSystemAperturePortalSourceInfoRequestServer(hack)
- (id)initWithPortalSource:(id)delegate {
    return nil;
}
@end

@implementation SBSSystemApertureSceneCreationRequestServer(hack)
- (void)startServer {}
@end

@implementation SBSystemApertureStatusBarPillElementProvider(hack)
- (void)activateWithRegistrar:(id)r {}
@end

@implementation SBFTraitsArbiter(hack)
- (id)acquireParticipantWithRole:(id)role delegate:(id)delegate {
    return nil;
}
@end

@implementation UIStatusBarManager(hack)
- (void)setAvoidanceFrame:(CGRect)frame reason:(id)reason statusBar:(id)statusBar animationSettings:(id)settings options:(NSUInteger)options {}
- (void)setAvoidanceFrame:(CGRect)frame reason:(id)reason statusBar:(id)statusBar animationSettings:(id)settings {}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    self.title = @"DynamicPlayground";
    self.navigationItem.rightBarButtonItems = @[
        [[UIBarButtonItem alloc] initWithTitle:@"Show alert" style:UIBarButtonItemStylePlain target:self action:@selector(test)]
    ];

    self.presenter = [[SBSystemApertureAlertItemPresenter alloc] initWithSystemApertureController:self.controller];

/*
    //SBUISystemApertureTextContentProvider *provider = [[_c(SBUISystemApertureTextContentProvider) alloc] initWithText:@"My text is here" style:0];
    //SBAlertProvidedContentElement *element = [[_c(SBAlertProvidedContentElement) alloc] initWithIdentifier:item contentProvider:provider];
*/
}

- (void)test {
    SBApplicationLaunchNotifyAirplaneModeAlertItem *item = [SBApplicationLaunchNotifyAirplaneModeAlertItem new];
    [self.presenter presentAlertItem:item animated:YES completion:nil];
}

@end
