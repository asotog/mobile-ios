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
#import "CrafterTextParserRegistry.h"
#import "CrafterTypes.h"
#import "CrafterToCharTextParser.h"
#import "CrafterToNumberTextParser.h"
#import "CrafterToTextTextParser.h"
#import "CrafterToImageTextParser.h"
#import "CrafterToColorTextParser.h"

@implementation CrafterTextParserRegistry

+ (CrafterTextParserRegistry *)sharedInstance
{
    static CrafterTextParserRegistry *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [[CrafterTextParserRegistry alloc] initWithDefaultMappers];
    }
    
    return sharedInstance;
}

- (id)initWithDefaultMappers
{
    self = [super init];
    if (self) {
        registry = [NSMutableDictionary new];
        [registry setObject:[CrafterToCharTextParser sharedInstance] forKey:[CrafterTypes charType]];
        [registry setObject:[CrafterToNumberTextParser sharedInstance] forKey:[CrafterTypes intType]];
        [registry setObject:[CrafterToNumberTextParser sharedInstance] forKey:[CrafterTypes shortType]];
        [registry setObject:[CrafterToNumberTextParser sharedInstance] forKey:[CrafterTypes longType]];
        [registry setObject:[CrafterToNumberTextParser sharedInstance] forKey:[CrafterTypes longLongType]];
        [registry setObject:[CrafterToCharTextParser sharedInstance] forKey:[CrafterTypes unsignedCharType]];
        [registry setObject:[CrafterToNumberTextParser sharedInstance] forKey:[CrafterTypes unsignedIntType]];
        [registry setObject:[CrafterToNumberTextParser sharedInstance] forKey:[CrafterTypes unsignedShortType]];
        [registry setObject:[CrafterToNumberTextParser sharedInstance] forKey:[CrafterTypes unsignedLongType]];
        [registry setObject:[CrafterToNumberTextParser sharedInstance] forKey:[CrafterTypes unsignedLongLongType]];
        [registry setObject:[CrafterToNumberTextParser sharedInstance] forKey:[CrafterTypes floatType]];
        [registry setObject:[CrafterToNumberTextParser sharedInstance] forKey:[CrafterTypes doubleType]];
        [registry setObject:[CrafterToNumberTextParser sharedInstance] forKey:[CrafterTypes typeFromClass:[NSNumber class]]];
        [registry setObject:[CrafterToTextTextParser sharedInstance] forKey:[CrafterTypes typeFromClass:[NSString class]]];
        [registry setObject:[CrafterToImageTextParser sharedInstance] forKey:[CrafterTypes typeFromClass:[UIImage class]]];
        [registry setObject:[CrafterToColorTextParser sharedInstance] forKey:[CrafterTypes typeFromClass:[UIColor class]]];
    }
    
    return self;
}

- (id<CrafterTextParser>)parserForType:(NSString *)type
{
    return [registry objectForKey:type];
}

- (void)registerParser:(id<CrafterTextParser>)parser forType:(NSString *)type
{
    [registry setObject:parser forKey:type];
}

@end
