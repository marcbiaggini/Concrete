//
//  ArtisDetailsViewController.h
//  Concrete
//
//  Created by TVTiOS-01 on 24/07/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShotsModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "ArtistTableViewController.h"
#import "SplashViewController.h"
#import "MainViewController.h"
#import "PriceDetailsTableViewCell.h"
#import "ArtistaTableViewCell.h"
#import "AppDelegate.h"
#import "LeftMenuTableViewController.h"
#import "Social/Social.h"
#import "ContactTableViewCell.h"






@interface ArtistDetailsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableViewDetails;
@property (nonatomic,strong) ArtistaTableViewCell *artistaCell;
@property (nonatomic,strong) PriceDetailsTableViewCell *priceCell;
@property (nonatomic,strong) ContactTableViewCell *contactCell;


@property (nonatomic,strong) ShotsModel *artistaDetails;
@property (nonatomic,strong) UIImage *artistImage;
//@property (weak, nonatomic) IBOutlet UILabel *artistaDescription;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;

@property (strong, nonatomic) MainViewController *mainViewController;
@property (strong,nonatomic) SLComposeViewController *mySLComposerSheet;





-(void)setArtistaDetails:(ShotsModel *)artistaDetails withImage:(UIImage*) artistaImage;

@end
