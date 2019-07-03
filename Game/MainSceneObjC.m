//
//  MainSceneObjC.m
//  Game iOS
//
//  Created by pragmus on 30/06/2019.
//  Copyright © 2019 Apportable. All rights reserved.
//

#import "MainSceneObjC.h"
#import "CCSprite.h"
#import "CCSpriteFrame.h"
#import "XMLDataProvider.h"
#import "Item.h"

@interface MainSceneObjC()<XMLDataProviderDelegate>

@property (nonatomic) XMLDataProvider *dataProvider;

@property (nonatomic) CCSprite *background;

@end

@implementation MainSceneObjC

#pragma mark - Lyfecycles

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self prepareDataProvider];
    }
    return self;
}


#pragma mark - prepare dataProvider

- (void)prepareDataProvider
{
    self.dataProvider = XMLDataProvider.new;
    self.dataProvider.delegate = self;
    self.dataProvider.xmlFileName = @"config";
    [self.dataProvider prepareParser];
    [self.dataProvider read];
}


#pragma mark - XMLDataProviderDelegates

- (void)onDataProviderLoaded:(XMLDataProvider *)dataProvider
{
    [self drawScene];
}


#pragma mark - Draw scene

- (void)drawScene
{
    [self drawBackground];
    [self drawItems];
}

- (void)drawBackground
{
    NSArray *assetPathParts = [self.dataProvider.backgroundValue componentsSeparatedByString:@"/"];
    self.background = [CCSprite spriteWithImageNamed:assetPathParts.lastObject];
    self.background.anchorPoint = ccp(0, 0);
    
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    [[UIApplication sharedApplication].delegate.window addGestureRecognizer:pinchRecognizer];
    
    [self addChild:self.background];
}

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)recognizer
{
    self.background.scale = recognizer.scale;
}

- (void)drawItems
{
    for (Item *item in self.dataProvider.items) {
        [self drawItem:item];
    }
}

- (void)drawItem:(Item *)item
{
    NSArray *assetPathParts = [item.value componentsSeparatedByString:@"/"];
    CCSprite *itemSprite = [CCSprite spriteWithImageNamed:assetPathParts.lastObject];
    itemSprite.position = ccp(item.coordinate.x / 1000, item.coordinate.y / 1000);
    itemSprite.positionType = CCPositionTypeNormalized;
    [self.background addChild:itemSprite];
}

@end
