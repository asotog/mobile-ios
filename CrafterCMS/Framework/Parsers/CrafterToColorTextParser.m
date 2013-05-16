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
#import "CrafterToColorTextParser.h"
#import "UIColor+CrafterAdditions.h"
#import "NSString+CrafterAdditions.h"

@implementation CrafterToColorTextParser

+ (CrafterToColorTextParser *)sharedInstance
{
    static CrafterToColorTextParser *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [CrafterToColorTextParser new];
    }
    
    return sharedInstance;
}

- (UIColor *)parseText:(NSString *)text context:(NSMutableDictionary *)context;
{
    UIColor *color = nil;
    
    if ([text hasPrefix:@"#"]) {
        color = [UIColor colorWithHexString:[text substringFromIndex:1]];
    } else if ([text isEqualToStringIgnoringCase:@"black"]) {
        color = [UIColor blackColor];
    } else if ([text isEqualToStringIgnoringCase:@"darkgray"]) {
        color = [UIColor darkGrayColor];
    } else if ([text isEqualToStringIgnoringCase:@"lightgray"]) {
        color = [UIColor lightGrayColor];
    } else if ([text isEqualToStringIgnoringCase:@"white"]) {
        color = [UIColor whiteColor];
    } else if ([text isEqualToStringIgnoringCase:@"gray"]) {
        color = [UIColor grayColor];
    } else if ([text isEqualToStringIgnoringCase:@"red"]) {
        color = [UIColor redColor];
    } else if ([text isEqualToStringIgnoringCase:@"green"]) {
        color = [UIColor greenColor];
    } else if ([text isEqualToStringIgnoringCase:@"blue"]) {
        color = [UIColor blueColor];
    } else if ([text isEqualToStringIgnoringCase:@"cyan"]) {
        color = [UIColor cyanColor];
    } else if ([text isEqualToStringIgnoringCase:@"yellow"]) {
        color = [UIColor yellowColor];
    } else if ([text isEqualToStringIgnoringCase:@"magenta"]) {
        color = [UIColor magentaColor];
    } else if ([text isEqualToStringIgnoringCase:@"orange"]) {
        color = [UIColor orangeColor];
    } else if ([text isEqualToStringIgnoringCase:@"purple"]) {
        color = [UIColor purpleColor];
    } else if ([text isEqualToStringIgnoringCase:@"brown"]) {
        color = [UIColor brownColor];
    } else if ([text isEqualToStringIgnoringCase:@"clear"]) {
        color = [UIColor clearColor];
    } else {
        NSLog(@"Unrecognized color: %@", text);
    }
    
    return color;
}

@end
