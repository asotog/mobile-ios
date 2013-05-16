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

#import "CrafterKVCObjectConfigurer.h"
#import "DDXMLElement.h"
#import "DDXMLElementAdditions.h"
#import "DDXMLElement+CrafterAdditions.h"
#import "NSObject+Reflection.h"
#import "CrafterTextParserRegistry.h"
#import "CrafterObjectConfigurerRegistry.h"
#import "CrafterTypes.h"

@implementation CrafterKVCObjectConfigurer

+ (CrafterKVCObjectConfigurer *)sharedInstance
{
    static CrafterKVCObjectConfigurer *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [CrafterKVCObjectConfigurer new];
    }
    
    return sharedInstance;
}

- (id)configureObject:(id)object withXML:(DDXMLElement *)element context:(NSMutableDictionary *)context
{
    CrafterObjectConfigurerRegistry *objectConfigurerRegistry = [CrafterObjectConfigurerRegistry sharedInstance];
    CrafterTextParserRegistry *textParserRegistry = [CrafterTextParserRegistry sharedInstance];
    
    // If the object has a property equal to the element name, do the following:
    // 1) If the element is text only, parse the text to an object and assign the object to the property.
    // 2) If the element has other elements as children, configure the property value through them.
    if ([object hasPropertyNamed:element.name]) {        
        if (element.childCount > 0) {
            NSMutableDictionary *contextWithAttributes = [NSMutableDictionary dictionaryWithDictionary:context];
            [contextWithAttributes addEntriesFromDictionary:[element attributesAsDictionary]];
            
            NSArray *childElements = element.elements;
            
            if (childElements.count > 0) {
                for (DDXMLElement *childElement in childElements) {
                    id propertyValue = [object valueForKey:element.name];
                    Class propertyClass = [CrafterTypes classFromType:[object typeOfPropertyNamed:element.name]];
                    
                    id<CrafterObjectConfigurer> configurer = [objectConfigurerRegistry configurerForClass:propertyClass 
                                                                                      andElementName:childElement.name];
                    
                    if (!propertyValue) {                        
                        propertyValue = [configurer configureObjectOfClass:propertyClass withXML:childElement context:contextWithAttributes];
                        [object setValue:propertyValue forKey:element.name]; 
                    } else {
                        id newPropertyValue = [configurer configureObject:propertyValue withXML:childElement context:contextWithAttributes];
                        if (newPropertyValue != propertyValue) {
                            [object setValue:newPropertyValue forKey:element.name]; 
                        }
                    }
                }
            } else {
                NSString *propertyType = [object typeOfPropertyNamed:element.name];
                
                id<CrafterTextParser> parser = [textParserRegistry parserForType:propertyType];
                if (parser) {
                    id value = [parser parseText:[element stringValue] context:contextWithAttributes];
                    
                    [object setValue:value forKey:element.name];                    
                } else {
                    NSLog(@"Unable to configure %@ from XML element <%@>: No parser found for type %@", object, 
                          element.name, propertyType);                    
                }
            }
        } else {
            [object setValue:nil forKey:element.name];
        }
        
        return object;
    // If we couldn't configure the object through KVC, call the method (overriden by child classes) to configure
    // it through some other way.
    } else {
        return [self configureNonKVCObject:object withXML:element context:context];
    }
}

- (id)configureObjectOfClass:(Class)class withXML:(DDXMLElement *)element context:(NSMutableDictionary *)context
{
    return [self configureObject:[class new] withXML:element context:context];
}

- (id)configureNonKVCObject:(id)object withXML:(DDXMLElement *)element context:(NSMutableDictionary *)context 
{
    NSLog(@"Unable to configure %@ through KVC from XML element %@", object, element);
    
    return object;
}

@end
