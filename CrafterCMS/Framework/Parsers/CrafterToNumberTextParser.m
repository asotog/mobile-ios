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
#import "CrafterToNumberTextParser.h"

@implementation CrafterToNumberTextParser

+ (CrafterToNumberTextParser *)sharedInstance
{
    static CrafterToNumberTextParser *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [CrafterToNumberTextParser new];
    }
    
    return sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        numberFormatter = [NSNumberFormatter new];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    }
    return self;
}

- (NSNumber *)parseText:(NSString *)text context:(NSMutableDictionary *)context;
{
    return [numberFormatter numberFromString:text];
}

@end
