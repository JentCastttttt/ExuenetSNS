//
//  TodayViewController.m
//  ExuenetToday
//
//  Created by LeexMuller on 15/4/2.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "PublicDefine.h"

@interface TodayViewController () <NCWidgetProviding,CLLocationManagerDelegate>
{
    UILabel *label;
}
@end

@implementation TodayViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"will appear\n");
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"did appear\n");
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:k_APP_GROUP_KEY];
    
    NSInteger countNumber = [[userDefault objectForKey:@"number"] integerValue];
    countNumber += 100 ;
    label.text = [NSString stringWithFormat:@"%@%ld",[userDefault objectForKey:@"name"],countNumber];
    [userDefault setObject:[NSNumber numberWithInteger:countNumber] forKey:@"number"];
    [userDefault synchronize];
    NSLog(@"%@\n%ld",[userDefault objectForKey:@"123"],countNumber);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.preferredContentSize = CGSizeMake(0, 150);
    
    self.view.backgroundColor = [UIColor brownColor];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, 20)];
    label.text = @"hello word 123";
    label.textColor = [UIColor redColor];
    [self.view addSubview:label];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
    NSURL *containerURL = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:k_APP_GROUP_KEY];
    NSLog(@"app group:\n%@",containerURL.path);
    NSLog(@"bundle:\n%@",[[NSBundle mainBundle] bundlePath]);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *path = [paths objectAtIndex:0];
    
    NSLog(@"documents:\n%@",path);

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    
    // Output the time the location update was received
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterNoStyle;
    dateFormatter.timeStyle = NSDateFormatterMediumStyle;
    NSString *timeString = [dateFormatter stringFromDate:[NSDate date]];
    
    // Create a string from the CLLocation
    NSString *latLonString = [self stringFromCoordinate:location.coordinate];
    
    // Set the main label of the Widget to the date and coordinate
    label.text = [NSString stringWithFormat:@"%@ %@", timeString, latLonString];
    
    [self getCityNameFromLocation:location];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    label.text = error.localizedDescription;
}

- (NSString *)stringFromCoordinate:(CLLocationCoordinate2D)coordinate
{
    return [NSString stringWithFormat:@"%f %f", coordinate.latitude, coordinate.longitude];
}

- (void) getCityNameFromLocation:(CLLocation *)newLocation
{
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        NSLog(@"placemarks:%@",[placemarks description]);
        NSString *cityName = @"";
        if (placemarks.count>0) {
            CLPlacemark *placeMark = [placemarks objectAtIndex:0];
            cityName = placeMark.locality;
//            NSString *address2 = placeMark.subLocality;
//            NSString *address3 = placeMark.thoroughfare;
            
            if ([cityName isEqualToString:@""])
            {
                //没有该城市
            }
            else
            {
                //定位城市
                NSLog(@"%@",[NSString stringWithFormat:@"%@",[cityName substringToIndex:cityName.length-1]]);
            }
        }
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.extensionContext openURL:[NSURL URLWithString:@"exuenetsns://"]
                 completionHandler:^(BOOL success) {
                     if (success) {
                         NSLog(@"打开成功！");
                     } else {
                         NSLog(@"打开失败");
                     }
                 }];
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{

}

- (BOOL)animateAlongsideTransition:(void (^)(id <UIViewControllerTransitionCoordinatorContext>context))animation
                        completion:(void (^)(id <UIViewControllerTransitionCoordinatorContext>context))completion
{
    return YES;
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}



@end
