//
//  IndexViewController.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-28.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "IndexViewController.h"
#import "LeftIndexViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "CollectionCell.h"
#import "ClassmatesCell.h"
#import "CollectionHeaderView.h"
#import "UserModel.h"
#import "UIImage+Tint.h"

#define ROW_NUMBER  4.0  //每一列的个数

@interface IndexViewController ()

@property (nonatomic, strong) MMWormhole *wormhole;

@end

@implementation IndexViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
    headerArray = [[NSArray alloc] initWithObjects:@"讨论组",@"同学圈",@"应用", nil];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    waterView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64 - 50) collectionViewLayout:layout];
    waterView.delegate = self;
    waterView.dataSource = self;
    waterView.showsVerticalScrollIndicator = NO;
    [waterView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"collectionIdentifier"];
    [waterView registerClass:[ClassmatesCell class] forCellWithReuseIdentifier:@"classmatesIdentifier"];
    [waterView registerClass:[CollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionHeaderIdentifier"];
    waterView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:waterView];
    [layout release];
    [waterView release];
    
    NSMutableString *ms = [[NSMutableString alloc] initWithString:@"我是中国人曹建荣"];
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
        NSLog(@"Pingying: %@", ms); // wǒ shì zhōng guó rén
    }
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
        NSLog(@"Pingying: %@", ms); // wo shi zhong guo ren
    }
    
    [ms localizedCaseInsensitiveCompare:@"111"];
    
    NSDictionary *dic = @{@"name":@"valueName",@"icon":@"http://www.baidu.com"};
    UserModel *model = [[UserModel alloc] init];
    NSLog(@"%@",model);
    [Utility instantiationProperty:model withDictionary:dic];
    NSLog(@"%@",model);
    
    //若要使Today Extension 可以获取到宿主App的数据, 则需要使用 initWithSuiteName:group_key 来保存和读取，ios7以及之前的版本的获取NSUserDefaults数据的方法是无法进行数据共享的。
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:k_APP_GROUP_KEY];
    [userDefault setObject:@{@"1234key":@"value1234"} forKey:@"123"];
    [userDefault setObject:@"Jim" forKey:@"name"];
    NSInteger count = [[userDefault objectForKey:@"number"] integerValue];
    count ++ ;
    [userDefault setObject:[NSNumber numberWithInteger:count] forKey:@"number"];
    [userDefault synchronize];
    
    
//  通过这个方法可以实现宿主App的检测值改变的同时，使Apple Watch获取到通知，从而更新Apple Watch的显示数据
//  同理，此方法也使用于改变Apple Watch中的数据，修改宿主App的显示数据
//    // Initialize the wormhole
//    self.wormhole = [[MMWormhole alloc] initWithApplicationGroupIdentifier:@"group.com.mutualmobile.wormhole"
//                                                         optionalDirectory:@"wormhole"];
//    
//    // Obtain an initial message from the wormhole
//    id messageObject = [self.wormhole messageWithIdentifier:@"button"];
//    NSNumber *number = [messageObject valueForKey:@"buttonNumber"];
//    
//    // Become a listener for changes to the wormhole for the button message
//    [self.wormhole listenForMessageWithIdentifier:@"button" listener:^(id messageObject) {
//        // The number is identified with the buttonNumber key in the message object
//        NSNumber *number = [messageObject valueForKey:@"buttonNumber"];
////        self.numberLabel.text = [number stringValue];
//    }];
//    
//    [self.wormhole passMessageObject:@{@"selectionString" : title} identifier:@"selection"];
}

