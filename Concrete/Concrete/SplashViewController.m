//
//  ViewController.m
//  Concrete
//
//  Created by TVTiOS-01 on 21/07/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    // Delay execution of my block for 3 seconds.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        [self setLogin];
        
        
    });
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"colorsBG.png"]];
    backgroundView.frame = self.view.bounds;
    [[self view] addSubview:backgroundView];
    [[self view] sendSubviewToBack:backgroundView];
    
   
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    SKSplashIcon *splashIcon = [[SKSplashIcon alloc] initWithImage:[UIImage imageNamed:@"imagebg333"] animationType:SKIconAnimationTypeNone];
    
    splashIcon.frame = CGRectMake(0, 0, 200, 200);
    [self setRounded:splashIcon];
    
    
    SKSplashView *splashView = [[SKSplashView alloc] initWithSplashIcon:splashIcon animationType:SKSplashAnimationTypeZoom];
    //The SplashView can be initialized with a variety of animation types and backgrounds. See customizability for more.
    splashView.animationDuration = 5.5f; //Set the animation duration (Default: 1s)
    [self.view addSubview:splashView]; //Add the splash view to your current view
    [splashView startAnimation]; //Call this method to start the splash animation
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setRounded:(UIView*) uiView
{
    uiView.layer.borderWidth = 12.5;
    uiView.layer.borderColor = [[UIColor clearColor] CGColor];
    uiView.layer.cornerRadius = 300;
    uiView.layer.masksToBounds = YES;
    
}

-(void)setLogin
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
        
    }else{
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];;
        
        LoginViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginView"];
        
        //ArtistTableViewController *viewController = [ArtistTableViewController new];
        
        
        ArtistTableViewController *viewController2 = [ArtistTableViewController new];
        viewController2.view.backgroundColor = [UIColor whiteColor];
        
        [kNavigationController setViewControllers:@[viewController2, viewController]];
        
        [kMainViewController hideLeftViewAnimated:YES completionHandler:nil];
    }
}


@end
