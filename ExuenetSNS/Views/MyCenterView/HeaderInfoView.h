//
//  HeaderInfoView.h
//  ExuenetSNS
//
//  Created by LeexMuller on 15/2/2.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^headClick)(void);

@interface HeaderInfoView : UIView
{
    UILabel *nameLabel;
    UILabel *levelLabel;
    UILabel *exuenetAcount;
    UIImageView *iconView;
    headClick click;
}
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *levelLabel;
@property (nonatomic, retain) UILabel *exuenetAcount;
@property (nonatomic, retain) UIImageView *iconView;

- (void)setCkicked:(headClick)complition;

@end
