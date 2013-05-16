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
#import "CrafterAppLinkGridConfiguration.h"
#import "CrafterAppLink.h"

#define DEFAULT_IMAGE_WIDTH 128.0f
#define DEFAULT_IMAGE_HEIGHT 128.0f

@implementation CrafterAppLinkGridConfiguration

@synthesize appLinks, imageWidth, imageHeight;

- (id)init
{
    self = [super init];
    if (self) {
        imageWidth = DEFAULT_IMAGE_WIDTH;
        imageHeight = DEFAULT_IMAGE_HEIGHT;
    }
    
    return self;
}

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return self.appLinks.count;
}

- (CGSize)GMGridView:(GMGridView *)gridView sizeForItemsInInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    return CGSizeMake(imageWidth, imageHeight);
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    if (!cell) {
        cell = [GMGridViewCell new];
    }
    
    CrafterAppLink *appLink = [appLinks objectAtIndex:index];
    UIImageView *appLinkView = [[UIImageView alloc] initWithImage:appLink];
    
    cell.contentView = appLinkView;
    
    return cell;
}

- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    GMGridViewCell *cell = [gridView cellForItemAtIndex:position];
    UIImageView *appLinkView = (UIImageView *)cell.contentView;
    CrafterAppLink *appLink = (CrafterAppLink *)appLinkView.image;
    
    [appLink openApp];
}

@end
