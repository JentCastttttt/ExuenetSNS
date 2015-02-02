//
//  CollectionCell.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-2.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectionCell : UICollectionViewCell
{
    UIImageView *icon;
    UILabel* name;
}
@property (retain, nonatomic) UIImageView *icon;
@property (retain, nonatomic) UILabel* name;

@end
