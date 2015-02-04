//
//  ModifierViewController.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-3.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "ModifierViewController.h"

#define Album_Sheet  1000
#define Sex_Sheet    1001


@interface ModifierViewController ()

@end

@implementation ModifierViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tabBarController.tabBar setHidden:YES];
    
    infoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    infoTable.delegate = self;
    infoTable.dataSource = self;
    infoTable.separatorInset = UIEdgeInsetsZero;
    infoTable.backgroundColor = [UIColor colorWithRed:0.48 green:0.31 blue:0.65 alpha:1];
    infoTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:infoTable];
    [infoTable release];
    
    titleArray = [[NSArray alloc] initWithObjects:@"头像",@"名字",@"壹学网账号",@"我的学校",@"性别",@"地区",@"个性签名",nil];
    pickerImage = [[UIImage imageNamed:@"1.png"] retain];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 90.0f;
    }
    return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        static NSString *identifier = @"iconIdentifier";
        HeadIconCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[HeadIconCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
        }
        cell.titleLabel.text = [titleArray objectAtIndex:indexPath.row];
        [cell.iconView setImage:pickerImage];
        return cell;
    } else {
        static NSString *identifier = @"identifier";
        NSInteger row = indexPath.row;
        UserModel *userModel = [DataCenter shareInstance].userInfo;
        ModifyViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[[ModifyViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier] autorelease];
        }
        cell.titleLabel.text = [titleArray objectAtIndex:row];
        switch (row) {
            case 1:
            {
                cell.valueLabel.text = userModel.sex;
            }
                break;
            case 2:
            {
                cell.valueLabel.text = userModel.sex;
            }
                break;
            case 3:
            {
                cell.valueLabel.text = userModel.sex;
            }
                break;
            case 4:
            {
                cell.valueLabel.text = userModel.sex;
            }
                break;
            case 5:
            {
                cell.valueLabel.text = userModel.area;
            }
                break;
            case 6:
            {
                cell.valueLabel.text = userModel.sex;
            }
                break;
            default:
                break;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
        {
            //修改头像
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"更换头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择",@"拍照", nil];
            sheet.tag = Album_Sheet;
            [sheet showInView:[UIApplication sharedApplication].keyWindow];
            [sheet release];
        }
            break;
        case 1:
        {
            //修改名字
        }
            break;
        case 2:
        {
            //修改壹学网账号
        }
            break;
        case 3:
        {
            //修改我的学校
        }
            break;
        case 4:
        {
            //修改性别
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
            sheet.tag = Sex_Sheet;
            [sheet showInView:[UIApplication sharedApplication].keyWindow];
            [sheet release];
        }
            break;
        case 5:
        {
            //修改地区
            pickerView = [[UIRegionPickerView alloc] init];
            [pickerView chooseCityWithCompletion:^(LocationModel *model) {
                [DataCenter shareInstance].userInfo.area = [NSString stringWithFormat:@"%@ %@",model.state,model.city];
                NSIndexPath *iconPath = [NSIndexPath indexPathForRow:5 inSection:0];
                [infoTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:iconPath] withRowAnimation:UITableViewRowAnimationNone];
            }];
            [self.view addSubview:pickerView];
            [pickerView release];
        }
            break;
        case 6:
        {
            //修改个性签名
        }
            break;
        default:
            break;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == Album_Sheet) {
        if (buttonIndex == 0) {
            QBImagePickerController *imagePickerController = [[QBImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.allowsMultipleSelection = NO;
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
            navigationController.navigationBar.tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
            navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.99 green:0.62 blue:0.36 alpha:1];
            navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
            [self presentViewController:navigationController animated:YES completion:NULL];
            [imagePickerController release];
            [navigationController release];
        } else if (buttonIndex == 1) {
            
        }
    } else if (actionSheet.tag == Sex_Sheet) {
        if (buttonIndex == 0) {
            //男
            [DataCenter shareInstance].userInfo.sex = @"男";
        } else if (buttonIndex == 1) {
            //女
            [DataCenter shareInstance].userInfo.sex = @"女";
        }
        NSIndexPath *iconPath = [NSIndexPath indexPathForRow:4 inSection:0];
        [infoTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:iconPath] withRowAnimation:UITableViewRowAnimationNone];
    }

}


#pragma mark - QBImagePickerControllerDelegate
- (void)imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingMediaWithInfo:(id)info
{
    if(imagePickerController.allowsMultipleSelection) {
        NSArray *mediaInfoArray = (NSArray *)info;
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"%@",mediaInfoArray);
        }];
        NSLog(@"Selected %ld photos and mediaInfoArray==%@", mediaInfoArray.count,mediaInfoArray);
    } else {
        NSDictionary *mediaInfo = (NSDictionary *)info;
        
        [pickerImage release];
        pickerImage = nil;
        pickerImage = [[mediaInfo objectForKey:@"UIImagePickerControllerOriginalImage"] retain];
        
        [self dismissViewControllerAnimated:YES completion:^{
            
            NSIndexPath *iconPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [infoTable reloadRowsAtIndexPaths:[NSArray arrayWithObject:iconPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [titleArray release];
    [super dealloc];
}

@end