- (void)viewWillAppear:(BOOL)animated
{
    
    //讲推送设置以及信息加入
    UIApplication* app = [UIApplication sharedApplication];
    for (UILocalNotification* notification in app.scheduledLocalNotifications) {
        if ([notification.userInfo objectForKey:@"key"]) {
            [app cancelLocalNotification:notification];
        }
    }
    
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    
    //设置时间当前加20秒
    NSDate* pushDate = [NSDate dateWithTimeIntervalSinceNow:5];
    
    /*推送时区设置:从网上搜到
     timeZone是UILocalNotification激发时间是否根据时区改变而改变，如果设置为nil的话，那么UILocalNotification将在一段时候后被激发，而不是某一个确切时间被激发。*/
    localNotification.timeZone = [NSTimeZone defaultTimeZone];
    
    ///推送时间设置
    localNotification.fireDate = pushDate;
    
    //时间间隔,若不设置将只会推送1次
    localNotification.repeatInterval = kCFCalendarUnitDay;
    
    //推送时的声音,（若不设置的话系统推送时会无声音）
    localNotification.soundName = UILocalNotificationDefaultSoundName;
    
    //推送的文字信息（若不设置，推送中心中不显示文字，有声音提示前提是设置有声音）
    localNotification.alertBody = @"Hello world";
    
    //推送时小图标的设置，PS:这个东西不知道还有啥用
    localNotification.alertLaunchImage = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"png"];
    
    localNotification.alertAction = @"确定";
    
    localNotification.applicationIconBadgeNumber = 10;
    
    //对应的在App delegate 里面注册是一系列的动作 UIMutableUserNotificationCategory
    localNotification.category = @"alert";
    
    //这个东西，到时用于定位是哪个notification,以便取消用
    NSDictionary* infoDic = [NSDictionary dictionaryWithObject:@"name" forKey:@"key"];
    localNotification.userInfo = infoDic;
    
    //讲推送设置以及信息加入
    BOOL status = YES;
    for (UILocalNotification* notification in app.scheduledLocalNotifications) {
        if ([notification.userInfo objectForKey:@"key"]) {
            status = NO;
        }
    }
    
    if (status) {
        //加入推送(只能加入一次)
        [app scheduleLocalNotification:localNotification];
    }
}

/**
 *  总共有多少个Section
 *
 *  @param collectionView collectionView
 *
 *  @return 返回总共多少个Section
 */
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [headerArray count];
}

/*!
 *  sectionHeader的frame
 *
 *  @param collectionView       collection
 *  @param collectionViewLayout collectionViewLayout
 *  @param section              section
 *
 *  @return 返回sectionHeader的大小以及位置
 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth, 30);
}

/*!
 *  sectionHeader的视图
 *
 *  @param collectionView collection
 *  @param kind           kind
 *  @param indexPath      indexPath
 *
 *  @return 返回的是Section显示的头视图
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CollectionHeaderView *header = (CollectionHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionHeaderIdentifier" forIndexPath:indexPath];
    if (!header) {
        header = [[[CollectionHeaderView alloc] init] autorelease];
    }
    header.nameLabel.text = [headerArray objectAtIndex:indexPath.section];
    header.section = indexPath.section;
    [header sectionClickedWithCompletion:^(NSInteger section) {
        NSLog(@"section %ld",section);
    }];
    return header;
}

/**
 *  每个section总共有多少个cell
 *
 *  @param collectionView collection
 *  @param section        当前的section
 *
 *  @return 返回每个section总共有多少个cell
 */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 12;
}

/*!
 *  设置每一个Section的上下左右偏移量
 *
 *  @param collectionView       collectionView
 *  @param collectionViewLayout 自定义的layout
 *  @param section              section
 *
 *  @return 每个Section相对于CollectionView的偏移量
 */
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

/*!
 *  每个Items之间的距离
 *
 *  @param collectionView       collectionView
 *  @param collectionViewLayout 自定义layout
 *  @param section              当前section
 *
 *  @return 返回每个Items之间的间距（可以单独设置每个Item之间的距离）
 */
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 7.5f;
}

