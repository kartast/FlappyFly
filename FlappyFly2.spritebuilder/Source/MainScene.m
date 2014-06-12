//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
static const CGFloat scrollSpeed = 80.f;
@implementation MainScene {
    CCSprite * _hero;
    CCPhysicsNode * _physicsNode;
    CCNode *_ground1;
    CCNode *_ground2;
    NSArray *_grounds;
}
- (void)didLoadFromCCB {
    _grounds = @[_ground1, _ground2];
    self.userInteractionEnabled = TRUE;
}
- (void)update:(CCTime)delta {
    _hero.position = ccp(_hero.position.x + delta*scrollSpeed, _hero.position.y);
    _physicsNode.position = ccp(_physicsNode.position.x - (scrollSpeed * delta), _physicsNode.position.y);
    
    for (CCNode *ground in _grounds) {
        // get the world position of ground
        CGPoint groundWorldPosition = [_physicsNode convertToWorldSpace:ground.position];
        // get the screen position of the ground
        CGPoint groundScreenPosition = [self convertToNodeSpace:groundWorldPosition];
        // if the lf
        if (groundScreenPosition.x <= (-1 * ground.contentSize.width)) {
            ground.position = ccp(ground.position.x + 2 * ground.contentSize.width, ground.position.y);
        }
    }
}
- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    [_hero.physicsBody applyImpulse:ccp(0, 400.f)];
    
    float yVelocity = clampf(_hero.physicsBody.velocity.y, -1 * MAXFLOAT, 200.f);
    _hero.physicsBody.velocity = ccp(0, yVelocity);
}
@end
