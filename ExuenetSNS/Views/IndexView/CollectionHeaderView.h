//
//  CollectionHeaderView.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-2.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^headerClickedBlock)(NSInteger section);

@interface CollectionHeaderView : UICollectionReusableView
{
    headerClickedBlock block;
    NSInteger section;
    UILabel *nameLabel;
}
@property (nonatomic, assign)NSInteger section;
@property (nonatomic, retain)UILabel *nameLabel;

- (void)headerClickedAtSection:(headerClickedBlock)completion;

@end
