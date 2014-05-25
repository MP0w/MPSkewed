//
//  MPSkewedParallaxLayout.m
//  MPSkewed
//
//  Created by Alex Manzella on 25/05/14.
//  Copyright (c) 2014 mpow. All rights reserved.
//

#import "MPSkewedParallaxLayout.h"
#import "MPSkewedCell.h"

@implementation MPSkewedParallaxLayout


- (id)init{
    
    if (self=[super init]) {
        
        self.itemSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, 250);
        
    }
    
    return self;
}


- (void)setMinimumLineSpacing:(CGFloat)minimumLineSpacing{
    
    [super setMinimumLineSpacing:-self.itemSize.height/3];
    
}


- (void)setItemSize:(CGSize)itemSize{
    [super setItemSize:itemSize];
    [self setMinimumLineSpacing:-self.itemSize.height/3];
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    
    NSArray *attributes=[super layoutAttributesForElementsInRect:rect];
    

    
    [attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes* attribute, NSUInteger idx, BOOL *stop) {
       
        CGFloat offset=attribute.frame.origin.y-self.collectionView.contentOffset.y;
                
        CGFloat parallaxValue=offset/self.collectionView.frame.size.height;

        
        MPSkewedCell *cell=(MPSkewedCell *)[self.collectionView cellForItemAtIndexPath:attribute.indexPath];
        cell.parallaxValue=parallaxValue;
        
    }];
    
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

@end
