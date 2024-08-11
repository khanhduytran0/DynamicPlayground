#import "PrivateAPI.h"
#import "SceneDelegate.h"
#import "ViewController.h"

@implementation UINavigationBar(forceFullHeightInLandscape)

- (BOOL)forceFullHeightInLandscape {
  return YES;
}

@end

@interface SceneDelegate()

@property(nonatomic) SBSystemApertureController *controller;
@property(nonatomic) UIWindow *apertureWindow;

@end

@implementation SceneDelegate

- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    self.window.frame = windowScene.coordinateSpace.bounds;
    ViewController *vc = [[ViewController alloc] init];
    UINavigationController* c = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = c;
    [self.window makeKeyAndVisible];

    id configuration = connectionOptions._fbsScene.settings.displayConfiguration;

    self.controller = [[SBSystemApertureController alloc] initWithWindowScene:windowScene];
    [self.controller createHighLevelWindowSceneWithDisplayConfiguration:configuration];
    [self.controller createSuperHighLevelCurtainWindowSceneWithDisplayConfiguration:configuration];

    NSSet *apertureScenes = UIApplication.sharedApplication.connectedScenes;
    SBSystemApertureWindowScene *highLevelScene = [apertureScenes allObjectsWithClass:SBSystemApertureWindowScene.class].firstObject;
    highLevelScene.associatedWindowScene = (id)scene;
    [self.controller createHighLevelSystemApertureWindowWithWindowScene:highLevelScene];
    
    SBSystemApertureCurtainWindowScene *superHighLevelScene = [apertureScenes allObjectsWithClass:SBSystemApertureCurtainWindowScene.class].firstObject;
    superHighLevelScene.associatedWindowScene = (id)scene;
    [self.controller createSuperHighLevelCurtainWithWindowScene:superHighLevelScene];

    vc.controller = self.controller;
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}

@end
