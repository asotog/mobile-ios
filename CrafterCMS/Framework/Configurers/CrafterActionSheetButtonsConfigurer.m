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
#import "CrafterActionSheetButtonsConfigurer.h"
#import "DDXMLElement.h"
#import "CrafterActionSheet.h"

@implementation CrafterActionSheetButtonsConfigurer

+ (CrafterActionSheetButtonsConfigurer *)sharedInstance 
{
    static CrafterActionSheetButtonsConfigurer *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [CrafterActionSheetButtonsConfigurer new];
    }
    
    return sharedInstance;     
}

- (id)configureObject:(id)object withXML:(DDXMLElement *)element context:(NSMutableDictionary *)context
{
    DDXMLNode *valueAttribute = [element attributeForName:@"value"];
    
    [object addButtonWithTitle:element.stringValue andValue:valueAttribute.stringValue];
    
    return object;
}

- (id)configureObjectOfClass:(Class)class withXML:(DDXMLElement *)element context:(NSMutableDictionary *)context
{
    return [self configureObject:[CrafterActionSheet new] withXML:element context:context];
}

@end
