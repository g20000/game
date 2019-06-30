//
//  Item.h
//  Game iOS
//
//  Created by pragmus on 01/07/2019.
//  Copyright © 2019 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Item : NSObject

@property (nonatomic) NSString *type;
@property (nonatomic) NSNumber *position;
@property (nonatomic) CGPoint *coordinate;
@property (nonatomic) NSString *value;

@end

NS_ASSUME_NONNULL_END
