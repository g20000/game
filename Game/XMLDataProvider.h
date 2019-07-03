//
//  XMLParser.h
//  Game iOS
//
//  Created by pragmus on 01/07/2019.
//  Copyright © 2019 Apportable. All rights reserved.
//

@class Item;
@class XMLDataProvider;

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol XMLDataProviderDelegate

- (void)onDataProviderLoaded:(XMLDataProvider *)dataProvider;

@end

@interface XMLDataProvider : NSObject

@property (nonatomic, weak) id<XMLDataProviderDelegate> delegate;

@property (nonatomic) NSString *xmlFileName;

@property (nonatomic, readonly) NSString *backgroundValue;
@property (nonatomic, readonly) NSMutableArray<Item *> *items;
@property (nonatomic, readonly) NSMutableArray *coordinates;

- (void)prepareParser;
- (void)read;

@end

NS_ASSUME_NONNULL_END
