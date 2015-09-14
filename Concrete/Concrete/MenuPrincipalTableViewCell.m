//
//  MenuPrincipalTableViewCell.m
//  Concrete
//
//  Created by TVTiOS-01 on 12/08/15.
//  Copyright (c) 2015 juan. All rights reserved.
//

#import "MenuPrincipalTableViewCell.h"

@implementation MenuPrincipalTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self setPoligon:self.okCell1];
    [self setPoligon:self.okCell2];
    [self setPoligon:self.okCell3];



}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setPoligon:(UIView*)view
{
    self.backgroundColor = [UIColor clearColor];
    [self setRounded:self];
    CGFloat lineWidth    = 0.7;
    UIBezierPath *path   = [self roundedPolygonPathWithRect:view.bounds
                                                  lineWidth:lineWidth
                                                      sides:6
                                               cornerRadius:3];
    
    CAShapeLayer *mask   = [CAShapeLayer layer];
    mask.path            = path.CGPath;
    mask.lineWidth       = lineWidth;
    mask.strokeColor     = [UIColor clearColor].CGColor;
    mask.fillColor       = [UIColor whiteColor].CGColor;
    self.imageView.layer.mask = mask;
    
    CAShapeLayer *border = [CAShapeLayer layer];
    border.path          = path.CGPath;
    border.lineWidth     = lineWidth;
    border.strokeColor   = [UIColor whiteColor].CGColor;
    border.fillColor     = [UIColor clearColor].CGColor;
    [view.layer addSublayer:border];
}

- (UIBezierPath *)roundedPolygonPathWithRect:(CGRect)square
                                   lineWidth:(CGFloat)lineWidth
                                       sides:(NSInteger)sides
                                cornerRadius:(CGFloat)cornerRadius
{
    UIBezierPath *path  = [UIBezierPath bezierPath];
    
    CGFloat theta       = 2.0 * M_PI / sides;                           // how much to turn at every corner
    CGFloat offset      = cornerRadius * tanf(theta / 2.0);             // offset from which to start rounding corners
    CGFloat squareWidth = MIN(square.size.width, square.size.height);   // width of the square
    
    // calculate the length of the sides of the polygon
    
    CGFloat length      = squareWidth - lineWidth;
    if (sides % 4 != 0) {                                               // if not dealing with polygon which will be square with all sides ...
        length = length * cosf(theta / 2.0) + offset/2.0;               // ... offset it inside a circle inside the square
    }
    CGFloat sideLength = length * tanf(theta / 2.0);
    
    // start drawing at `point` in lower right corner
    
    CGPoint point = CGPointMake(squareWidth / 2.0 + sideLength / 2.0 - offset, squareWidth - (squareWidth - length) / 2.0);
    CGFloat angle = M_PI;
    [path moveToPoint:point];
    
    // draw the sides and rounded corners of the polygon
    
    for (NSInteger side = 0; side < sides; side++) {
        point = CGPointMake(point.x + (sideLength - offset * 2.0) * cosf(angle), point.y + (sideLength - offset * 2.0) * sinf(angle));
        [path addLineToPoint:point];
        
        CGPoint center = CGPointMake(point.x + cornerRadius * cosf(angle + M_PI_2), point.y + cornerRadius * sinf(angle + M_PI_2));
        [path addArcWithCenter:center radius:cornerRadius startAngle:angle - M_PI_2 endAngle:angle + theta - M_PI_2 clockwise:YES];
        
        point = path.currentPoint; // we don't have to calculate where the arc ended ... UIBezierPath did that for us
        angle += theta;
    }
    
    [path closePath];
    
    return path;
}
-(void)setRounded:(UIView*) uiView
{
    uiView.layer.borderWidth = 0.1;
    uiView.layer.borderColor = [[UIColor clearColor] CGColor];
    uiView.layer.cornerRadius = 5;
    uiView.layer.masksToBounds = YES;
    
}

@end
