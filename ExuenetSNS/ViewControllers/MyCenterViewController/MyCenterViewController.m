//
//  MyCenterViewController.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-30.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "MyCenterViewController.h"

@implementation MyCenterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49)];
    bgView.backgroundColor = [UIColor colorWithRed:0.48 green:0.31 blue:0.65 alpha:1];
    [self.view addSubview:bgView];
    [bgView release];
    
    infoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 49) style:UITableViewStylePlain];
    infoTable.delegate = self;
    infoTable.dataSource = self;
    infoTable.separatorInset = UIEdgeInsetsZero;
    infoTable.backgroundColor = [UIColor colorWithRed:0.48 green:0.31 blue:0.65 alpha:1];
    infoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:infoTable];
    [infoTable release];
    
    infoView = [[HeaderInfoView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    infoTable.tableHeaderView = infoView;
    [infoView release];
    
    titleArray = [[NSArray alloc] initWithObjects:@"签到赢积分",@"1.png",@"相册",@"1.png",@"文件",@"1.png",@"收藏",@"1.png",@"设置",@"1.png", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titleArray count]/2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.backgroundColor = [UIColor colorWithRed:0.48 green:0.31 blue:0.65 alpha:1];
        cell.selectedBackgroundView = [[[UIView alloc] initWithFrame:cell.frame] autorelease];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        cell.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.53 green:0.38 blue:0.68 alpha:1];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43.0, kScreenWidth, 1.0)];
        img.backgroundColor = [UIColor colorWithRed:0.45 green:0.28 blue:0.61 alpha:1];
        [cell addSubview:img];
        [img release];
        
    }
    cell.detailTextLabel.text = [titleArray objectAtIndex:indexPath.row * 2];
    [cell.imageView setImage:[UIImage imageNamed:[titleArray objectAtIndex:indexPath.row * 2 + 1]]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [super dealloc];
}

@end
