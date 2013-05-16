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
#import "CrafterGridConfigurer.h"
#import "DDXMLElement.h"
#import "DDXMLElementAdditions.h"
#import "NSURL+CrafterAdditions.h"
#import "CrafterAppLinkGridConfiguration.h"
#import "CrafterToColorTextParser.h"
#import "CrafterToImageTextParser.h"
#import "CrafterAppLink.h"
#import "NSURL+CrafterAdditions.h"

@implementation CrafterGridConfigurer

+ (CrafterGridConfigurer *)sharedInstance
{
    static CrafterGridConfigurer *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [CrafterGridConfigurer new];
    }
    
    return sharedInstance;    
}

- (NSString *)edgeInsetsStringFromElements:(DDXMLElement *)edgeInsetsElement
{
    DDXMLElement *topElement = [edgeInsetsElement elementForName:@"top"];
    if (!topElement) {
        NSLog(@"No top edge inset element defined");
        
        return nil;
    }
    
    DDXMLElement *leftElement = [edgeInsetsElement elementForName:@"left"];
    if (!leftElement) {
        NSLog(@"No left edge inset element defined");
        
        return nil;
    }
    
    DDXMLElement *bottomElement = [edgeInsetsElement elementForName:@"bottom"];
    if (!bottomElement) {
        NSLog(@"No bottom edge inset element defined");
        
        return nil;
    }
    
    DDXMLElement *rightElement = [edgeInsetsElement elementForName:@"right"];
    if (!rightElement) {
        NSLog(@"No right edge inset element defined");
        
        return nil;
    }
    
    return [NSString stringWithFormat:@"{%@, %@, %@, %@}", topElement.stringValue, leftElement.stringValue, bottomElement.stringValue, 
            rightElement.stringValue];
}

- (NSArray *)appLinksFromElements:(NSArray *)appLinkElements context:(NSMutableDictionary *)context
{
    NSMutableArray *appLinks = [NSMutableArray new];
    
    for (DDXMLElement *appLinkElement in appLinkElements) {
        NSURL *iconURL = [NSURL URLWithString:[[appLinkElement elementForName:@"icon"] stringValue] context:context];
        NSURL *appURL = [NSURL URLWithString:[[appLinkElement elementForName:@"url"] stringValue] context:context];
        
        CrafterAppLink *appLink = [CrafterAppLink appLinkWithIconURL:iconURL andAppURL:appURL];
        
        [appLinks addObject:appLink];
    }
    
    return appLinks;
}

- (id)configureObject:(id)object withXML:(DDXMLElement *)element context:(NSMutableDictionary *)context
{
    GMGridView *grid = [object valueForKey:element.name];
    CrafterAppLinkGridConfiguration *gridConfiguration = [CrafterAppLinkGridConfiguration new];
    
    DDXMLElement *backgroundColorElement = [element elementForName:@"backgroundColor"];
    if (backgroundColorElement) {
        grid.backgroundColor = [[CrafterToColorTextParser sharedInstance] parseText:backgroundColorElement.stringValue
                                                                       context:context];
    }
    
    DDXMLElement *centerElement = [element elementForName:@"center"];
    if (centerElement) {
        grid.centerGrid = centerElement.stringValue.boolValue;
    }
    
    DDXMLElement *minEdgeInsetsElement = [element elementForName:@"minEdgeInsets"];
    if (minEdgeInsetsElement) {
        grid.minEdgeInsets = UIEdgeInsetsFromString([self edgeInsetsStringFromElements:minEdgeInsetsElement]);
    }
    
    DDXMLElement *itemsElement = [element elementForName:@"items"];
    if (itemsElement) {        
        DDXMLNode *widthAttribute = [itemsElement attributeForName:@"width"];
        if (widthAttribute) {
            gridConfiguration.imageWidth = widthAttribute.stringValue.floatValue;
        }
        
        DDXMLNode *heightAttribute = [itemsElement attributeForName:@"height"];
        if (heightAttribute) {
            gridConfiguration.imageHeight = heightAttribute.stringValue.floatValue;
        }
        
        DDXMLNode *spacingAttribute = [itemsElement attributeForName:@"spacing"];
        if (spacingAttribute) {
            grid.itemSpacing = spacingAttribute.stringValue.integerValue;
        }        
        
        NSArray *appLinkElements = [itemsElement elementsForName:@"appLink"];
        if (appLinkElements && appLinkElements.count > 0) {
            gridConfiguration.appLinks = [self appLinksFromElements:appLinkElements context:context];
        }
    }
    
    [context setObject:gridConfiguration forKey:@"gridDataSource"];
    [context setObject:gridConfiguration forKey:@"gridActionDelegate"];
    
    return object;
}

- (id)configureObjectOfClass:(Class)class withXML:(DDXMLElement *)element context:(NSMutableDictionary *)context
{
    return [self configureObject:[class new] withXML:element context:context];
}

@end
