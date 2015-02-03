//
//  HeaderInfoView.m
//  ExuenetSNS
//
//  Created by LeexMuller on 15/2/2.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "HeaderInfoView.h"

@implementation HeaderInfoView
@synthesize nameLabel;
@synthesize levelLabel;
@synthesize exuenetAcount;
@synthesize iconView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createInitView];
    }
    return self;
}

- (void)createInitView
{
    self.backgroundColor = [UIColor colorWithRed:0.48 green:0.31 blue:0.65 alpha:1];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 99.0, kScreenWidth, 1.0)];
    img.backgroundColor = [UIColor colorWithRed:0.45 green:0.28 blue:0.61 alpha:1];
    [self addSubview:img];
    [img release];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 70, 70)];
    icon.layer.cornerRadius = icon.frame.size.height/2.0;
    icon.clipsToBounds = YES;
    icon.layer.borderWidth = 4.0f;
    icon.layer.borderColor = [UIColor colorWithRed:0.43 green:0.27 blue:0.6 alpha:1].CGColor;
    [icon setImage:[UIImage imageNamed:@"1.png"]];
    self.iconView = icon;
    [self addSubview:icon];
    [icon release];
    
    UILabel *tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(icon.frame.origin.x + icon.frame.size.width + 15, icon.frame.origin.y + 5, 150, 15)];
    tmpLabel.textColor = [UIColor whiteColor];
    tmpLabel.font = [UIFont systemFontOfSize:13.0f];
    tmpLabel.text = @"露西";
    self.nameLabel = tmpLabel;
    [self addSubview:tmpLabel];
    [tmpLabel release];
    
    tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(icon.frame.origin.x + icon.frame.size.width + 15, tmpLabel.frame.origin.y +20, 150, 15)];
    tmpLabel.textColor = [UIColor whiteColor];
    tmpLabel.font = [UIFont systemFontOfSize:13.0f];
    tmpLabel.text = @"0级";
    self.levelLabel = tmpLabel;
    [self addSubview:tmpLabel];
    [tmpLabel release];
    
    tmpLabel = [[UILabel alloc] initWithFrame:CGRectMake(icon.frame.origin.x + icon.frame.size.width + 15, tmpLabel.frame.origin.y + 20, 150, 15)];
    tmpLabel.textColor = [UIColor whiteColor];
    tmpLabel.font = [UIFont systemFontOfSize:13.0f];
    tmpLabel.text = @"壹学网帐号：12345";
    self.exuenetAcount = tmpLabel;
    [self addSubview:tmpLabel];
    [tmpLabel release];
}

- (void)setCkicked:(headClick)complition
{
    click = [complition copy];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.3 animations:^{
       self.backgroundColor = [UIColor colorWithRed:0.53 green:0.38 blue:0.68 alpha:1];
    }];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0.48 green:0.31 blue:0.65 alpha:1];
    } completion:^(BOOL finished) {
        if (finished) {
            headClick cl = [click retain];
            if (cl) {
                cl();
            }
            [cl release];
        }
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc
{
    [nameLabel release];
    [levelLabel release];
    [exuenetAcount release];
    [iconView release];
    [super dealloc];
}

@end
