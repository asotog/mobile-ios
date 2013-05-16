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
#import "CrafterHomeViewController.h"
#import "CrafterUIConfigurer.h"
#import "CrafterUILoader.h"

@interface CrafterHomeViewController ()

@end

@implementation CrafterHomeViewController

@synthesize navigationItem, webView, reloadActionSheet;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.webView.delegate = self;
    
    [[CrafterUILoader sharedInstance] loadHomeUI:self];
}

- (void)viewDidUnload
{
    self.navigationItem = nil;
    self.webView = nil;
    self.reloadActionSheet = nil;
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight;
}

- (IBAction)showReloadActionSheet:(id)sender 
{
    [reloadActionSheet showFromBarButtonItem:self.navigationItem.rightBarButtonItem animated:true];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex >= 0) {
        NSString *buttonValue = [self.reloadActionSheet buttonValueAtIndex:buttonIndex];
        if ([buttonValue isEqualToString:@"reloadTabBar"]) {
            [[CrafterUILoader sharedInstance] loadGlobalUI:self.tabBarController];
        } else if ([buttonValue isEqualToString:@"reloadHome"]) {
            [[CrafterUILoader sharedInstance] loadHomeUI:self];
        }
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@", error);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType 
{
    NSURL *URL = request.URL;
    if ([URL.description isEqual:@"cr://gallery"]) {
        self.tabBarController.selectedIndex = 1;
        
        return false;
    } else if ([URL.description isEqual:@"cr://connect"]) {
        self.tabBarController.selectedIndex = 2;
        
        return false;
    }
    
    return true;
}

@end
