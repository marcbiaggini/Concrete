//
//  ArtistDetailsCellTableViewCell.h
//  Concrete
//
//  Created by TVTiOS-01 on 10/08/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceDetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *priceContent;
@property (weak, nonatomic) IBOutlet UILabel *descountPrice;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *discount;
@property (weak, nonatomic) IBOutlet UIView *descriptionView;
@property (weak, nonatomic) IBOutlet UIView *faxaDescription;

@property (weak, nonatomic) IBOutlet UILabel *descricaoTitulo;
@property (weak, nonatomic) IBOutlet UIImageView *diamondIcon;
@property (weak, nonatomic) IBOutlet UILabel *descricaoTexto;


@end
