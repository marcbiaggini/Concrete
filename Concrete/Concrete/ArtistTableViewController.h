//
//  ArtistTableViewController.h
//  Concrete
//
//  Created by TVTiOS-01 on 21/07/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArtistaTableViewCell.h"
#import "ShotsModel.h"
#import "AFHTTPRequestOperationManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ArtistDetailsViewController.h"
#import "LGSideMenuController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SplashViewController.h"
#import "MainViewController.h"
#import "XHRealTimeBlur.h"






@interface ArtistTableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) IBOutlet UITableView *artisTableview;
@property (strong, nonatomic) MainViewController *mainViewController;

@property (weak, nonatomic) IBOutlet UISearchBar *stockSearchBar;
@property (nonatomic, strong) XHRealTimeBlur *realTimeBlur;







@end
