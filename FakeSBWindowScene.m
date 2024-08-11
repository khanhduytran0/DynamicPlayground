#import "FakeSBWindowScene.h"
#import "PrivateAPI.h"

@implementation FakeSBWindowScene

- (SBFTraitsArbiter *)traitsArbiter {
    return [SBFTraitsArbiter new];
}

- (id)systemGestureManager {
    return nil;
}

- (id)zStackResolver {
    return nil;
}

@end
