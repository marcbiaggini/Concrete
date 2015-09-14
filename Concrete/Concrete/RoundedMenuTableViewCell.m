//
//  HexagonTableViewCell.m
//  Concrete
//
//  Created by TVTiOS-01 on 12/08/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import "RoundedMenuTableViewCell.h"


@implementation RoundedMenuTableViewCell


- (void)awakeFromNib {
    // Initialization code
    self.isObserving = NO;
    self.backgroundColor = [UIColor clearColor];
    self.buttonsArray = [[NSMutableArray alloc]init];
    [self.buttonsArray addObject:self.colarButton];
    [self.buttonsArray addObject:self.birncoButton];
    [self.buttonsArray addObject:self.sharedButton];
    [self.buttonsArray addObject:self.likedButton];
    [self.buttonsArray addObject:self.conjuntoButton];
    [self.buttonsArray addObject:self.pulseiraButton];
    [self.buttonsArray addObject:self.profilePicture];
    for (int i=0; i<self.buttonsArray.count; i++) {
        
        if([[self.buttonsArray objectAtIndex:i] isKindOfClass:[UIImageView class]]){
            [self setRounded:[self.buttonsArray objectAtIndex:i] withRadius:40];
        }else{
            [self setRounded:[self.buttonsArray objectAtIndex:i] withRadius:25];
        }
        
        [self setShadow:[self.buttonsArray objectAtIndex:i]];
    }
    [self setInteractions:self.colarButton];
    [self setInteractions:self.birncoButton];
    [self setInteractions:self.conjuntoButton];
    [self setInteractions:self.pulseiraButton];
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
//                  {
//                      dispatch_async(dispatch_get_main_queue(), ^{
//                          
//                      });
//                      
//                  });
    
   
    
    


    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



-(void)setRounded:(UIView*) uiView withRadius:(float) radius
{
    uiView.layer.borderWidth = 1.5;
    uiView.layer.borderColor = [[UIColor clearColor] CGColor];
    uiView.layer.cornerRadius = radius;
    uiView.layer.masksToBounds = YES;
    
}


-(void)setShadow:(UIView *) view
{
    CGSize shadowOffset = CGSizeMake(2.0, 1.0);
    float shadowOpacity = 0.5;
    CGColorRef shadowColor = [UIColor whiteColor].CGColor;
    float shadowRadius = 0.6;
    
    view.layer.shadowOffset = shadowOffset;
    view.layer.shadowOpacity = shadowOpacity;
    view.layer.shadowColor = shadowColor;
    view.layer.shadowRadius = shadowRadius;
    
}

- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

-(void)setInteractions:(UIButton*)btn
{   btn.rac_command = [[RACCommand alloc] initWithEnabled:[RACSignal return:@YES] signalBlock:^RACSignal *(id input) {
    
    [self runSpinAnimationOnView:btn duration:1.0 rotations:1.5 repeat:1];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.6 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        
        ArtistTableViewController *viewController = [ArtistTableViewController new];
        
        LeftMenuTableViewController *viewController2 = [LeftMenuTableViewController new];
        viewController2.view.backgroundColor = [UIColor whiteColor];
        
        [kNavigationController setViewControllers:@[viewController2, viewController]];

        [kMainViewController hideLeftViewAnimated:YES completionHandler:nil];
        
        
    });
    
    
    return [RACSignal empty];
}];
    
    
    
}

-(void)setProfileUserPicture

{
    if ([FBSDKAccessToken currentAccessToken]){
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
        self.isObserving = NO;
        
        FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields" : @"id,email,name"}];
        
        
        [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            
            // handle response
            if (!error) {
                // result is a dictionary with the user's Facebook data
                NSDictionary *userData = (NSDictionary *)result;
                
                NSString *facebookID = userData[@"id"];
                [[NSUserDefaults standardUserDefaults] setObject:facebookID forKey:@"idFacebook"];

                NSString *name = userData[@"name"];
                NSString *email = userData[@"email"];
                
                
                PFQuery *query = [PFQuery queryWithClassName:@"Consumidor"];                        [query whereKey:@"idFacebook" equalTo:facebookID];
                
                [query findObjectsInBackgroundWithBlock:^(NSArray *consumidorObjects, NSError *error) {
                    if (!error)
                    {
                        if(consumidorObjects.count==0){
                            PFObject *consumidorObject = [PFObject objectWithClassName:@"Consumidor"];
                            consumidorObject[@"idFacebook"] = facebookID;
                            consumidorObject[@"email"] = email;
                            consumidorObject[@"nombre"] = name;
                            [consumidorObject saveInBackground];
                        }
                        
                    }
                    else
                    {
                        NSLog(@"%@",error);
                    }
                    
                }];

                //            NSString *gender = userData[@"gender"];
                //            NSString *birthday = userData[@"birthday"];
                //            NSString *relationship = userData[@"relationship_status"];
                
                NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
                NSURLRequest *urlRequest = [NSURLRequest requestWithURL:pictureURL];
                
                // Run network request asynchronously
                [NSURLConnection sendAsynchronousRequest:urlRequest
                                                   queue:[NSOperationQueue mainQueue]
                                       completionHandler:
                 ^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                     if (connectionError == nil && data != nil) {
                         // Set the image in the imageView
                         [self.profilePicture setImage:[UIImage imageWithData:data]];
                         
                         [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
                         
                     }
                 }];
            }
            
        }];

        
    }else
    {
        if(!self.isObserving){
            self.isObserving=YES;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loadProfilePicture:)
                                                     name:nil object:nil];
        }
    }
    
    
}

-(void)loadProfilePicture:(NSNotification*)aNotification
{
    [self setProfileUserPicture];
}

@end
