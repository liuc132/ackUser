//
//  ACKCoinChargeSuccessNoteView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/29.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "ACKCoinChargeSuccessNoteView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "Masonry.h"

@implementation ACKCoinChargeSuccessNoteView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.backgroundColor = [UIColor colorWithRed:126/255.0 green:127/255.0 blue:128/255.0 alpha:0.7];
    
    UIView *noteBackView = [UIView new];
    noteBackView.backgroundColor = [UIColor colorWithRed:126/255.0 green:127/255.0 blue:128/255.0 alpha:0.0];
    [self addSubview:noteBackView];
    [noteBackView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(self.top).offset(80);
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.height.equalTo(@(SCREEN_WIDTH - 90));
    }];
    
    UIView *visualNoteView = [UIView new];
    visualNoteView.layer.cornerRadius = 4.0;
    visualNoteView.layer.masksToBounds = YES;
    [noteBackView addSubview:visualNoteView];
    [visualNoteView setBackgroundColor:[UIColor whiteColor]];
    [visualNoteView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(10, 20, 0, 20));
    }];
    
    UILabel *noteTitleLabel = [UILabel new];
    noteTitleLabel.text = @"充值成功";
    noteTitleLabel.textAlignment = NSTextAlignmentCenter;
    [noteTitleLabel setFont:[UIFont systemFontOfSize:20]];
    [noteTitleLabel setTextColor:[UIColor whiteColor]];
    [noteTitleLabel setBackgroundColor:[UIColor colorWithRed:1.0 green:155/255.0 blue:0 alpha:1.0]];
    [visualNoteView addSubview:noteTitleLabel];
    [noteTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(visualNoteView.top);
        make.left.equalTo(visualNoteView.left);
        make.right.equalTo(visualNoteView.right);
        make.height.equalTo(@40);
    }];
    
    UILabel *noteSubTitleLabel = [UILabel new];
    noteSubTitleLabel.numberOfLines = 0;
    noteSubTitleLabel.text = @"充值金额将在两个工作日内到账,请到爱车币交易明细里查看详情";
    noteSubTitleLabel.textAlignment = NSTextAlignmentCenter;
    [noteSubTitleLabel setFont:[UIFont systemFontOfSize:15]];
    [noteSubTitleLabel setTextColor:[UIColor colorFromHexString:@"#202020" alpha:1.0]];
    [noteSubTitleLabel setBackgroundColor:[UIColor whiteColor]];
    [visualNoteView addSubview:noteSubTitleLabel];
    [noteSubTitleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noteTitleLabel.bottom);
        make.left.equalTo(visualNoteView.left).offset(10);
        make.right.equalTo(visualNoteView.right).offset(-10);
        make.height.equalTo(@100);
    }];
    
    _chargeSuccessBackHomePageButton = [UIButton new];
    _chargeSuccessBackHomePageButton.layer.cornerRadius = 20.0;
    _chargeSuccessBackHomePageButton.layer.masksToBounds = YES;
    [_chargeSuccessBackHomePageButton setTitle:@"返回首页" forState:UIControlStateNormal];
    [_chargeSuccessBackHomePageButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _chargeSuccessBackHomePageButton.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    [visualNoteView addSubview:_chargeSuccessBackHomePageButton];
    [_chargeSuccessBackHomePageButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(-((SCREEN_WIDTH-100)/4 + 5)));
        make.width.equalTo(@((SCREEN_WIDTH-100)/2));
        make.top.equalTo(noteSubTitleLabel.bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
    _chargeSuccessRobTaskButton = [UIButton new];
    _chargeSuccessRobTaskButton.layer.cornerRadius = 20.0;
    _chargeSuccessRobTaskButton.layer.masksToBounds = YES;
    [_chargeSuccessRobTaskButton setTitle:@"去抢任务" forState:UIControlStateNormal];
    [_chargeSuccessRobTaskButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _chargeSuccessRobTaskButton.backgroundColor = [UIColor colorFromHexString:@"#00b9ed" alpha:1.0];
    [visualNoteView addSubview:_chargeSuccessRobTaskButton];
    [_chargeSuccessRobTaskButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@((SCREEN_WIDTH-100)/4 + 5));
        make.width.equalTo(@((SCREEN_WIDTH-100)/2));
        make.top.equalTo(noteSubTitleLabel.bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
    UIButton *dismissChargeSuccessNoteViewButton = [UIButton new];
    dismissChargeSuccessNoteViewButton.layer.cornerRadius = 15;
    dismissChargeSuccessNoteViewButton.layer.masksToBounds = YES;
    [dismissChargeSuccessNoteViewButton setImage:[UIImage imageNamed:@"Icon_taskShareDismiss"] forState:UIControlStateNormal];
    dismissChargeSuccessNoteViewButton.showsTouchWhenHighlighted = NO;
    [dismissChargeSuccessNoteViewButton addTarget:self action:@selector(dismissChargeSuccessNoteViewAction) forControlEvents:UIControlEventTouchUpInside];
    [noteBackView addSubview:dismissChargeSuccessNoteViewButton];
    [dismissChargeSuccessNoteViewButton makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(noteBackView.top);
        make.right.equalTo(noteBackView.right).offset(-10);
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    return self;
}

/**
 dismiss the ChargeSuccessNoteView
 */
- (void)dismissChargeSuccessNoteViewAction
{
    NSTimeInterval timeInterval = 0.0;
    [UIView animateWithDuration:timeInterval animations:^{
        self.alpha = 0.0;
    }];
}

/**
 show the ChargeSuccessNoteView
 */
- (void)showChargeSuccessNoteView
{
    NSTimeInterval timeInterval = 0.1;
    [UIView animateWithDuration:timeInterval animations:^{
        self.alpha = 1.0;
    }];
}


@end
