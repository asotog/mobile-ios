/*
 * Copyright (C) 2007-2013 Crafter Software Corporation.
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
#import "CrafterArrayItemConfigurer.h"
#import "DDXMLElement.h"
#import "DDXMLElementAdditions.h"
#import "DDXMLElement+CrafterAdditions.h"
#import "CrafterTypes.h"
#import "CrafterObjectConfigurerRegistry.h"
#import "CrafterTextParserRegistry.h"

@implementation CrafterArrayItemConfigurer

+ (CrafterArrayItemConfigurer *)sharedInstance
{
    static CrafterArrayItemConfigurer *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [CrafterArrayItemConfigurer new];
    }
    
    return sharedInstance;      
}

- (id)configureObject:(id)object withXML:(DDXMLElement *)element context:(NSMutableDictionary *)context
{
    CrafterObjectConfigurerRegistry *objectConfigurerRegistry = [CrafterObjectConfigurerRegistry sharedInstance];
    CrafterTextParserRegistry *textParserRegistry = [CrafterTextParserRegistry sharedInstance];
    
    NSMutableArray *array;
    if (![object isKindOfClass:[NSMutableArray class]]) {
        array = [NSMutableArray arrayWithArray:(NSArray *)object];
    } else {
        array = object;
    }

    id item = nil;
    NSString *itemType = [context objectForKey:@"itemType"];
    
    if (element.index < array.count) {
        item = [array objectAtIndex:element.index];
    } else {
        DDXMLNode *itemTypeAttribute = [element attributeForName:@"type"];
        if (itemTypeAttribute) {
            itemType = [CrafterTypes typeFromCanonicalName:[itemTypeAttribute stringValue]];
        }
    }
    
    if (element.childCount > 0) {
        NSArray *childElements = element.elements;
        
        if (childElements.count > 0) {
            Class itemClass;

            if (itemType) {
                itemClass = [CrafterTypes classFromType:itemType];
            } else if (item) {
                itemClass = [item class];
            } else {
                NSLog(@"Unable to create array item for <%@>[%i]: no item type found", element, element.index); 
            }
            
            for (DDXMLElement *childElement in childElements) {
                id<CrafterObjectConfigurer> configurer = [objectConfigurerRegistry configurerForClass:itemClass andElementName:childElement.name];
                
                if (!item) {
                    item = [configurer configureObjectOfClass:itemClass withXML:childElement context:context];
                    [array addObject:item];
                } else {
                    id newItem = [configurer configureObject:item withXML:childElement context:context];
                    if (newItem != item) {
                        [array replaceObjectAtIndex:element.index withObject:newItem];
                    }
                }
            }
        } else {
            if (!itemType && item) {
                itemType = [CrafterTypes typeFromClass:[item class]];
            } else {
                NSLog(@"Unable to create array item for <%@>[%i]: no item type found", element, element.index); 
            }
            
            id<CrafterTextParser> parser = [textParserRegistry parserForType:itemType];
            if (parser) {
                id newItem = [parser parseText:[element stringValue] context:context];
                if (!item) {
                    [array addObject:newItem];
                } else {
                    [array replaceObjectAtIndex:element.index withObject:newItem]; 
                }
            } else {
                NSLog(@"Unable to create item for <%@>[%i]: no parser found for type %@", element, element.index, itemType);                    
            }            
        }
    } else {
        if (!item) {
            [array addObject:[NSNull null]];
        } else {
            [array replaceObjectAtIndex:element.index withObject:[NSNull null]];
        }
    }
    
    return array;
}

- (id)configureObjectOfClass:(Class)class withXML:(DDXMLElement *)element context:(NSMutableDictionary *)context
{
    return [self configureObject:[NSMutableArray new] withXML:element context:context];
}

@end
