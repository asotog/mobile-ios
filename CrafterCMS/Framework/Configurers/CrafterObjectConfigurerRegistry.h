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
#import <Foundation/Foundation.h>
#import "CrafterObjectConfigurer.h"

@interface CrafterObjectConfigurerRegistry : NSObject
{
    NSMutableDictionary *registry;
}

+ (CrafterObjectConfigurerRegistry *)sharedInstance;

@property (strong, nonatomic) id<CrafterObjectConfigurer> defaultConfigurer;

- (id<CrafterObjectConfigurer>)configurerForClass:(Class)clazz andElementName:(NSString *)elementName;
- (void)registerConfigurer:(id<CrafterObjectConfigurer>)configurer forClass:(Class)clazz;
- (void)registerConfigurer:(id<CrafterObjectConfigurer>)configurer forElementName:(NSString *)elementName;
- (void)registerConfigurer:(id<CrafterObjectConfigurer>)configurer forClass:(Class)clazz andElementName:(NSString *)elementName;

@end
