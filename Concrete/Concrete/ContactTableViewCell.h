//
//  ContactTableViewCell.h
//  Concrete
//
//  Created by TVTiOS-01 on 18/08/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profilePictureContact;
@property (weak, nonatomic) IBOutlet UILabel *nomeContact;
@property (weak, nonatomic) IBOutlet UILabel *telefoneContact;
@property (weak, nonatomic) IBOutlet UILabel *emailContact;
@property (weak, nonatomic) IBOutlet UIView *contactContent;
@property (weak, nonatomic) IBOutlet UIView *faixaConatact;

@end
