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
#import "CrafterConnectViewController.h"
#import "CrafterUIConfigurer.h"
#import "CrafterUILoader.h"

@interface CrafterConnectViewController ()

@end

@implementation CrafterConnectViewController

@synthesize navigationItem, grid, gridDataSource, gridActionDelegate, reloadActionSheet;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[CrafterUILoader sharedInstance] loadConnectUI:self];
}

- (void)viewDidUnload
{
    self.navigationItem = nil;
    self.grid = nil;
    self.gridDataSource = nil;
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
        } else if ([buttonValue isEqualToString:@"reloadConnect"]) {
            [[CrafterUILoader sharedInstance] loadConnectUI:self];
        }
    }
}

@end
