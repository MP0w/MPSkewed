//
//  MPSkewedCollectionViewLayoutAttributes.h
//  MPSkewed
//
//  Created by Alex Manzella on 17/05/15.
//  Copyright (c) 2015 Alex Manzella. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface MPSkewedCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes <NSCopying>

@property (nonatomic, assign) CGFloat lineSpacing;
@property (nonatomic, assign) CGFloat parallaxValue;  //from 0 to 1

@end
