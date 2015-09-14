//
//  HexagonTableViewCell.h
//  Concrete
//
//  Created by TVTiOS-01 on 12/08/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ArtistTableViewController.h"
#import "AppDelegate.h"
#import "LeftMenuTableViewController.h"
#import "FBSDKGraphRequest.h"
#import "AFHTTPRequestOperationManager.h"


@interface RoundedMenuTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *colarButton;
@property (weak, nonatomic) IBOutlet UIButton *birncoButton;
@property (weak, nonatomic) IBOutlet UIButton *sharedButton;
@property (weak, nonatomic) IBOutlet UIButton *likedButton;
@property (weak, nonatomic) IBOutlet UIButton *conjuntoButton;
@property (weak, nonatomic) IBOutlet UIButton *pulseiraButton;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (nonatomic,strong) NSMutableArray *buttonsArray;
@property (assign,nonatomic) BOOL isObserving;

-(void)setProfileUserPicture;




@end
