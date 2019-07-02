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

@interface MainSceneObjC()<XMLDataProviderDelegate>

@end

@implementation MainSceneObjC

- (instancetype)init
{
    self = [super init];
    if (self) {
        // Load background image
        CCSprite *background = [CCSprite spriteWithImageNamed:@"_room.png"];
        background.anchorPoint = ccp(0,0);
        [self addChild:background];
        
        XMLDataProvider *dataProvider = XMLDataProvider.new;
        dataProvider.delegate = self;
        dataProvider.xmlFileName = @"config";
        [dataProvider prepareParser];
        [dataProvider read];
    }
    return self;
}


#pragma mark - XMLDataProviderDelegates

- (void)onDataProviderLoaded:(XMLDataProvider *)dataProvider
{
    NSLog(@"");
}


@end
