//
//  MPSkewedCell.m
//  MPSkewed
//
//  Created by Alex Manzella on 17/05/15.
//  Copyright (c) 2015 Alex Manzella. All rights reserved.
//

#import "MPSkewedCell.h"
#import <QuartzCore/QuartzCore.h>
#import "MPSkewedCollectionViewLayoutAttributes.h"

@interface MPSkewedCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, weak) UILabel *textLabel;
@property (nonatomic, weak) CAGradientLayer *gradient;
// Layout customizations
@property (nonatomic, assign) CGFloat parallaxValue; //from 0 to 1
@property (nonatomic, assign) CGFloat lineSpacing;

@end

@implementation MPSkewedCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = NO;
        self.backgroundColor = [UIColor clearColor];
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectInset(self.bounds, 0, -CGRectGetHeight(frame) / 3)];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        _imageView.layer.mask = [CAShapeLayer layer];
        [self addSubview:_imageView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat offset = self.frame.origin.y - [(UICollectionView *)[self superview] contentOffset].y;
    CGFloat parallaxValue = offset/self.superview.frame.size.height;
    self.imageView.frame = CGRectInset(self.bounds, 0, -CGRectGetHeight(self.bounds) / 3);
    self.gradient.frame = self.imageView.bounds;
    self.parallaxValue = parallaxValue;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    CGFloat realH = CGRectGetHeight(self.bounds) * 2 / 3 - self.lineSpacing;
    CGFloat width = CGRectGetWidth(self.bounds);
    UIBezierPath* realCellArea = [UIBezierPath bezierPath];
    [realCellArea moveToPoint:CGPointMake(0, realH/3)];
    [realCellArea addLineToPoint:CGPointMake(width, 0)];
    [realCellArea addLineToPoint:CGPointMake(width, realH)];
    [realCellArea addLineToPoint:CGPointMake(0, realH+realH/3)];
    [realCellArea closePath];
    
    return [realCellArea containsPoint:point];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self updateImageViewMask];
}

- (void)applyLayoutAttributes:(MPSkewedCollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    self.lineSpacing = layoutAttributes.lineSpacing;
    self.parallaxValue = layoutAttributes.parallaxValue;
}


- (void)setParallaxValue:(CGFloat)parallaxValue {
    _parallaxValue = parallaxValue;
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat maxOffset = -height / 3 - height / 3;
    
    CGRect frame = self.imageView.frame;
    frame.origin.y = maxOffset * parallaxValue;
    self.imageView.frame = frame;
    
    [self updateImageViewMask];
}

#pragma mark - Skewed Mask

- (void)updateImageViewMask {
    CAShapeLayer *layer = (CAShapeLayer *)self.imageView.layer.mask;
    layer.frame = self.imageView.bounds;
    layer.path = [self maskPath];
}

- (CGPathRef)maskPath {
    CGFloat realH = CGRectGetHeight(self.bounds) * 2 / 3 - self.lineSpacing;
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat imageViewX = CGRectGetMinX(self.imageView.frame);
    CGFloat imageViewY = CGRectGetMinY(self.imageView.frame);
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(-imageViewX, -imageViewY + realH / 3)];
    [path addLineToPoint:CGPointMake(width - imageViewX, -imageViewY)];
    [path addLineToPoint:CGPointMake(width - imageViewX, -imageViewY + realH)];
    [path addLineToPoint:CGPointMake(-imageViewX, -imageViewY+ realH + realH / 3)];
    [path closePath];
    
    return path.CGPath;
}

#pragma mark - Styling

- (UIImage *)image {
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

- (NSString *)text {
    return self.textLabel.text;
}

- (void)setText:(NSString *)text {
    [self setupLabelIfNeeded:text];
    self.textLabel.text = text;
}

#pragma mark - LabelSetup

- (void)setupLabelIfNeeded:(NSString *)text {
    if (text) {
        if (!self.gradient) {
            CAGradientLayer *gradient = [CAGradientLayer layer];
            gradient.frame = self.imageView.bounds;
            gradient.colors = @[(id)[UIColor colorWithWhite:0 alpha:.85].CGColor,(id)[UIColor clearColor].CGColor];
            gradient.startPoint = CGPointMake(.0, .5);
            gradient.endPoint = CGPointMake(.5, .35);
            [self.imageView.layer addSublayer:gradient];
            self.gradient = gradient;
        }
        
        if (!self.textLabel) {
            CGFloat realH = CGRectGetHeight(self.bounds) * 2 / 3 - self.lineSpacing;
            CGFloat latoA = realH / 3;
            CGFloat width = CGRectGetWidth(self.bounds);
            
            UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, latoA / 2, width - 20, realH)];
            textLabel.layer.anchorPoint = CGPointMake(.5, .5);
            textLabel.font = [UIFont fontWithName:@"HelveticaNeue-ultralight" size:38];
            textLabel.numberOfLines = 3;
            textLabel.textColor = [UIColor whiteColor];
            textLabel.shadowColor = [UIColor blackColor];
            textLabel.shadowOffset = CGSizeMake(1, 1);
            textLabel.transform = CGAffineTransformMakeRotation(-(asin(latoA/(sqrt(pow(width, 2) + pow(latoA, 2))))));
            [self addSubview:textLabel];
            self.textLabel = textLabel;
        }
    } else {
        [self.gradient removeFromSuperlayer];
        [self.textLabel removeFromSuperview];
    }
}

@end
