//
//  ModifierViewController.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-3.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "BaseViewController.h"
#import "ModifyViewCell.h"
#import "HeadIconCell.h"
#import "UIRegionPickerView.h"
#import <AVFoundation/AVFoundation.h>

@interface ModifierViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,QBImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
{
    UITableView *infoTable;
    NSArray *titleArray;
    UIImage *pickerImage;
    UIRegionPickerView *pickerView;
}
@end
