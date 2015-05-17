//
//  MPSkewedCollectionViewLayout.m
//  MPSkewed
//
//  Created by Alex Manzella on 17/05/15.
//  Copyright (c) 2015 Alex Manzella. All rights reserved.
//

#import "MPSkewedParallaxLayout.h"
#import "MPSkewedCollectionViewLayoutAttributes.h"

@implementation MPSkewedParallaxLayout

+ (Class)layoutAttributesClass {
    return [MPSkewedCollectionViewLayoutAttributes class];
}

- (void)setMinimumLineSpacing:(CGFloat)minimumLineSpacing {
    [super setMinimumLineSpacing:-self.itemSize.height / 3];
}

- (void)setItemSize:(CGSize)itemSize {
    [super setItemSize:itemSize];
    [self setMinimumLineSpacing:-self.itemSize.height / 3];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    [attributes enumerateObjectsUsingBlock:^(MPSkewedCollectionViewLayoutAttributes* attribute, NSUInteger idx, BOOL *stop) {
        CGFloat offset = CGRectGetMinY(attribute.frame) - self.collectionView.contentOffset.y;
        CGFloat parallaxValue = offset / CGRectGetHeight(self.collectionView.bounds);
        attribute.parallaxValue = parallaxValue;
        attribute.lineSpacing = self.lineSpacing;
    }];

    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
