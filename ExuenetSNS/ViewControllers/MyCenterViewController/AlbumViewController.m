//
//  AlbumViewController.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-4.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "AlbumViewController.h"

@interface AlbumViewController ()

@end

@implementation AlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tabBarController.tabBar setHidden:YES];
    
    albumTable = [[PullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) pullingDelegate:self];
    albumTable.showsVerticalScrollIndicator = NO;
    albumTable.delegate = self;
    albumTable.dataSource = self;
    albumTable.headerOnly = YES;
    albumTable.backgroundColor = [UIColor colorWithRed:0.48 green:0.31 blue:0.65 alpha:1];
    albumTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:albumTable];
    [albumTable release];
    
    albumArray = [[NSMutableArray alloc] init];
    requestPage = 1;
    
    headerView = [[AlbumHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    albumTable.tableHeaderView = headerView;
    
    [headerView examineAlbumWithCompletion:^(UIImage *icon) {
        NSLog(@"查看头像");
        [headerView.avatarView setImage:[UIImage imageNamed:@"1.png"]];
    }];
    
    [headerView changeAlbumWithCompletion:^{
        NSLog(@"查看头像");
    }];
    
    [headerView requestAlbumPhotoWithCompletion:^{
        NSLog(@"发送状态和相册照片");
    }];
    
    [headerView release];
}

#pragma mark - 上拉下拉刷新代理
#pragma mark - PullingRefreshTableViewDelegate
//加载数据方法
- (void)loadData
{
    
}

/*!
 *  刷新数据
 */
- (void)refreshRequest
{
    requestPage = 1;
    albumTable.headerOnly = NO;

}

//下拉刷新操作
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView
{
    [self performSelector:@selector(refreshRequest) withObject:nil afterDelay:1.0f];
}

//刷新完成时间
- (NSDate *)pullingTableViewRefreshingFinishedDate
{
    //创建一个NSDataFormatter显示刷新时间
    NSDateFormatter *df = [[NSDateFormatter alloc] init ];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    NSString *dateStr = [df stringFromDate:[NSDate date]];
    NSDate *date = [df dateFromString:dateStr];
    [df release];
    return date;
}

//上拉  Implement this method if headerOnly is false
- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView
{
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.3f];
}

#pragma mark -
#pragma mark - ScrollView Method
//手指开始拖动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [albumTable tableViewDidScroll:scrollView];
}

//手指结束拖动方法
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [albumTable tableViewDidEndDragging:scrollView];
}

#pragma mark - tableView代理
#pragma mark - tableViewDelegate/tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    AlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[AlbumCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [albumArray release];
    [super dealloc];
}

@end
