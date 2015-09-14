//
//  ContactTableViewCell.m
//  Concrete
//
//  Created by TVTiOS-01 on 18/08/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import "ContactTableViewCell.h"

@implementation ContactTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.contactContent.layer.borderWidth=0.15;
    self.contactContent.layer.cornerRadius = 5;
    self.contactContent.layer.masksToBounds = YES;
    self.profilePictureContact.layer.borderWidth = 2.5;
    self.profilePictureContact.layer.cornerRadius = self.profilePictureContact.frame.size.width/2;
    self.profilePictureContact.layer.masksToBounds = YES;

    [self setBackgroundColor:[UIColor clearColor]];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(self.faixaConatact.frame.origin.x, self.faixaConatact.frame.origin.y, self.contactContent.frame.size.width*2, self.faixaConatact.frame.size.height*0.5);//self.faxaDescription.frame;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor] CGColor], (id)[[UIColor colorWithRed:226.0/255.0 green:226.0/255.0 blue:226.0/255.0 alpha:1] CGColor], nil];
    [self.faixaConatact.layer insertSublayer:gradient atIndex:0];
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
