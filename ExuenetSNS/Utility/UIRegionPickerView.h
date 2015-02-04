//
//  UIRegionPickerView.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-3.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationModel.h"

typedef void(^citySelect)(LocationModel *model);

@interface UIRegionPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIPickerView *pickerCityView;
    NSArray *provinces;
    NSArray	*cities;
    UILabel *infoLabel;
    citySelect block;
}
@property (strong, nonatomic) LocationModel *locate;

- (void)chooseCityWithCompletion:(citySelect)completion;

@end
