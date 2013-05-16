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
#import "CrafterObjectConfigurerRegistry.h"
#import "CrafterArrayItemConfigurer.h"
#import "CrafterCarouselConfigurer.h"
#import "CrafterGridConfigurer.h"
#import "CrafterWebViewConfigurer.h"
#import "CrafterFontConfigurer.h"
#import "CrafterViewBackgroundColorConfigurer.h"
#import "CrafterActionSheetButtonsConfigurer.h"
#import "CrafterKVCObjectConfigurer.h"
#import "CrafterActionSheet.h"

@implementation CrafterObjectConfigurerRegistry

@synthesize defaultConfigurer;

+ (CrafterObjectConfigurerRegistry *)sharedInstance
{
    static CrafterObjectConfigurerRegistry *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [[CrafterObjectConfigurerRegistry alloc] initWithDefaultMappers];
    }
    
    return sharedInstance;
}

- (id)initWithDefaultMappers
{
    self = [super init];
    if (self) {
        registry = [NSMutableDictionary new];
        [self registerConfigurer:[CrafterArrayItemConfigurer sharedInstance] forClass:[NSArray class]];
        [self registerConfigurer:[CrafterActionSheetButtonsConfigurer sharedInstance] forClass:[CrafterActionSheet class] andElementName:@"button"];
        [self registerConfigurer:[CrafterFontConfigurer sharedInstance] forElementName:@"font"];
        [self registerConfigurer:[CrafterViewBackgroundColorConfigurer sharedInstance] forElementName:@"backgroundColor"];        
        [self registerConfigurer:[CrafterCarouselConfigurer sharedInstance] forElementName:@"carousel"];
        [self registerConfigurer:[CrafterGridConfigurer sharedInstance] forElementName:@"grid"];
        [self registerConfigurer:[CrafterWebViewConfigurer sharedInstance] forElementName:@"webView"];
        
        self.defaultConfigurer = [CrafterKVCObjectConfigurer sharedInstance];
    }
    
    return self;
}

- (NSString *)keyForClass:(Class)clazz andElementName:(NSString *)elementName
{
    return [NSString stringWithFormat:@"%@,%@", NSStringFromClass(clazz), elementName];
}

- (id<CrafterObjectConfigurer>)configurerForClass:(Class)clazz andElementName:(NSString *)elementName
{
    id<CrafterObjectConfigurer> configurer = [registry objectForKey:[self keyForClass:clazz andElementName:elementName]];
    if (!configurer) {
        configurer = [registry objectForKey:NSStringFromClass(clazz)];
        if (!configurer) {
            configurer = [registry objectForKey:elementName];
            if (!configurer) {
                configurer = defaultConfigurer;
            }
        }
    }
    
    return configurer;
}

- (void)registerConfigurer:(id<CrafterObjectConfigurer>)configurer forClass:(Class)clazz
{
    [registry setObject:configurer forKey:NSStringFromClass(clazz)];
}

- (void)registerConfigurer:(id<CrafterObjectConfigurer>)configurer forElementName:(NSString *)elementName
{
    [registry setObject:configurer forKey:elementName];
}

- (void)registerConfigurer:(id<CrafterObjectConfigurer>)configurer forClass:(Class)clazz andElementName:(NSString *)elementName
{
    [registry setObject:configurer forKey:[self keyForClass:clazz andElementName:elementName]];
}

@end
