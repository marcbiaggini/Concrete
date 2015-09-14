//
//  ArtistaTableViewCell.m
//  Concrete
//
//  Created by TVTiOS-01 on 21/07/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import "ArtistaTableViewCell.h"

@implementation ArtistaTableViewCell


- (void)awakeFromNib {
    // Initialization code
    self.heartButton.backgroundColor = [UIColor clearColor];
    //[self likedObserver];
    [self setInteractions:self.heartButton];
    self.artistaImage.layer.borderWidth = 1.5;
    self.artistaImage.layer.borderColor = [[UIColor clearColor] CGColor];
    self.artistaImage.layer.cornerRadius = 5;
    self.artistaImage.layer.masksToBounds = YES;
    //self.faixaInferior.layer.cornerRadius = 5;
    self.faixaInferior.layer.masksToBounds = YES;
    [self setBackgroundColor:[UIColor clearColor]];
    self.artistaShoot = [[ShotsModel alloc] init];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if (selected){
        self.faixaInferior.backgroundColor = [UIColor colorWithRed:0.0f/255.0f
                                                             green:0.0f/255.0f
                                                              blue:0.0f/255.0f
                                                             alpha:0.5f];
        
        
    }
}

-(void)likedObserver
{
    PFQuery *query = [PFQuery queryWithClassName:@"LikedShoots"];
    NSString *idFacebook = [[NSUserDefaults standardUserDefaults]stringForKey:@"idFacebook"];
    [query whereKey:@"idConsumidor" equalTo:idFacebook];
    [query whereKey:@"title" equalTo:self.artistaTitle.text];
    [query findObjectsInBackgroundWithBlock:^(NSArray *likedObjects, NSError *error) {
        if (!error)
        {
            if(likedObjects.count>0 ){
                if(!self.isClicked)
                {
                    [self.heartButton setBackgroundImage:[UIImage imageNamed:@"fillHeart.png"] forState:UIControlStateNormal];
                    self.isClicked=YES;
                }
                
                
                
            }else
            {
                
                if(self.isClicked){
                [self.heartButton setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
                    self.isClicked=NO;
                }
                
            }
            
        }
        else
        {
            NSLog(@"%@",error);
        }
        
    }];
    
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted){
        self.faixaInferior.backgroundColor = [UIColor colorWithRed:0.0f/255.0f
                                                             green:0.0f/255.0f
                                                              blue:0.0f/255.0f
                                                             alpha:0.5f];
        
       }
}



-(void)setInteractions:(UIButton*)btn
{   btn.rac_command = [[RACCommand alloc] initWithEnabled:[RACSignal return:@YES] signalBlock:^RACSignal *(id input) {
    
    
        if(self.isClicked)
        {
            
            
            PFQuery *query = [PFQuery queryWithClassName:@"LikedShoots"];
            [query whereKey:@"idConsumidor" equalTo:[[NSUserDefaults standardUserDefaults]stringForKey:@"idFacebook"]];
            [query whereKey:@"title" equalTo:self.artistaTitle.text];

            [query findObjectsInBackgroundWithBlock:^(NSArray *deleteObjects, NSError *error) {
                if (!error)
                {
                    
                    for (PFObject *deleteObject in deleteObjects)
                    {
                        
                                [deleteObject deleteInBackground];
                                self.isClicked=NO;
                                [self.heartButton setBackgroundImage:[UIImage imageNamed:@" "] forState:UIControlStateNormal];
                        
                    }
                    
                }
                else
                {
                    NSLog(@"%@",error);
                }
                
            }];

            
        }else{
            
            
            PFQuery *query = [PFQuery queryWithClassName:@"LikedShoots"];
            [query whereKey:@"idConsumidor" equalTo:[[NSUserDefaults standardUserDefaults]stringForKey:@"idFacebook"]];
            [query whereKey:@"title" equalTo:self.artistaTitle.text];
            
            [query findObjectsInBackgroundWithBlock:^(NSArray *likedObjects, NSError *error) {
                if (!error)
                {
                    if(likedObjects.count==0){
                        PFObject *likedShootsObject = [PFObject objectWithClassName:@"LikedShoots"];
                        likedShootsObject[@"idConsumidor"] = [[NSUserDefaults standardUserDefaults]stringForKey:@"idFacebook"];
                        likedShootsObject[@"title"] = self.artistaTitle.text;
                        likedShootsObject[@"views"] = self.artistaViewCounter.text;
                        [likedShootsObject saveInBackground];
                        self.isClicked=YES;
                        [self.heartButton setBackgroundImage:[UIImage imageNamed:@"fillHeart.png"] forState:UIControlStateNormal];
                        NSData *imageData = UIImagePNGRepresentation(self.artistaImage.image);
                        PFFile *imageFile = [PFFile fileWithName:self.artistaTitle.text data:imageData];
                        [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            if (!error) {
                                if (succeeded) {
                                    
                                    
                                    likedShootsObject[@"image"] = imageFile;
                                    [likedShootsObject saveInBackground];
                                    
                                }
                            } else {
                                // Handle error
                                NSLog(@"%@",error);
                            }        
                        }];
                        
                        
                    }
                    
                }
                else
                {
                    NSLog(@"%@",error);
                }
                
            }];
            
            //Parse
            
        }
    
    
    return [RACSignal empty];
}];
    
}

@end
