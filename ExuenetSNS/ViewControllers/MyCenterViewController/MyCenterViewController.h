//
//  MyCenterViewController.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-30.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "BaseViewController.h"
#import "HeaderInfoView.h"
#import "ModifierViewController.h"
#import "AlbumViewController.h"

@interface MyCenterViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *infoTable;
    NSArray *titleArray;
    HeaderInfoView *infoView;
}
@end
