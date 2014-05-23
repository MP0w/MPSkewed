//
//  TWRMyCell.m
//  SkewedCollectionView
//
//  Created by Michelangelo Chasseur on 19/05/14.
//  Copyright (c) 2014 Touchware. All rights reserved.
//

#import "MPCell.h"
#import "UIView+Frame.h"


@interface MPCell ()

@end

@implementation MPCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds=NO;
        self.backgroundColor=[UIColor clearColor];

        imageView=[[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, 0, -frame.size.height/3)];
        imageView.backgroundColor=[UIColor clearColor];
        imageView.autoresizingMask=UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        imageView.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:imageView];
        imageView.clipsToBounds=NO;
        
        UIBezierPath* path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, self.height/3)];
        [path addLineToPoint:CGPointMake(self.width, 0)];
        [path addLineToPoint:CGPointMake(self.width, self.height)];
        [path addLineToPoint:CGPointMake(0, self.height+self.height/3)];
        [path closePath];
        
        realCellArea=path;
        
        
    }
    return self;
}



- (void)setImage:(UIImage *)image{
    _image=image;
    imageView.image=image;
}

- (void)drawRect:(CGRect)rect
{

    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(-imageView.x, -imageView.y+self.height/3)];
    [path addLineToPoint:CGPointMake(self.width-imageView.x, -imageView.y)];
    [path addLineToPoint:CGPointMake(self.width-imageView.x, -imageView.y+self.height)];
    [path addLineToPoint:CGPointMake(-imageView.x, -imageView.y+self.height+self.height/3)];
    [path closePath];

    
    
    CAShapeLayer *layer=[CAShapeLayer layer];
    layer.frame = imageView.bounds;
    layer.path = path.CGPath;
    
    imageView.layer.mask=layer;
    
}


//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    
//
//    BOOL contained=[realCellArea containsPoint:point];
//    if(contained){
//        return self;
//    }else return nil;
//    
//}


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{

    BOOL contained=[realCellArea containsPoint:point];
    
    return contained;
}

@end