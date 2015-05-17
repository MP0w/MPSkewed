//
//  MPSkewedCollectionViewLayoutAttributes.m
//  MPSkewed
//
//  Created by Alex Manzella on 17/05/15.
//  Copyright (c) 2015 Alex Manzella. All rights reserved.
//

#import "MPSkewedCollectionViewLayoutAttributes.h"

@implementation MPSkewedCollectionViewLayoutAttributes

- (instancetype)copyWithZone:(struct _NSZone *)zone {
    MPSkewedCollectionViewLayoutAttributes *newAttribute = [super copyWithZone:zone];
    newAttribute.parallaxValue = self.parallaxValue;
    newAttribute.lineSpacing = self.lineSpacing;
    return newAttribute;
}

- (BOOL)isEqual:(MPSkewedCollectionViewLayoutAttributes *)object {
    return [super isEqual:object] && self.parallaxValue == object.parallaxValue && self.lineSpacing == object.lineSpacing;
}

@end
