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
#import "CrafterViewBackgroundColorConfigurer.h"
#import "DDXMLElement.h"
#import "CrafterToColorTextParser.h"

@implementation CrafterViewBackgroundColorConfigurer

+ (CrafterViewBackgroundColorConfigurer *)sharedInstance
{
    static CrafterViewBackgroundColorConfigurer *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [CrafterViewBackgroundColorConfigurer new];
    }
    
    return sharedInstance;      
}

- (id)configureObject:(id)object withXML:(DDXMLElement *)element context:(NSMutableDictionary *)context
{
    UIView *view = [object valueForKey:@"view"];
    
    view.backgroundColor = [[CrafterToColorTextParser sharedInstance] parseText:element.stringValue context:context];
    
    return object;
}

- (id)configureObjectOfClass:(Class)class withXML:(DDXMLElement *)element context:(NSMutableDictionary *)context
{
    return [self configureObject:[class new] withXML:element context:context];
}

@end
