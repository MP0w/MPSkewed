//
//  TWRMyCell.h
//  SkewedCollectionView
//
//  Created by Michelangelo Chasseur on 19/05/14.
//  Copyright (c) 2014 Touchware. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MPCell : UICollectionViewCell{
    
    UIImageView *imageView;
    
    UIBezierPath *realCellArea;
}

@property (nonatomic,readwrite) UIImage *image;
@property (nonatomic,readwrite) NSIndexPath *index;
@property (nonatomic,readwrite) NSInteger lineSpacing;

@end
