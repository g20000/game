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

@property (nonatomic) NSMutableArray *coordinates;

@end

@implementation MainSceneObjC

#pragma mark - Lyfecycles

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self prepareDataProvider];
        [self addGestureRecognizers];
    }
    return self;
}

- (void)addGestureRecognizers
{
    [self addPinchGestureRecognizer];
    [self addPanGestureRecognizer];
}

- (void)addPinchGestureRecognizer
{
    UIPinchGestureRecognizer *pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinchGesture:)];
    [[UIApplication sharedApplication].delegate.window addGestureRecognizer:pinchRecognizer];
}

- (void)addPanGestureRecognizer
{
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [[UIApplication sharedApplication].delegate.window addGestureRecognizer:panRecognizer];
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
    self.coordinates = self.dataProvider.coordinates.copy;
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
    self.background.position = ccp(UIScreen.mainScreen.applicationFrame.size.width / 2, UIScreen.mainScreen.applicationFrame.size.height / 2);
    [self addChild:self.background];
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
    
    int randomCoordinateIndex = (arc4random() % self.coordinates.count);
    CGPoint itemCoordinate = [self.coordinates[randomCoordinateIndex] CGPointValue];
    
    const int normalizationDivisor = 1000;
    itemSprite.position = ccp(itemCoordinate.x / normalizationDivisor, itemCoordinate.y / normalizationDivisor);
    self.coordinates = [self removeObjectFromArray:self.coordinates withIndex:randomCoordinateIndex];
    
    itemSprite.positionType = CCPositionTypeNormalized;
    [self.background addChild:itemSprite];
}

- (NSMutableArray *)removeObjectFromArray:(NSMutableArray *)array withIndex:(NSInteger) index {
    NSMutableArray *modifyableArray = [[NSMutableArray alloc] initWithArray:array];
    [modifyableArray removeObjectAtIndex:index];
    return [[NSMutableArray alloc] initWithArray:modifyableArray];
}


#pragma mark - Actions

- (void)handlePinchGesture:(UIPinchGestureRecognizer *)recognizer
{
    const float scalingMaximum = 1.3;
    if (recognizer.scale <= scalingMaximum) {
        self.background.scale = recognizer.scale;
    }
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer
{
    if ((recognizer.state == UIGestureRecognizerStateBegan) || (recognizer.state == UIGestureRecognizerStateChanged)) {
        CGPoint t = [recognizer translationInView:recognizer.view];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        self.background.position = CGPointMake(self.background.position.x + t.x, self.background.position.y - t.y);
    }
}

@end
