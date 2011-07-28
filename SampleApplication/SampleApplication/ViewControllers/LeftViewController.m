//
//  LeftViewController.m
//  SampleApplication
//
//  Created by Oliver Letterer on 28.07.11.
//  Copyright 2011 Home. All rights reserved.
//

#import "LeftViewController.h"
#import "ANAdvancedNavigationController.h"
#import "RightViewController.h"

@implementation LeftViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Section: %d, Row: %d", indexPath.section, indexPath.row];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RightViewController *viewController = [[RightViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.advancedNavigationController pushViewController:viewController afterViewController:nil animated:YES];
}

@end
