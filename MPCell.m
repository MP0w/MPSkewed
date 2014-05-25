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
        
        
        
        self.lineSpacing=20;

                

    }
    return self;
}


- (void)setLineSpacing:(NSInteger)lineSpacing{
    _lineSpacing=lineSpacing;
    
    CGFloat realH=self.height*2/3-lineSpacing;

    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, realH/3)];
    [path addLineToPoint:CGPointMake(self.width, 0)];
    [path addLineToPoint:CGPointMake(self.width, realH)];
    [path addLineToPoint:CGPointMake(0, realH+realH/3)];
    [path closePath];
        
    realCellArea=path;
    
    [self setNeedsDisplay];
}

- (void)setImage:(UIImage *)image{
    _image=image;
    imageView.image=image;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat realH=self.height*2/3-self.lineSpacing;


    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(-imageView.x, -imageView.y+realH/3)];
    [path addLineToPoint:CGPointMake(self.width-imageView.x, -imageView.y)];
    [path addLineToPoint:CGPointMake(self.width-imageView.x, -imageView.y+realH)];
    [path addLineToPoint:CGPointMake(-imageView.x, -imageView.y+realH+realH/3)];
    [path closePath];

    
    
    CAShapeLayer *layer=[CAShapeLayer layer];
    layer.frame = imageView.bounds;
    layer.path = path.CGPath;
    
    imageView.layer.mask=layer;
    
}



- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{

    BOOL contained=[realCellArea containsPoint:point];
    
    return contained;
}

@end