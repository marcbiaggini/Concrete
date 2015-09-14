//
//  ViewController.h
//  Concrete
//
//  Created by TVTiOS-01 on 21/07/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArtistTableViewController.h"
#import "SKSplashView.h"
#import "SKSplashIcon.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "LoginViewController.h"


@class AppDelegate;
@class MainViewController;
@interface SplashViewController : UIViewController

@property (strong, nonatomic) MainViewController *mainViewController;
@property (strong,nonatomic) AppDelegate * appDelegate;

@end

