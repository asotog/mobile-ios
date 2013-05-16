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

#import "CrafterAppDelegate.h"
#import "CrafterUIConfigurer.h"
#import "CrafterUILoader.h"

@implementation CrafterAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableDictionary *appDefaults = [NSMutableDictionary dictionary];
    
    [appDefaults setObject:@"http://192.168.1.90:9090" forKey:@"baseURL"];
    [appDefaults setObject:@"/crafter/content-store/descriptor?url=/global-config.xml" forKey:@"globalConfigURL"];
    [appDefaults setObject:@"/crafter/content-store/descriptor?url=/home-config.xml" forKey:@"homeConfigURL"];
    [appDefaults setObject:@"/crafter/content-store/descriptor?url=/gallery-config.xml" forKey:@"galleryConfigURL"];
    [appDefaults setObject:@"/crafter/content-store/descriptor?url=/connect-config.xml" forKey:@"connectConfigURL"];
    [defaults registerDefaults:appDefaults];
    [defaults synchronize];
    
    NSString *baseURL = [defaults stringForKey:@"baseURL"];
    
    [CrafterUIConfigurer configurerWithBaseURL:baseURL];
    
    [[CrafterUILoader sharedInstance] loadGlobalUI:(UITabBarController *)self.window.rootViewController];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
