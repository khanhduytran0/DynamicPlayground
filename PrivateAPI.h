@import UIKit;

@interface NSSet(private)
- (NSArray *)allObjectsWithClass:(Class)class;
@end

@interface SBReachabilityManager : NSObject
@end

@interface SBSystemApertureLayoutMonitorServer : NSObject
@end

@interface SBSystemAperturePortalSourceInfoRequestServer : NSObject
@end

@interface SBSSystemApertureSceneCreationRequestServer : NSObject
@end

@interface SBSystemApertureStatusBarPillElementProvider : NSObject
@end

@interface SBFTraitsArbiter : NSObject
@end


@interface SBAccessoryWindowScene : UIWindowScene
// SBWindowScene
@property(nonatomic) UIWindowScene *associatedWindowScene;
@end

@interface SBSystemApertureWindowScene : SBAccessoryWindowScene
@end

@interface SBSystemApertureCurtainWindowScene : SBAccessoryWindowScene
@end

@interface SBApplicationLaunchNotifyAirplaneModeAlertItem : NSObject
@end

@interface SBUISystemApertureTextContentProvider : NSObject
- (id)initWithText:(NSString *)text style:(NSInteger)style;
@end

@interface SBAlertProvidedContentElement : NSObject
- (id)initWithIdentifier:(id)identifier contentProvider:(id)provider;
@end

@interface SBSystemApertureAlertItemPresenter : NSObject
- (instancetype)initWithSystemApertureController:(id)controller;
- (void)presentAlertItem:(id)item animated:(BOOL)animated completion:(id)completion;
@end

@interface SBSystemApertureController : NSObject
- (instancetype)initWithWindowScene:(id)scene;
- (void)createHighLevelWindowSceneWithDisplayConfiguration:(id)config;
- (void)createSuperHighLevelCurtainWindowSceneWithDisplayConfiguration:(id)config;

- (void)createHighLevelSystemApertureWindowWithWindowScene:(id)scene;
- (void)createSuperHighLevelCurtainWithWindowScene:(id)scene;

- (id)scenesForBacklightSession;
- (NSArray<UIWindow *> *)participantAssociatedWindows:(id)arg;
@end

@interface SBFTouchPassThroughWindow : UIWindow
- (instancetype)initWithWindowScene:(id)scene role:(id)role debugName:(id)name;
@end

@interface SBSystemApertureWindow : SBFTouchPassThroughWindow
@end
/*
@implementation SBSystemApertureWindow(hack)
- (instancetype)initWithWindowScene:(id)scene role:(id)role debugName:(id)name {
    UIWindowScene *appScene = (id)UIApplication.sharedApplication.connectedScenes.anyObject;
    return [super initWithWindowScene:appScene role:role debugName:name];
}
@end
*/

@interface FBSSceneSettings : NSObject
- (id)displayConfiguration;
@end

@interface FBSScene : NSObject
- (FBSSceneSettings *)settings;
@end

@interface UISceneConnectionOptions(private)
- (FBSScene *)_fbsScene;
@end

