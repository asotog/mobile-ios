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
#import "CrafterUILoader.h"
#import "CrafterUIConfigurer.h"
#import "CrafterHomeViewController.h"
#import "CrafterGalleryViewController.h"
#import "CrafterConnectViewController.h"

@implementation CrafterUILoader

+ (CrafterUILoader *)sharedInstance
{
    static CrafterUILoader *sharedInstance = nil;
    if (!sharedInstance) {
        sharedInstance = [CrafterUILoader new];
    }
    
    return sharedInstance;    
}

- (void)loadGlobalUI:(UIViewController *)windowRootViewController
{
    NSString *configURL = [[NSUserDefaults standardUserDefaults] stringForKey:@"globalConfigURL"];
    NSMutableDictionary *context = [NSMutableDictionary new];
    
    [[CrafterUIConfigurer sharedInstance] configureUI:windowRootViewController fromConfigurationAtURL:configURL context:context];    
}

- (void)loadHomeUI:(CrafterHomeViewController *)homeViewController
{
    NSString *configUrl = [[NSUserDefaults standardUserDefaults] stringForKey:@"homeConfigURL"];
    NSMutableDictionary *context = [NSMutableDictionary new];
    
    homeViewController.reloadActionSheet = nil;
    
    [[CrafterUIConfigurer sharedInstance] configureUI:homeViewController fromConfigurationAtURL:configUrl context:context];
    
    homeViewController.reloadActionSheet.delegate = homeViewController;
}

- (void)loadGalleryUI:(CrafterGalleryViewController *)galleryViewController
{
    NSString *configUrl = [[NSUserDefaults standardUserDefaults] stringForKey:@"galleryConfigURL"];
    NSMutableDictionary *context = [NSMutableDictionary new];
    
    galleryViewController.reloadActionSheet = nil;
    
	[[CrafterUIConfigurer sharedInstance] configureUI:galleryViewController fromConfigurationAtURL:configUrl context:context];
    
    galleryViewController.carouselDataSource = [context objectForKey:@"carouselDataSource"];
    galleryViewController.carouselDelegate = [context objectForKey:@"carouselDelegate"];
    
    galleryViewController.carousel.dataSource = galleryViewController.carouselDataSource;
    galleryViewController.carousel.delegate = galleryViewController.carouselDelegate;
    
    galleryViewController.reloadActionSheet.delegate = galleryViewController;
}

- (void)loadConnectUI:(CrafterConnectViewController *)connectViewController;
{
    NSString *configUrl = [[NSUserDefaults standardUserDefaults] stringForKey:@"connectConfigURL"];
    NSMutableDictionary *context = [NSMutableDictionary new];
    
    connectViewController.reloadActionSheet = nil;
    
    [[CrafterUIConfigurer sharedInstance] configureUI:connectViewController fromConfigurationAtURL:configUrl context:context];
    
    connectViewController.gridDataSource = [context objectForKey:@"gridDataSource"];
    connectViewController.gridActionDelegate = [context objectForKey:@"gridActionDelegate"];
    
    connectViewController.grid.dataSource = connectViewController.gridDataSource;
    connectViewController.grid.actionDelegate = connectViewController.gridActionDelegate;
    
    connectViewController.reloadActionSheet.delegate = connectViewController;
}

@end
