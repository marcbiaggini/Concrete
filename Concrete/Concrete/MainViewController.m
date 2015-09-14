//
//  MainViewController.m
//  Concrete
//
//  Created by TVTiOS-01 on 06/08/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import "MainViewController.h"
@class LeftMenuTableViewController;

@interface MainViewController ()
@property (strong, nonatomic) LeftMenuTableViewController *leftViewController;

@end

@implementation MainViewController


- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    self = [super initWithRootViewController:rootViewController];
    if (self)
    {
        self.view.backgroundColor = [UIColor whiteColor];
        _leftViewController = [LeftMenuTableViewController new];
        
            [self setLeftViewEnabledWithWidth:250.f
                            presentationStyle:LGSideMenuPresentationStyleScaleFromBig
                         alwaysVisibleOptions:0];
            
            self.leftViewBackgroundImage = [UIImage imageNamed:@"blackBackground"];
            self.leftViewStatusBarVisibleOptions = LGSideMenuStatusBarVisibleOnPadLandscape;

            
            _leftViewController.tableView.backgroundColor = [UIColor clearColor];
            [_leftViewController.tableView reloadData];
            [self.leftView addSubview:_leftViewController.tableView];
        
        
    }
    return self;
    
}
- (void)leftViewWillLayoutSubviewsWithSize:(CGSize)size
{
    [super leftViewWillLayoutSubviewsWithSize:size];
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        if (self.isLeftViewAlwaysVisible)
        {
            _leftViewController.tableView.frame = CGRectMake(0.f , 20.f, size.width, size.height-20.f);
            _leftViewController.tableView.contentInset = UIEdgeInsetsMake(0.f, 0.f, 20.f, 0.f);
        }
        else
        {
            _leftViewController.tableView.frame = CGRectMake(0.f , 0.f, size.width, size.height);
            _leftViewController.tableView.contentInset = UIEdgeInsetsMake(20.f, 0.f, 20.f, 0.f);
        }
    }
    else _leftViewController.tableView.frame = CGRectMake(0.f , 0.f, size.width, size.height);
    
}

-(BOOL)prefersStatusBarHidden {
    
    return YES;
}


@end
