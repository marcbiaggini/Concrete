//
//  AppDelegate.h
//  Concrete
//
//  Created by TVTiOS-01 on 21/07/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "LGSideMenuController.h"
#import "MainViewController.h"
#import <Parse/Parse.h>

#warning CHOOSE TYPE 1 .. 5

#define TYPE 1

#define kMainViewController [(AppDelegate *)[[UIApplication sharedApplication] delegate] mainViewController]
#define kNavigationController (UINavigationController *)[[(AppDelegate *)[[UIApplication sharedApplication] delegate] mainViewController] rootViewController]

@class MainViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>



@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *mainViewController;



@end
