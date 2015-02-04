//
//  AlbumViewController.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-4.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "BaseViewController.h"
#import "AlbumHeaderView.h"
#import "AlbumCell.h"
#import "PullingRefreshTableView.h"

@interface AlbumViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,PullingRefreshTableViewDelegate>
{
    PullingRefreshTableView *albumTable;
    NSMutableArray *albumArray;
    NSInteger requestPage;
}
@end
