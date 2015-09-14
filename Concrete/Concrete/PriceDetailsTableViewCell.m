//
//  ArtistDetailsCellTableViewCell.m
//  Concrete
//
//  Created by TVTiOS-01 on 10/08/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import "PriceDetailsTableViewCell.h"

@implementation PriceDetailsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.priceContent.layer.borderWidth=0.1;
    self.priceContent.layer.cornerRadius = 5;
    self.priceContent.layer.masksToBounds = YES;
    [self setBackgroundColor:[UIColor clearColor]];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(self.faxaDescription.frame.origin.x, self.faxaDescription.frame.origin.y, self.priceContent.frame.size.width*2, self.faxaDescription.frame.size.height*0.5);//self.faxaDescription.frame;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor], (id)[[UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1] CGColor], nil];
    [self.faxaDescription.layer insertSublayer:gradient atIndex:0];
    
    self.descriptionView.layer.borderWidth=0.1;
    self.descriptionView.layer.cornerRadius = 5;
    self.descriptionView.layer.masksToBounds = YES;
    
    
    
    [self setShadow:self.diamondIcon];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setShadow:(UIView *) view
{
    CGSize shadowOffset = CGSizeMake(1.0, 1.0);
    float shadowOpacity = 0.5;
    CGColorRef shadowColor = [UIColor blackColor].CGColor;
    float shadowRadius = 0.6;
    
    view.layer.shadowOffset = shadowOffset;
    view.layer.shadowOpacity = shadowOpacity;
    view.layer.shadowColor = shadowColor;
    view.layer.shadowRadius = shadowRadius;
    
}

@end
