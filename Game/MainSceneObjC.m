//
//  MainSceneObjC.m
//  Game iOS
//
//  Created by pragmus on 30/06/2019.
//  Copyright © 2019 Apportable. All rights reserved.
//

#import "MainSceneObjC.h"
#import "CCSprite.h"
#import "XMLDataProvider.h"

@implementation MainSceneObjC

- (instancetype)init
{
    self = [super init];
    if (self) {
//        CCSprite *sprite = [CCSprite spriteWithImageNamed:@"ic_launcher.png"];
//        sprite.position = ccp(0.5, 0.5);
//        sprite.positionType = CCPositionTypeNormalized;
//        [self addChild:sprite];
//
//        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"ArialMT" fontSize:16];
//        label.position = ccp(0.5, 0.25);
//        label.positionType = CCPositionTypeNormalized;
//        [self addChild:label];
        
        // Load background image
        CCSprite *background = [CCSprite spriteWithImageNamed:@"_room.png"];
        background.anchorPoint = ccp(0,0);
        [self addChild:background];
        
        XMLDataProvider *dataProvider = XMLDataProvider.new;
        dataProvider.xmlFileName = @"config";
        [dataProvider prepareParser];
        [dataProvider read];
    }
    return self;
}

@end
