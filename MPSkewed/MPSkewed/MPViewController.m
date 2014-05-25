//
//  MPViewController.m
//  MPSkewed
//
//  Created by Alex Manzella on 23/05/14.
//  Copyright (c) 2014 mpow. All rights reserved.
//

#import "MPViewController.h"
#import "MPSkewedCell.h"
#import "MPSkewedParallaxLayout.h"

static NSString *kCell=@"cell";


#define PARALLAX_ENABLED 1

@interface MPViewController ()

@end

@implementation MPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationController.navigationBarHidden=YES;

#ifndef PARALLAX_ENABLED
    // you can use that if you don't need parallax
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    layout.itemSize=CGSizeMake(self.view.width, 230);
    layout.minimumLineSpacing=-layout.itemSize.height/3; // must be always the itemSize/3
    //use the layout you want as soon as you respect what I said... same height and line spacing =...

#else
    
    MPSkewedParallaxLayout *layout=[[MPSkewedParallaxLayout alloc] init];

    
#endif
    
    
    _collectionView=[[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.backgroundColor=[UIColor blackColor];
    [_collectionView registerClass:[MPSkewedCell class] forCellWithReuseIdentifier:kCell];
    [self.view addSubview:_collectionView];
    
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MPSkewedCell* cell = (MPSkewedCell *) [collectionView dequeueReusableCellWithReuseIdentifier:kCell forIndexPath:indexPath];
    
    cell.image=[UIImage imageNamed:[NSString stringWithFormat:@"%li",indexPath.item%5+1]];
    cell.index=indexPath;
    
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    NSLog(@"item %li",(long)indexPath.item);

}

@end
