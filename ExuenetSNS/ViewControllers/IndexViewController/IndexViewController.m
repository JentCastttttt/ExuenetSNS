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

#define ROW_NUMBER  4.0  //每一列的个数

@interface IndexViewController ()

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
    
    NSDictionary *dic = @{@"name":@"valueName",@"icon":@"http://www.baidu.com"};
    UserModel *model = [[UserModel alloc] init];
    NSLog(@"%@",model);
    [Utility instantiationProperty:model withDictionary:dic];
    NSLog(@"%@",model);
    
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:k_APP_GROUP_KEY];
    [userDefault setObject:@{@"1234key":@"value1234"} forKey:@"123"];
    [userDefault setObject:@"Jim" forKey:@"name"];
    NSInteger count = [[userDefault objectForKey:@"number"] integerValue];
    count ++ ;
    [userDefault setObject:[NSNumber numberWithInteger:count] forKey:@"number"];
    [userDefault synchronize];
    
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
            [cell.icon setImage:[UIImage imageNamed:@"2.png"]];
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
