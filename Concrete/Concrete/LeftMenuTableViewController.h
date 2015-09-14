//
//  MenuTableViewController.h
//  Concrete
//
//  Created by TVTiOS-01 on 06/08/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftViewCell.h"
#import "RoundedMenuTableViewCell.h"


@interface LeftMenuTableViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>

@property NSArray *titlesArray;
@property (strong, nonatomic) UIColor *tintColor;

@end
