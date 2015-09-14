//
//  ArtistaTableViewCell.h
//  Concrete
//
//  Created by TVTiOS-01 on 21/07/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <Parse/Parse.h>
#import "ShotsModel.h"



@interface ArtistaTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *faixaInferior;
@property (weak, nonatomic)  IBOutlet UIButton *heartButton;

@property (weak, nonatomic) IBOutlet UIImageView *artistaImage;
@property (weak, nonatomic) IBOutlet UILabel *artistaTitle;
@property (weak, nonatomic) IBOutlet UILabel *artistaViewCounter;
@property (assign,nonatomic) BOOL isClicked;

@property (weak, nonatomic) IBOutlet UIImageView *heart;
@property (strong,nonatomic)ShotsModel *artistaShoot;

-(void)likedObserver;


@end

