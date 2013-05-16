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
#import "CrafterFontConfigurer.h"
#import "DDXMLElement.h"
#import "DDXMLElementAdditions.h"

@implementation CrafterFontConfigurer

+ (CrafterFontConfigurer *)sharedInstance
{
    static CrafterFontConfigurer *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [CrafterFontConfigurer new];
    }
    
    return sharedInstance;      
}

- (id)configureObject:(id)object withXML:(DDXMLElement *)element context:(NSMutableDictionary *)context
{
    UIFont *currentFont = [object valueForKey:element.name];
    NSString *fontName = nil;
    CGFloat fontSize = 0;
    
    DDXMLElement *nameElement = [element elementForName:@"name"];
    if (nameElement) {
        fontName = nameElement.stringValue;
    }
    
    DDXMLElement *sizeElement = [element elementForName:@"size"];
    if (sizeElement) {
        fontSize = sizeElement.stringValue.floatValue;
    }
    
    if (!fontName) {
        fontName = currentFont.fontName;
    }
    
    if (!fontSize) {
        fontSize = currentFont.pointSize;
    }
    
    [object setValue:[UIFont fontWithName:fontName size:fontSize] forKey:element.name];
    
    return object;
}

- (id)configureObjectOfClass:(Class)class withXML:(DDXMLElement *)element context:(NSMutableDictionary *)context
{
    return [self configureObject:[class new] withXML:element context:context];
}

@end
