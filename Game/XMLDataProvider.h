//
//  XMLParser.h
//  Game iOS
//
//  Created by pragmus on 01/07/2019.
//  Copyright © 2019 Apportable. All rights reserved.
//

@class Item;

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMLDataProvider : NSObject

@property (nonatomic) NSString *xmlFileName;

@property (nonatomic, readonly) NSString *background;
@property (nonatomic, readonly) NSMutableArray<Item *> *items;

- (void)prepareParser;
- (void)read;

@end

NS_ASSUME_NONNULL_END