/*!
 *  每个Items的大小
 *
 *  @param collectionView       collectionView
 *  @param collectionViewLayout 自定义layout
 *  @param indexPath            当前indexPath
 *
 *  @return 每个Items的大小
 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:
        {
            [collectionViewLayout setMinimumInteritemSpacing:7.5f];
            [collectionViewLayout setMinimumLineSpacing:10.0f];
            [collectionViewLayout setHeaderReferenceSize:CGSizeMake(kScreenWidth, 30)];
            [collectionViewLayout setSectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
            CGFloat width = (kScreenWidth - collectionViewLayout.minimumInteritemSpacing*(ROW_NUMBER - 1) - collectionViewLayout.sectionInset.left - collectionViewLayout.sectionInset.right)/ROW_NUMBER;
            [collectionViewLayout setItemSize:CGSizeMake(width,width + 15)];
            [collectionViewLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
            return CGSizeMake((kScreenWidth - collectionViewLayout.minimumInteritemSpacing*(ROW_NUMBER - 1) - collectionViewLayout.sectionInset.left - collectionViewLayout.sectionInset.right)/ROW_NUMBER, width/2.0);
        }
            break;
            
        default:
        {
            [collectionViewLayout setMinimumInteritemSpacing:7.5f];
            [collectionViewLayout setMinimumLineSpacing:10.0f];
            [collectionViewLayout setHeaderReferenceSize:CGSizeMake(kScreenWidth, 30)];
            [collectionViewLayout setSectionInset:UIEdgeInsetsMake(10, 10, 10, 10)];
            CGFloat width = (kScreenWidth - collectionViewLayout.minimumInteritemSpacing*(ROW_NUMBER - 1) - collectionViewLayout.sectionInset.left - collectionViewLayout.sectionInset.right)/ROW_NUMBER;
            [collectionViewLayout setItemSize:CGSizeMake(width,width + 15)];
            [collectionViewLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
            return CGSizeMake((kScreenWidth - collectionViewLayout.minimumInteritemSpacing*(ROW_NUMBER - 1) - collectionViewLayout.sectionInset.left - collectionViewLayout.sectionInset.right)/ROW_NUMBER, width + 15);
        }
            break;
    }
}

/**
 *  返回的UICollectionViewCell
 *  这个cell返回的时候必须先从
 *  -dequeueReusableCellWithReuseIdentifier:forIndexPath:中检索
 *
 *  @param  collectionView
 *
 *  @return 返回Cell
 */
// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 1:
        {
            static NSString *collectionIdentifier = @"classmatesIdentifier";
            ClassmatesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionIdentifier forIndexPath:indexPath];
            if (!cell) {
                cell = [[[ClassmatesCell alloc] init] autorelease];
            }
            UIImage *img = [UIImage imageNamed:@"2.png"];
            [cell.icon setImage:[img imageWithGradientTintColor:[UIColor colorWithWhite:0.1 alpha:0.5]]];
//            [cell.icon setImageWithURL:[NSURL URLWithString:model.tvPicVirtualPath] placeholderImage:[UIImage imageNamed:@"placeholder_horizontal"]];
//            cell.name.text = [NSString stringWithFormat:@"点赞数：%ld",indexPath.row];
//            cell.school.text = @"";
            return cell;
        }
            break;
            
        default:
        {
            static NSString *collectionIdentifier = @"collectionIdentifier";
            CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionIdentifier forIndexPath:indexPath];
            if (!cell) {
                cell = [[[CollectionCell alloc] init] autorelease];
            }
            [cell.icon setImage:[UIImage imageNamed:@"1.png"]];
            //    [cell.icon setImageWithURL:[NSURL URLWithString:model.tvPicVirtualPath] placeholderImage:[UIImage imageNamed:@"placeholder_horizontal"]];
            //    cell.name.text = [NSString stringWithFormat:@"点赞数：%ld",indexPath.row];
            return cell;
        }
            break;
    }

}

/**
 *  选中的当前Cell的点击事件
 *
 *  @param collectionView collectionView
 *  @param indexPath      indexPath  索引
 */
-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"clicked %ld   %ld",indexPath.section,indexPath.row);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [headerArray release];
    [super dealloc];
}

@end
