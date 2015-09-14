//
//  LoginViewController.h
//  Concrete
//
//  Created by TVTiOS-01 on 27/07/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "UITextField+BSErrorMessageView.h"
#import "MainViewController.h"
#import "LGSideMenuController.h"




@class MainViewController;
@interface LoginViewController : UIViewController 

@property (weak, nonatomic) IBOutlet UIView *Slogan;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIView *FBView;
@property (strong, nonatomic) MainViewController *mainViewController;


@end
