//
//  HomeFunctionView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/24.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "HomeFunctionView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "UIImage+ChangeImageColor.h"
#import "Masonry.h"

#define VerticalWidth   (SCREEN_WIDTH - 2)/3

@implementation HomeFunctionView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _getTaskButton = [UIButton new];
    [_getTaskButton setTitle:@"任务领取" forState:UIControlStateNormal];
    [_getTaskButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_getTaskButton setImage:[UIImage imageNamed:@"icon_home_getTask"] forState:UIControlStateNormal];
    [self addSubview:_getTaskButton];
    [_getTaskButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(VerticalWidth/2 - 30);
        make.top.equalTo(self.top).offset(10);
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_getTaskButton titleLength:4];
    
    UIView *verticalSeparetedView0 = [UIView new];
    verticalSeparetedView0.backgroundColor = [UIColor colorFromHexString:@"#d1d1d1" alpha:1.0];
    [self addSubview:verticalSeparetedView0];
    [verticalSeparetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(self.left).offset(VerticalWidth);
        make.width.equalTo(@1);
        make.height.equalTo(self.height);
    }];
    
    UIView *verticalSeparetedView1 = [UIView new];
    verticalSeparetedView1.backgroundColor = [UIColor colorFromHexString:@"#d1d1d1" alpha:1.0];
    [self addSubview:verticalSeparetedView1];
    [verticalSeparetedView1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(verticalSeparetedView0.right).offset(VerticalWidth);
        make.width.equalTo(@1);
        make.height.equalTo(self.height);
    }];
    /*
    UIView *verticalSeparetedView2 = [UIView new];
    verticalSeparetedView2.backgroundColor = [UIColor colorFromHexString:@"#d1d1d1" alpha:1.0];
    [self addSubview:verticalSeparetedView2];
    [verticalSeparetedView2 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(verticalSeparetedView1.right).offset(VerticalWidth);
        make.width.equalTo(@1);
        make.height.equalTo(self.height);
    }];*/
    
    UIView *horizontalSeparetedView0 = [UIView new];
    horizontalSeparetedView0.backgroundColor = [UIColor colorFromHexString:@"#d1d1d1" alpha:1.0];
    [self addSubview:horizontalSeparetedView0];
    [horizontalSeparetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_getTaskButton.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    _installTaskButton = [UIButton new];
    [_installTaskButton setTitle:@"安装" forState:UIControlStateNormal];
    [_installTaskButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_installTaskButton setImage:[UIImage imageNamed:@"icon_home_installTask"] forState:UIControlStateNormal];
    [self addSubview:_installTaskButton];
    [_installTaskButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verticalSeparetedView0.right).offset(VerticalWidth/2 - 30);
        make.top.equalTo(self.top).offset(10);
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_installTaskButton titleLength:2];
    
    _selfCheckTaskButton = [UIButton new];
    [_selfCheckTaskButton setTitle:@"自检" forState:UIControlStateNormal];
    [_selfCheckTaskButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_selfCheckTaskButton setImage:[UIImage imageNamed:@"icon_home_selfCheck"] forState:UIControlStateNormal];
    [self addSubview:_selfCheckTaskButton];
    [_selfCheckTaskButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verticalSeparetedView1.right).offset(VerticalWidth/2 - 30);
        make.top.equalTo(self.top).offset(10);
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_selfCheckTaskButton titleLength:2];
    
    /*
    _makeCommissionButton = [UIButton new];
    [_makeCommissionButton setTitle:@"赚取佣金" forState:UIControlStateNormal];
    [_makeCommissionButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_makeCommissionButton setImage:[UIImage imageNamed:@"icon_home_makeCommission"] forState:UIControlStateNormal];
    [self addSubview:_makeCommissionButton];
    [_makeCommissionButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verticalSeparetedView2.right).offset(10);
        make.top.equalTo(self.top).offset(10);
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_makeCommissionButton];
    */
    
    _homeMyTaskButton = [UIButton new];
    [_homeMyTaskButton setTitle:@"我的任务" forState:UIControlStateNormal];
    [_homeMyTaskButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_homeMyTaskButton setImage:[UIImage imageNamed:@"icon_home_myTask"] forState:UIControlStateNormal];
    [self addSubview:_homeMyTaskButton];
    [_homeMyTaskButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(VerticalWidth/2 - 30);
        make.top.equalTo(horizontalSeparetedView0.bottom).offset(10);
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_homeMyTaskButton titleLength:4];
    /*
    _withdrawButton = [UIButton new];
    [_withdrawButton setTitle:@"马上提现" forState:UIControlStateNormal];
    [_withdrawButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_withdrawButton setImage:[UIImage imageNamed:@"icon_home_withdraw"] forState:UIControlStateNormal];
    [self addSubview:_withdrawButton];
    [_withdrawButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verticalSeparetedView0.right).offset(10);
        make.top.equalTo(horizontalSeparetedView0.bottom).offset(10);
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_withdrawButton];
    */
    _chargePetroleumCardButton = [UIButton new];
    [_chargePetroleumCardButton setTitle:@"油卡充值" forState:UIControlStateNormal];
    [_chargePetroleumCardButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_chargePetroleumCardButton setImage:[UIImage imageNamed:@"icon_home_chargeCard"] forState:UIControlStateNormal];
    [self addSubview:_chargePetroleumCardButton];
    [_chargePetroleumCardButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verticalSeparetedView0.right).offset(VerticalWidth/2 - 30);
        make.top.equalTo(horizontalSeparetedView0.bottom).offset(10);
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_chargePetroleumCardButton titleLength:4];
    
    _inviteFriendsButton = [UIButton new];
    [_inviteFriendsButton setTitle:@"邀请好友" forState:UIControlStateNormal];
    [_inviteFriendsButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_inviteFriendsButton setImage:[UIImage imageNamed:@"icon_home_inviteFriend"] forState:UIControlStateNormal];
    [self addSubview:_inviteFriendsButton];
    [_inviteFriendsButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(verticalSeparetedView1.right).offset(VerticalWidth/2 - 30);
        make.top.equalTo(horizontalSeparetedView0.bottom).offset(10);
        make.height.equalTo(@60);
        make.width.equalTo(@60);
    }];
    [self settingButtonImageAndTitlePositionWithButton:_inviteFriendsButton titleLength:4];
    
    
    /*
    UIView *horizontalSeparetedView1 = [UIView new];
    horizontalSeparetedView1.backgroundColor = [UIColor colorFromHexString:@"#2d2d2d" alpha:1.0];
    [self addSubview:horizontalSeparetedView1];
    [horizontalSeparetedView1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_getTaskButton.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    */
    
    
    
    return self;
}

- (void)settingButtonImageAndTitlePositionWithButton:(UIButton *)sender titleLength:(NSInteger)length
{
    [sender setTitleColor:[UIColor colorFromHexString:@"#2d2d2d" alpha:1.0] forState:UIControlStateNormal];
    
    CGSize titleSize = CGSizeMake(40.0, 20.0);
    CGSize imageSize = sender.imageView.bounds.size;
    
    CGFloat horizontalMoveLength = 0.0;
    switch (length) {
        case 2:
            horizontalMoveLength = 25.0;
            break;
            
        case 4:
            horizontalMoveLength = 50.0;
            break;
            
        case 5:
            horizontalMoveLength = 60.0;
            break;
            
        default:
            break;
    }
    
    CGFloat totalHeight = (imageSize.height + titleSize.height);
    sender.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, -horizontalMoveLength);
    sender.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}




@end
