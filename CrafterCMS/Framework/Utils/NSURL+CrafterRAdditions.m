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
#import "NSURL+CrafterAdditions.h"

@implementation NSURL (CrafterAdditions)


+ (NSURL *)URLWithString:(NSString *)URLString context:(NSDictionary *)context
{
    return [[NSURL alloc] initWithString:URLString context:context];
}

- (id)initWithString:(NSString *)URLString context:(NSDictionary *)context
{
    NSPredicate *schemePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES '([a-zA-Z0-9+.-]+)://.*'"];
    
    if (![schemePredicate evaluateWithObject:URLString]){
        NSString *baseURLString;
        if ([URLString hasPrefix:@"/"]) {
            baseURLString = [context objectForKey:@"uiConfigurerBaseURL"];
        } else {
            baseURLString = [context objectForKey:@"currentConfigurationURL"];
        }
        
        URLString = [baseURLString stringByAppendingPathComponent:URLString];
    }    
    
    return [self initWithString:URLString];   
}

@end
