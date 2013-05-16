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
#import "UIColor+CrafterAdditions.h"

@implementation UIColor (CrafterAdditions)

+ (UIColor *)colorWithHexString:(NSString *)hexString
{
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    unsigned int hex = 0;
    
    if ([scanner scanHexInt:&hex]) {
        return [UIColor colorWithRGBHex:hex];
    } else {
        return nil;
    }
}

+ (UIColor *)colorWithRGBHex:(unsigned int)hex
{
    CGFloat r = (hex >> 16) & 0xFF;
    CGFloat g = (hex >> 8) & 0xFF;
    CGFloat b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:(r / 255.0f) green:(g / 255.0f) blue:(b / 255.0f) alpha:1.0f];
}

@end
