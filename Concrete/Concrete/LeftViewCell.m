//
//  LeftMenuTableViewCell.m
//  Concrete
//
//  Created by TVTiOS-01 on 07/08/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import "LeftViewCell.h"

@implementation LeftViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.textLabel.font = [UIFont boldSystemFontOfSize:16.f];
        
        // -----
        
        _separatorView = [UIView new];
        [self addSubview:_separatorView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.textLabel.textColor = [UIColor colorWithRed:80.f green:80.f blue:80.f alpha:1.f];
    [self setShadow:self.textLabel];
    
    
    _separatorView.backgroundColor = [_tintColor colorWithAlphaComponent:0.4];
    
    CGFloat height = ([UIScreen mainScreen].scale == 1.f ? 1.f : 0.5);
    
    _separatorView.frame = CGRectMake(0.f, self.frame.size.height-height, self.frame.size.width*0.9, height);
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    if (highlighted)
        self.textLabel.textColor = [UIColor colorWithRed:255.f green:255.5 blue:255.f alpha:1.f];
    else
        self.textLabel.textColor = [UIColor colorWithRed:80.f green:80.f blue:80.f alpha:1.f];;
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
