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
#import "CrafterCarouselConfigurer.h"
#import "iCarousel.h"
#import "DDXMLElement.h"
#import "DDXMLElementAdditions.h"
#import "CrafterImageCarouselConfiguration.h"
#import "CrafterToColorTextParser.h"
#import "NSURL+CrafterAdditions.h"

@implementation CrafterCarouselConfigurer

+ (CrafterCarouselConfigurer *)sharedInstance
{
    static CrafterCarouselConfigurer *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [CrafterCarouselConfigurer new];
    }
    
    return sharedInstance;    
}

- (NSArray *)imageURLsFromElements:(NSArray *)imageElements context:(NSMutableDictionary *)context
{
    NSMutableArray *imageURLS = [NSMutableArray new];
    
    for (DDXMLElement *imageElement in imageElements) {
        [imageURLS addObject:[NSURL URLWithString:[imageElement stringValue] context:context]];
    }
    
    return imageURLS;
}

- (id)configureObject:(id)object withXML:(DDXMLElement *)element context:(NSMutableDictionary *)context
{
    iCarousel *carousel = [object valueForKey:element.name];
    CrafterImageCarouselConfiguration *carouselConfiguration = [CrafterImageCarouselConfiguration new];
    
    DDXMLElement *backgroundColorElement = [element elementForName:@"backgroundColor"];
    if (backgroundColorElement) {
        carousel.backgroundColor = [[CrafterToColorTextParser sharedInstance] parseText:backgroundColorElement.stringValue
                                                                       context:context];
    }
    
    DDXMLElement *itemsElement = [element elementForName:@"items"];
    if (itemsElement) {        
        DDXMLNode *widthAttribute = [itemsElement attributeForName:@"width"];
        if (widthAttribute) {
            carouselConfiguration.imageWidth = widthAttribute.stringValue.floatValue;
        }
        
        DDXMLNode *heightAttribute = [itemsElement attributeForName:@"height"];
        if (heightAttribute) {
            carouselConfiguration.imageHeight = heightAttribute.stringValue.floatValue;
        }
        
        NSArray *imageElements = [itemsElement elementsForName:@"image"];
        if (imageElements && imageElements.count > 0) {
            carouselConfiguration.imageURLs = [self imageURLsFromElements:imageElements context:context];
        }
    }
    
    DDXMLElement *wrapElement = [element elementForName:@"wrap"];
    if (wrapElement) {
        carouselConfiguration.wrapImages = wrapElement.stringValue.boolValue;
    }
    
    DDXMLElement *reflectElement = [element elementForName:@"reflect"];
    if (reflectElement) {
        carouselConfiguration.reflectImages = reflectElement.stringValue.boolValue;
    }
    
    [context setObject:carouselConfiguration forKey:@"carouselDataSource"];
    [context setObject:carouselConfiguration forKey:@"carouselDelegate"];
    
    return object;
}

- (id)configureObjectOfClass:(Class)class withXML:(DDXMLElement *)element context:(NSMutableDictionary *)context
{
    return [self configureObject:[class new] withXML:element context:context];
}

@end
