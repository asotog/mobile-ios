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

#import "CrafterImageCarouselConfiguration.h"
#import "ReflectionView.h"
#import "AsyncImageView.h"

#define DEFAULT_IMAGE_WIDTH 200.0f
#define DEFAULT_IMAGE_HEIGHT 200.0f
#define NUMBER_OF_VISIBLE_ITEMS 8
#define SPACE_BETWEEN_ITEMS 10

@implementation CrafterImageCarouselConfiguration

@synthesize imageURLs, imageWidth, imageHeight, reflectImages, wrapImages;

- (id)init
{
    self = [super init];
    if (self) {
        imageWidth = DEFAULT_IMAGE_WIDTH;
        imageHeight = DEFAULT_IMAGE_HEIGHT;
        reflectImages = false;
        wrapImages = false;
        
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(imageDidFinishishLoading:) 
                                                     name:AsyncImageLoadDidFinish 
                                                   object:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.imageURLs.count;
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    //if you have less than around 30 items in the carousel
    //you'll get better performance if NUMBER_OF_VISIBLE_ITEMS >= NUMBER_OF_ITEMS
    //because then the item view reflections won't have to be re-generated as
    //the carousel is scrolling
    return NUMBER_OF_VISIBLE_ITEMS;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{ 
	//create new view if no view is available for recycling
	if (!view) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.imageWidth, self.imageHeight)];
        
        AsyncImageView *imageView = [[AsyncImageView alloc] initWithFrame:view.frame];
        imageView.imageURL = [imageURLs objectAtIndex:index];
        
        [view addSubview:imageView];
	}
    
	return view;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return self.imageWidth + SPACE_BETWEEN_ITEMS;
}

- (void)imageDidFinishishLoading:(NSNotification *)notification
{
    if (self.reflectImages) {
        AsyncImageView *imageView = notification.object;
        UIView *rootView = [notification.object superview];
        
        [imageView removeFromSuperview];
        
        ReflectionView *reflectionView = [[ReflectionView alloc] initWithFrame:rootView.frame];
        [reflectionView addSubview:imageView];
        
        [rootView addSubview:reflectionView];
    }    
}

@end
