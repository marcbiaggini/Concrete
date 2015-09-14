//
//  LoginViewController.m
//  Concrete
//
//  Created by TVTiOS-01 on 27/07/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setUserInteractionEnabled:NO];
    [kMainViewController setLeftViewSwipeGestureEnabled:NO];
    self.usernameTextField.hidden = YES;
    self.passwordTextField.hidden = YES;
    self.signInButton.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setLogin:)
                                                 name:nil object:nil];
    
 
}

-(void)viewDidAppear:(BOOL)animated
{
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"colorsBG.png"]];
    backgroundView.frame = self.view.bounds;
    [[self view] addSubview:backgroundView];
    [[self view] sendSubviewToBack:backgroundView];
    [self setupFacebookAccess];
    [self setupRACValidLogin];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setErrorMessage
{
    [self.passwordTextField bs_setupErrorMessageViewWithMessage:@"Minimo 6 carateres*"];
    [self.usernameTextField bs_setupErrorMessageViewWithMessage:@"Nome do Usuario*"];
    
}

-(void)setupRACValidLogin
{
    [self setErrorMessage];
    
    //Define Signals to valid Username and Password
    RACSignal *validUsernameSignal =
    [self.usernameTextField.rac_textSignal
     map:^id(NSString *text) {
         return @([self isValidUsername:text]);
     }];
    
    RACSignal *validPasswordSignal =
    [self.passwordTextField.rac_textSignal
     map:^id(NSString *text) {
         return @([self isValidPassword:text]);
     }];
    
    //Used to active signals
    RAC(self.passwordTextField, backgroundColor) =
    [validPasswordSignal
     map:^id(NSNumber *passwordValid) {
         return [passwordValid boolValue] ? [UIColor greenColor] : [UIColor clearColor];
     }];
    
    RAC(self.usernameTextField, backgroundColor) =
    [validUsernameSignal
     map:^id(NSNumber *userValid) {
         return [userValid boolValue] ? [UIColor greenColor] : [UIColor clearColor];
     }];
    
    //Used to Combine Signals
    RACSignal *signUpActiveSignal =
    [RACSignal combineLatest:@[validUsernameSignal, validPasswordSignal]
                      reduce:^id(NSNumber *usernameValid, NSNumber *passwordValid) {
                          return @([usernameValid boolValue] && [passwordValid boolValue]);
                      }];
    
    [signUpActiveSignal subscribeNext:^(NSNumber *signupActive) {
        self.signInButton.enabled = [signupActive boolValue];
    }];
    
    //Sign in to NextView
    [[self.signInButton
      rac_signalForControlEvents:UIControlEventTouchUpInside]
     subscribeNext:^(id x) {
         
         UIStoryboard *storyboard = self.storyboard;
         UITableViewController *svc = [storyboard instantiateViewControllerWithIdentifier:@"ArtistaTableview"];
         
         // Configure the new view controller here.
         
         [self presentViewController:svc animated:YES completion:nil];
         
     }];
}

-(BOOL)isValidPassword:(NSString *)password
{
    switch (password.length) {
        case 0:
            [self.passwordTextField bs_showError];
            return NO;
            break;
            
        default:
            if(password.length>=6){
                [self.passwordTextField bs_hideError];
                
                return YES;
            }else{
                [self.passwordTextField bs_showError];
                return NO;
            }
            
            
            break;
    }
    
}

-(BOOL)isValidUsername:(NSString *)userName
{
    switch (userName.length) {
        case 0:
            
            [self.usernameTextField bs_showError];
            return NO;
            break;
            
        default:
            
                [self.usernameTextField bs_hideError];
                return YES;
           
            
            break;
    }
}

-(void) setupFacebookAccess
{
    [self setRounded:self.FBView];
FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];

                         loginButton.frame = CGRectMake(self.FBView.bounds.origin.x , self.FBView.bounds.origin.y, self.FBView.bounds.size.width,self.FBView.bounds.size.height);
                         loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends", @"user_photos"];
                         [self.FBView addSubview:loginButton];
    
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options: UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         
                         
                         self.Slogan.transform = CGAffineTransformMakeRotation(-0.1);
                         
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.5
                                               delay:1.0
                                             options: UIViewAnimationOptionBeginFromCurrentState
                                          animations:^{
                                              
                                              self.FBView.transform = CGAffineTransformMakeScale(1.15, 1.15);

                                          }
                                          completion:^(BOOL finished){
                                              [self.view setUserInteractionEnabled:YES];

                                          }];
                         
                     }];
    

    

}

-(void)setRounded:(UIView*) uiView
{
    uiView.layer.borderWidth = 1.5;
    uiView.layer.borderColor = [[UIColor clearColor] CGColor];
    uiView.layer.cornerRadius = uiView.frame.size.width*0.1;
    uiView.layer.masksToBounds = YES;
    
}

-(void)setLogin:(NSNotification*)aNotification
{

    if ([FBSDKAccessToken currentAccessToken]) {
        
        // User is logged in, do work such as go to next view controller.

        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
        [kMainViewController setLeftViewSwipeGestureEnabled:YES];

        ArtistTableViewController *viewController = [ArtistTableViewController new];
        
        
        LeftMenuTableViewController *viewController2 = [LeftMenuTableViewController new];
        viewController2.view.backgroundColor = [UIColor whiteColor];
        
        [kNavigationController setViewControllers:@[viewController2, viewController]];
        
        [kMainViewController hideLeftViewAnimated:YES completionHandler:nil];
    }
}


@end
