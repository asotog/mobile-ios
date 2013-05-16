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

#import "CrafterUIConfigurer.h"
#import "DDXMLDocument.h"
#import "DDXMLElement+CrafterAdditions.h"
#import "NSString+CrafterAdditions.h"
#import "CrafterObjectConfigurerRegistry.h"

static CrafterUIConfigurer *sharedInstance = nil;

@implementation CrafterUIConfigurer

+ (id)sharedInstance
{
    return sharedInstance;
}

+ (void)setSharedInstance:(CrafterUIConfigurer *)instance
{
    sharedInstance = instance;
}

+ (CrafterUIConfigurer *)configurerWithBaseURL:(NSString *)theBaseUrl
{
    return [[CrafterUIConfigurer alloc] initWithBaseUrl:theBaseUrl];
}

- (id)initWithBaseUrl:(NSString *)theBaseUrl
{
    self = [super init];
    if (self) {
        baseUrl = theBaseUrl;
        
        if (!sharedInstance) {
            [CrafterUIConfigurer setSharedInstance:self];
        }
    }
    
    return self;
}

- (void)configureUI:(id)uiObject fromConfigurationAtURL:(NSString *)url context:(NSMutableDictionary *)context
{
    NSError *error;
    NSString *configUrl = [baseUrl stringByAppendingPathComponent:url];
    NSData *configData = [NSData dataWithContentsOfURL:[NSURL URLWithString:configUrl] options:NSDataReadingUncached error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
        
        return;
    }
    
    DDXMLDocument *configDoc = [[DDXMLDocument alloc] initWithData:configData options:0 error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
        
        return;
    }
    
    DDXMLElement *rootElement = configDoc.rootElement;
    DDXMLNode *nonConfigElementsAttribute = [rootElement attributeForName:@"nonConfigElements"];
    NSString *nonConfigElements = nil;
    
    if (nonConfigElementsAttribute) {
        nonConfigElements = nonConfigElementsAttribute.stringValue;
    }
    
    [context setObject:baseUrl forKey:@"uiConfigurerBaseURL"];
    [context setObject:configUrl forKey:@"currentConfigurationURL"];
    
    CrafterObjectConfigurerRegistry *configurerRegistry = [CrafterObjectConfigurerRegistry sharedInstance];
    for (DDXMLElement *element in rootElement.elements) {
        if (!nonConfigElements || ![nonConfigElements containsSubstring:element.name]) {
            id<CrafterObjectConfigurer> objectConfigurer = [configurerRegistry configurerForClass:[uiObject class]
                                                                              andElementName:element.name];
            [objectConfigurer configureObject:uiObject withXML:element context:context];
        }
    }
}

@end
