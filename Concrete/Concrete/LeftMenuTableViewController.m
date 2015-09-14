//
//  MenuTableViewController.m
//  Concrete
//
//  Created by TVTiOS-01 on 06/08/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import "LeftMenuTableViewController.h"
#import "AppDelegate.h"
#import "ArtistTableViewController.h"
#import "RoundedMenuTableViewCell.h"
#import "MenuPrincipalTableViewCell.h"



@interface LeftMenuTableViewController ()
@property(nonatomic,strong) NSArray *tableData;

@end

@implementation LeftMenuTableViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self)
    {
        _titlesArray = @[@"Menu",
                         @"Options",
                         ];
        
        [self.tableView registerClass:[LeftViewCell class] forCellReuseIdentifier:@"cell"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.contentInset = UIEdgeInsetsMake(20.f, 0.f, 20.f, 0.f);
        self.tableView.showsVerticalScrollIndicator = NO;
        self.tableView.bounces = YES;
    }
    return self;
}



#pragma mark -

- (void)openLeftView
{
    [kMainViewController showLeftViewAnimated:YES completionHandler:nil];
}

- (void)openRightView
{
    [kMainViewController showRightViewAnimated:YES completionHandler:nil];
}

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _titlesArray.count;
}

#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    RoundedMenuTableViewCell *roundedCell = (RoundedMenuTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"RoundCell"];
    
    MenuPrincipalTableViewCell *cell2 = (MenuPrincipalTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"menuOption"];
    
    if([[_titlesArray objectAtIndex:indexPath.row] isEqualToString:@"Menu"])
    {
        
        if (roundedCell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"RoundedMenuTableViewCell" owner:self options:nil];
            roundedCell = [nib objectAtIndex:0];
        }
        
        [roundedCell setProfileUserPicture];
        cell = roundedCell;
        
        
    }
    
    if([[_titlesArray objectAtIndex:indexPath.row] isEqualToString:@"Options"])
    {
        
        if (cell2 == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MenuPrincipalTableViewCell" owner:self options:nil];
            cell2 = [nib objectAtIndex:0];
        }
        
        cell = cell2;
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return (self.view.superview.frame.size.height)*0.43;//22.f;
    else return (self.view.superview.frame.size.height)*0.57;//44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].selectionStyle = UITableViewCellSelectionStyleNone;
//    if (indexPath.row == 1)
//    {
//        if (!kMainViewController.isLeftViewAlwaysVisible)
//        {
//            [kMainViewController hideLeftViewAnimated:YES completionHandler:^(void)
//             {
//                 [kMainViewController showRightViewAnimated:YES completionHandler:nil];
//             }];
//        }
//        else [kMainViewController showRightViewAnimated:YES completionHandler:nil];
//    }
//    else
//    {
//        UIViewController *viewController = [UIViewController new];
//        viewController.view.backgroundColor = [UIColor whiteColor];
//        viewController.title = _titlesArray[indexPath.row];
//        [kNavigationController pushViewController:viewController animated:YES];
//        
//        [kMainViewController hideLeftViewAnimated:YES completionHandler:nil];
//    }
}

@end
