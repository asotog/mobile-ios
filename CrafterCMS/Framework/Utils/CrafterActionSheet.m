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
#import "CrafterActionSheet.h"

@implementation CrafterActionSheet

- (id)init
{
    self = [super init];
    if (self) {
        buttonValues = [NSMutableArray new];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        buttonValues = [NSMutableArray new];
    }
    
    return self;
}

- (NSInteger)addButtonWithTitle:(NSString *)title andValue:(NSString *)value
{
    [buttonValues addObject:value];
    
    return [self addButtonWithTitle:title];
}

- (NSString *)buttonValueAtIndex:(NSInteger)buttonIndex
{
    return [buttonValues objectAtIndex:buttonIndex];
}

@end
