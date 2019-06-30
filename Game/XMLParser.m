//
//  XMLParser.m
//  Game iOS
//
//  Created by pragmus on 01/07/2019.
//  Copyright © 2019 Apportable. All rights reserved.
//

#import "XMLParser.h"
#import "Item.h"

@interface XMLParser()<NSXMLParserDelegate>

@property (nonatomic) NSXMLParser *parser;

@property (nonatomic) NSString *background;
@property (nonatomic) NSMutableArray<Item *> *items;

@end

@implementation XMLParser

#pragma mark - init

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self prepareParser];
    }
    return self;
}

- (void)prepareParser
{
    self.parser = NSXMLParser.new;
    self.parser.delegate = self;
}

#pragma mark - NSXMLParser Delegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"background"]) {
        
    } else if ([elementName isEqualToString:@"item"])  {
        
    }
    
}

@end
