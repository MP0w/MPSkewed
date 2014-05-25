//
//  TWRMyCell.h
//  SkewedCollectionView
//
//  Created by Michelangelo Chasseur on 19/05/14.
//  Copyright (c) 2014 Touchware. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MPSkewedCell : UICollectionViewCell{
        
    UIBezierPath *realCellArea;
    
    CAGradientLayer *gradient;
}

@property (nonatomic,readwrite) UIImage *image;
@property (nonatomic,readwrite) NSInteger lineSpacing;
@property (nonatomic,readwrite) UIImageView *imageView;
@property (nonatomic,readwrite) UILabel *textLabel;
@property (nonatomic,readwrite) NSString *text;

@property (nonatomic,assign) CGFloat parallaxValue; //from 0 to 1


@end
