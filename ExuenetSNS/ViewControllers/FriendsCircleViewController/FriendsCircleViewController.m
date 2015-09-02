//
//  FriendsCircleViewController.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-30.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "FriendsCircleViewController.h"

typedef enum : NSUInteger {
    CollectionViewStyleBedRoom,
    CollectionViewStyleLiving,
    CollectionViewStyleKitchen,
} CollectionViewStyle;

@interface FriendsCircleViewController()<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, retain) UIScrollView *savouredCenter;

@property (nonatomic, retain) UICollectionView *bedroomView;

@property (nonatomic, retain) UICollectionView *kitchenView;

@property (nonatomic, retain) UICollectionView *livingView;

@property (nonatomic, retain) UIView *pageView;

@property (nonatomic, retain) UILabel *titleLabel;

@property (nonatomic, retain) UIPageControl *pageControl;

@end

@implementation FriendsCircleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tabBarController.tabBar setHidden:YES];
    [self setUpXIBView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"identifier"
                                                                           forIndexPath:indexPath];
    switch (collectionView.tag) {
        case CollectionViewStyleBedRoom:
            cell.backgroundColor = [UIColor sandColor];
            break;
        case CollectionViewStyleLiving:
            cell.backgroundColor = [UIColor black25PercentColor];
            break;
        default:
            cell.backgroundColor = [UIColor warmGrayColor];
            break;
    }

    return cell;
}

- (void)setUpXIBView
{
    self.pageView.backgroundColor = [UIColor whiteColor];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(self.pageView);
        make.height.equalTo(@25);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.height.equalTo(@10);
    }];
    
    [self.savouredCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.top.trailing.bottom.equalTo(self.view);
    }];
    
    [self.bedroomView reloadData];
    [self.livingView reloadData];
    [self.kitchenView reloadData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = scrollView.contentOffset.x/kScreenWidth;
    self.pageControl.currentPage = page;
}

- (UIView *)pageView
{
    if (!_pageView) {
        _pageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        _pageView.backgroundColor = [UIColor lavenderColor];
        self.navigationItem.titleView = _pageView;
    }
    return _pageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"卧室";
        _titleLabel.textColor = [UIColor beigeColor];
        _titleLabel.backgroundColor = [UIColor black25PercentColor];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont helveticamFontOfSize:19.0f];
        [self.pageView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.currentPage = 0;
        _pageControl.numberOfPages = 3;
        _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.18 green:0.71 blue:0.92 alpha:1];
        _pageControl.pageIndicatorTintColor = [UIColor colorWithRed:0.88 green:0.88 blue:0.88 alpha:1];
        [_pageControl sizeForNumberOfPages:3];
        _pageControl.transform = CGAffineTransformMakeScale(0.6, 0.6);
        [_pageControl sizeToFit];
        [self.pageView addSubview:_pageControl];
    }
    return _pageControl;
}

- (UIScrollView *)savouredCenter
{
    if (!_savouredCenter) {
        _savouredCenter = [[UIScrollView alloc] init];
        _savouredCenter.showsHorizontalScrollIndicator = NO;
        _savouredCenter.pagingEnabled = YES;
        [_savouredCenter setContentSize:CGSizeMake(kScreenWidth * 3, kScreenHeight - 64)];
        _savouredCenter.delegate = self;
        [self.view addSubview:_savouredCenter];
    }
    return _savouredCenter;
}

- (UICollectionView *)bedroomView
{
    if (!_bedroomView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:CGSizeMake(kScreenWidth, kScreenHeight - 64)];
        _bedroomView = [[UICollectionView alloc] initWithFrame:
                        CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64)
                                          collectionViewLayout:layout];
        _bedroomView.tag = CollectionViewStyleBedRoom;
        [_bedroomView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
        _bedroomView.delegate = self;
        _bedroomView.dataSource = self;
        _bedroomView.backgroundColor = [UIColor whiteColor];
        [self.savouredCenter addSubview:_bedroomView];
    }
    return _bedroomView;
}

- (UICollectionView *)livingView
{
    if (!_livingView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:CGSizeMake(kScreenWidth, kScreenHeight - 64)];
        _livingView = [[UICollectionView alloc] initWithFrame:
                       CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight - 64)
                                         collectionViewLayout:layout];
        _livingView.tag = CollectionViewStyleLiving;
        _livingView.delegate = self;
        _livingView.dataSource = self;
        [layout setItemSize:CGSizeMake(kScreenWidth, kScreenHeight)];
        [_livingView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
        _livingView.backgroundColor = [UIColor whiteColor];
        [self.savouredCenter addSubview:_livingView];
    }
    return _livingView;
}

- (UICollectionView *)kitchenView
{
    if (!_kitchenView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        [layout setItemSize:CGSizeMake(kScreenWidth, kScreenHeight - 64)];
        _kitchenView = [[UICollectionView alloc] initWithFrame:
                        CGRectMake(2 * kScreenWidth, 0, kScreenWidth, kScreenHeight - 64)
                                          collectionViewLayout:layout];
        _kitchenView.tag = CollectionViewStyleKitchen;
        [_kitchenView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"identifier"];
        _kitchenView.delegate = self;
        _kitchenView.dataSource = self;
        _kitchenView.backgroundColor = [UIColor whiteColor];
        [self.savouredCenter addSubview:_kitchenView];
    }
    return _kitchenView;
}

@end
