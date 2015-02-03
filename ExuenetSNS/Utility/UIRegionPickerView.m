//
//  UIRegionPickerView.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-3.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "UIRegionPickerView.h"

@implementation UIRegionPickerView
@synthesize locate;

- (id)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 296, kScreenWidth, 296);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        //加载数据
        provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProvincesAndCities.plist" ofType:nil]];
        cities = [[provinces objectAtIndex:0] objectForKey:@"Cities"];
        
        //初始化默认数据
        self.locate = [[LocationModel alloc] init];
        self.locate.state = [[provinces objectAtIndex:0] objectForKey:@"State"];
        self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
        self.locate.latitude = [[[cities objectAtIndex:0] objectForKey:@"lat"] doubleValue];
        self.locate.longitude = [[[cities objectAtIndex:0] objectForKey:@"lon"] doubleValue];
        
        [self creatrInitView];
    }
    return self;
}

- (void)creatrInitView
 {
     pickerCityView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 256, kScreenWidth, 256)];
     
     pickerCityView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth; //这里设置了就可以自定义高度了，一般默认是无法修改其216像素的高度
     
     pickerCityView.dataSource = self;   //这个不用说了瑟
     
     pickerCityView.delegate = self;       //这个不用说了瑟
     
     pickerCityView.showsSelectionIndicator = YES;    //这个最好写 你不写来试下哇
     
     [self addSubview:pickerCityView];
     
     [pickerCityView release];
     
     UIBarButtonItem *cancle = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(cancleChoose:)];
     [cancle setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13],NSFontAttributeName,nil] forState:UIControlStateNormal];
     
     UIBarButtonItem *fix = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
     
     UIBarButtonItem *sure = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleBordered target:self action:@selector(chooseCity:)];
     [sure setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:13],NSFontAttributeName,nil] forState:UIControlStateNormal];

     NSArray *items = [NSArray arrayWithObjects:cancle,fix,sure, nil];
     [cancle release];
     [fix release];
     [sure release];
     
     UIToolbar *tool = [[UIToolbar alloc] initWithFrame:CGRectMake(-0.5, self.frame.size.height - 296, kScreenWidth + 2, 40)];
     tool.backgroundColor = [UIColor whiteColor];
     tool.layer.borderWidth = 0.5;
     tool.layer.borderColor = [UIColor lightGrayColor].CGColor;
     [self addSubview:tool];
     [tool release];
     
     [tool setItems:items];
}

#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [provinces count];
            break;
        case 1:
            return [cities count];
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [[provinces objectAtIndex:row] objectForKey:@"State"];
            break;
        case 1:
            return [[cities objectAtIndex:row] objectForKey:@"city"];
            break;
        default:
            return nil;
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0:
            cities = [[provinces objectAtIndex:row] objectForKey:@"Cities"];
            [pickerCityView selectRow:0 inComponent:1 animated:NO];
            [pickerCityView reloadComponent:1];
            
            self.locate.state = [[provinces objectAtIndex:row] objectForKey:@"State"];
            self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
            self.locate.latitude = [[[cities objectAtIndex:0] objectForKey:@"lat"] doubleValue];
            self.locate.longitude = [[[cities objectAtIndex:0] objectForKey:@"lon"] doubleValue];
            break;
        case 1:
            self.locate.city = [[cities objectAtIndex:row] objectForKey:@"city"];
            self.locate.latitude = [[[cities objectAtIndex:row] objectForKey:@"lat"] doubleValue];
            self.locate.longitude = [[[cities objectAtIndex:row] objectForKey:@"lon"] doubleValue];
            break;
        default:
            break;
    }
}

- (void)cancleChoose:(id)sender
{
    [self removeFromSuperview];
}

- (void)chooseCity:(id)sender
{
    citySelect select = [block retain];
    if (select) {
        select(self.locate);
    }
    [select release];
    [self removeFromSuperview];
}

- (void)chooseCityBlock:(citySelect)complition
{
    block = [complition copy];
}

- (void)dealloc
{
    if (block) {
        [block release];
    }
    [locate release];
    [super dealloc];
}

@end
