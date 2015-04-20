//
//  IndexViewController.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-28.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "BaseViewController.h"
#import "MMWormhole.h"

@interface IndexViewController : BaseViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *waterView;
    NSArray *headerArray;
    NSMutableArray *discArray;
    NSMutableArray *classmateArray;
    NSMutableArray *applyArray;
}
@end
