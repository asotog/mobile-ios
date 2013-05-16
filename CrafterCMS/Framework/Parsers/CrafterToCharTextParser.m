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
#import "CrafterToCharTextParser.h"

@implementation CrafterToCharTextParser

+ (CrafterToCharTextParser *)sharedInstance
{
    static CrafterToCharTextParser *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [CrafterToCharTextParser new];
    }
    
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        trueStrings = [NSSet setWithObjects:@"true", @"t", @"yes", @"y", nil];
        falseStrings = [NSSet setWithObjects:@"false", @"f", @"no", @"n", nil];
    }
    return self;
}

- (NSNumber *)parseText:(NSString *)text context:(NSMutableDictionary *)context;
{
    NSString *lowercasedText = [text lowercaseString];
    if ([trueStrings containsObject:lowercasedText]) {
        return [NSNumber numberWithBool:true];
    } else if ([falseStrings containsObject:lowercasedText]) {
        return [NSNumber numberWithBool:false];
    } else {
        return [NSNumber numberWithChar:[text characterAtIndex:0]];
    }    
}

- (BOOL)boolValueFromText:(NSString *)text
{
    NSString *lowercasedText = [text lowercaseString];
    
    return [trueStrings containsObject:lowercasedText];
}

@end
