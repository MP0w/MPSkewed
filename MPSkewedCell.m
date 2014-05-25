//
//  TWRMyCell.m
//  SkewedCollectionView
//
//  Created by Michelangelo Chasseur on 19/05/14.
//  Copyright (c) 2014 Touchware. All rights reserved.
//

#import "MPSkewedCell.h"
#import "UIView+Frame.h"


@interface MPSkewedCell ()

@end

@implementation MPSkewedCell


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.clipsToBounds=NO;
        self.backgroundColor=[UIColor clearColor];

        _imageView=[[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, 0, -frame.size.height/3)];
        _imageView.backgroundColor=[UIColor clearColor];
        _imageView.autoresizingMask=UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _imageView.contentMode=UIViewContentModeScaleAspectFill;
        [self addSubview:_imageView];
        _imageView.clipsToBounds=YES;
        
        self.lineSpacing=15;

                

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
    _imageView.image=image;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat realH=self.height*2/3-self.lineSpacing;


    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(-_imageView.x, -_imageView.y+realH/3)];
    [path addLineToPoint:CGPointMake(self.width-_imageView.x, -_imageView.y)];
    [path addLineToPoint:CGPointMake(self.width-_imageView.x, -_imageView.y+realH)];
    [path addLineToPoint:CGPointMake(-_imageView.x, -_imageView.y+realH+realH/3)];
    [path closePath];

    
    
    CAShapeLayer *layer=[CAShapeLayer layer];
    layer.frame = _imageView.bounds;
    layer.path = path.CGPath;
    
    _imageView.layer.mask=layer;
    
}



- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{

    BOOL contained=[realCellArea containsPoint:point];
    
    return contained;
}

- (void)setParallaxValue:(CGFloat)parallaxValue{
    
    CGFloat realH=self.height*2/3-self.lineSpacing;

    
    CGFloat maxOffset=-self.height/3-self.height/3;
    
    _imageView.y=maxOffset*parallaxValue;

    
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(-_imageView.x, -_imageView.y+realH/3)];
    [path addLineToPoint:CGPointMake(self.width-_imageView.x, -_imageView.y)];
    [path addLineToPoint:CGPointMake(self.width-_imageView.x, -_imageView.y+realH)];
    [path addLineToPoint:CGPointMake(-_imageView.x, -_imageView.y+realH+realH/3)];
    [path closePath];
    
    CAShapeLayer *layer=[CAShapeLayer layer];
    layer.frame = _imageView.bounds;
    layer.path = path.CGPath;
    
    _imageView.layer.mask=layer;

}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat offset=self.frame.origin.y-[(UICollectionView *)[self superview] contentOffset].y;
    CGFloat parallaxValue=offset/self.superview.frame.size.height;
    self.parallaxValue=parallaxValue;
}

@end