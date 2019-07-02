//
//  XMLParser.m
//  Game iOS
//
//  Created by pragmus on 01/07/2019.
//  Copyright © 2019 Apportable. All rights reserved.
//

#import "XMLDataProvider.h"
#import "Item.h"

@interface XMLDataProvider()<NSXMLParserDelegate>

@property (nonatomic) NSXMLParser *parser;

@property (nonatomic) NSString *backgroundValue;
@property (nonatomic) NSMutableArray<Item *> *items;

@property (nonatomic) NSString *currentTag;
@property (nonatomic) NSDictionary *currentAttributes;

@end

@implementation XMLDataProvider

#pragma mark - init

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.items = @[].mutableCopy;
    }
    return self;
}

- (void)prepareParser
{
    NSString *path = [NSBundle.mainBundle pathForResource:self.xmlFileName ofType:@"xml"];
    
    self.parser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path]];
    self.parser.delegate = self;
}

- (void)read {
    [self.parser parse];
}


#pragma mark - NSXMLParser Delegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    self.currentTag = elementName;
    self.currentAttributes = attributeDict;
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if ([self.currentTag isEqualToString:@"background"]) {
        if (![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
            self.backgroundValue = string;
        }
    } else if ([self.currentTag isEqualToString:@"item"]) {
        if (![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] isEqualToString:@""]) {
            [self addItemForAttributes:self.currentAttributes withValue:string];
            NSLog(@"%@", self.items.lastObject.type);
            NSLog(@"%@", self.items.lastObject.position);
            NSLog(@"%@", NSStringFromCGPoint(self.items.lastObject.coordinate));
            NSLog(@"%@", self.items.lastObject.value);
        }
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    [self.delegate onDataProviderLoaded:self];
}

- (void)addItemForAttributes:(NSDictionary *)attributeDict withValue:(NSString *)value
{
    Item *item = Item.new;
    item.type = [attributeDict objectForKey:@"type"];
    item.position = [attributeDict objectForKey:@"position"];
    
    NSNumber *x = attributeDict[@"x"];
    NSNumber *y = attributeDict[@"y"];
    item.coordinate = CGPointMake(x.floatValue, y.floatValue);
    
    item.value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [self.items addObject:item];
}

@end
