//
//  StopTaskView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/2.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "StopTaskView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "UIImage+ChangeImageColor.h"
#import "Masonry.h"
#import "UITextView+Placeholder.h"

#define CarBodyWidth    (SCREEN_WIDTH - 30)/2

@implementation StopTaskView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    UIScrollView *detailScrollView = [UIScrollView new];
    detailScrollView.scrollEnabled = YES;
    detailScrollView.showsVerticalScrollIndicator = YES;
    detailScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:detailScrollView];
    [detailScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *contentView = [UIView new];
    [detailScrollView addSubview:contentView];
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(detailScrollView);
        make.width.equalTo(detailScrollView);
    }];
    
    _stopTaskTextView = [UITextView new];
    _stopTaskTextView.layer.cornerRadius = 4.0;
    _stopTaskTextView.layer.masksToBounds = YES;
    _stopTaskTextView.backgroundColor = [UIColor colorFromHexString:@"#e5e5e5" alpha:1.0];
    _stopTaskTextView.placeholder = @"请描述一下您的反馈";
    _stopTaskTextView.placeholderColor = [UIColor colorFromHexString:@"#c9c8ce" alpha:1.0];
    [contentView addSubview:_stopTaskTextView];
    [_stopTaskTextView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.top).offset(10);
        make.left.equalTo(contentView.left).offset(10);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@120);
    }];
    
    _stopTaskWordCountLabel = [UILabel new];
    _stopTaskWordCountLabel.text = @"0/120";
    _stopTaskWordCountLabel.textAlignment = NSTextAlignmentRight;
    _stopTaskWordCountLabel.textColor = [UIColor colorFromHexString:@"#7d8281" alpha:1.0];
    [contentView addSubview:_stopTaskWordCountLabel];
    [_stopTaskWordCountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView.right).offset(-15);
        make.bottom.equalTo(_stopTaskTextView.bottom).offset(-5);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];
    
    UIView *horizonalSeparetedView = [UIView new];
    horizonalSeparetedView.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [contentView addSubview:horizonalSeparetedView];
    [horizonalSeparetedView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_stopTaskTextView.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    UILabel *carBodyNoteLabel = [UILabel new];
    carBodyNoteLabel.textAlignment = NSTextAlignmentLeft;
    carBodyNoteLabel.text = @"车身照片:(与车牌同框";
    carBodyNoteLabel.font = [UIFont systemFontOfSize:11];
    carBodyNoteLabel.textColor = [UIColor colorFromHexString:@"#202020" alpha:1.0];
    [contentView addSubview:carBodyNoteLabel];
    [carBodyNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView.bottom).offset(10);
        make.left.equalTo(contentView.left).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@120);
    }];
    
    _stopTaskLeftSampleButton = [UIButton new];
    [_stopTaskLeftSampleButton setTitleColor:[UIColor colorFromHexString:@"#fda522" alpha:1.0] forState:UIControlStateNormal];
    [_stopTaskLeftSampleButton setTitle:@"左侧案例图" forState:UIControlStateNormal];
    _stopTaskLeftSampleButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [contentView addSubview:_stopTaskLeftSampleButton];
    [_stopTaskLeftSampleButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(carBodyNoteLabel.right);
        make.top.equalTo(horizonalSeparetedView.bottom).offset(10);
        make.width.equalTo(@70);
        make.height.equalTo(@20);
    }];
    
    _stopTaskRightSampleButton = [UIButton new];
    NSString *rightSampleButtonTitleString = @"右侧案例图)";
    NSMutableAttributedString *AttrStr = [[NSMutableAttributedString alloc] initWithString:rightSampleButtonTitleString];
    [AttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:@"#fda522" alpha:1.0] range:NSMakeRange(0, 5)];
    [AttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:@"#202020" alpha:1.0] range:NSMakeRange(5, 1)];
    //    ackCoinLeftButton.titleLabel.attributedText = ackCoinLeftAttrStr;
    [_stopTaskRightSampleButton setAttributedTitle:AttrStr forState:UIControlStateNormal];
    [_stopTaskRightSampleButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [_stopTaskRightSampleButton setTitle:rightSampleButtonTitleString forState:UIControlStateNormal];
    [contentView addSubview:_stopTaskRightSampleButton];
    [_stopTaskRightSampleButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_stopTaskLeftSampleButton.right);
        make.top.equalTo(horizonalSeparetedView.bottom).offset(10);
        make.width.equalTo(@70);
        make.height.equalTo(@20);
    }];
    
    UIView *horizonalSeparetedView0 = [UIView new];
    horizonalSeparetedView0.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [contentView addSubview:horizonalSeparetedView0];
    [horizonalSeparetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(carBodyNoteLabel.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    _stopTaskLeftCarBodyImageView = [UIImageView new];
    _stopTaskLeftCarBodyImageView.layer.masksToBounds = YES;
    _stopTaskLeftCarBodyImageView.contentMode = UIViewContentModeScaleAspectFill;
    _stopTaskLeftCarBodyImageView.image = [UIImage imageNamed:@"icon_home_LatestAD"];
    [contentView addSubview:_stopTaskLeftCarBodyImageView];
    [_stopTaskLeftCarBodyImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView0.bottom).offset(10);
        make.left.equalTo(contentView.left).offset(10);
        make.width.equalTo(@(CarBodyWidth));
        make.height.equalTo(@(CarBodyWidth - 20));
    }];
    _stopTaskLeftCarBodyImageView.image = [UIImage imageWithSize:CGSizeMake(CarBodyWidth, CarBodyWidth - 20) borderColor:[UIColor colorFromHexString:@"#e7e7e7" alpha:1.0] borderWidth:2.0];
    UIImageView *leftCarBodyCameraImageView = [UIImageView new];
    leftCarBodyCameraImageView.contentMode = UIViewContentModeCenter;
    UIImage *leftImage = [UIImage imageNamed:@"icon_camera_gray"];
    leftCarBodyCameraImageView.image = [leftImage imageWithColor:[UIColor colorFromHexString:@"#e7e7e7" alpha:1.0]];
    [_stopTaskLeftCarBodyImageView addSubview:leftCarBodyCameraImageView];
    [leftCarBodyCameraImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_stopTaskLeftCarBodyImageView.centerX);
        make.centerY.equalTo(_stopTaskLeftCarBodyImageView.centerY).offset(-20);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    UILabel *leftCarBodyLabel = [UILabel new];
    leftCarBodyLabel.font = [UIFont systemFontOfSize:11];
    leftCarBodyLabel.textAlignment = NSTextAlignmentCenter;
    leftCarBodyLabel.text = @"车身左侧广告照片";
    leftCarBodyLabel.textColor = [UIColor colorFromHexString:@"#e7e7e7" alpha:1.0];
    [_stopTaskLeftCarBodyImageView addSubview:leftCarBodyLabel];
    [leftCarBodyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftCarBodyCameraImageView.bottom);
        make.centerX.equalTo(@0);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    
    _stopTaskRightCarBodyImageView = [UIImageView new];
    _stopTaskRightCarBodyImageView.layer.masksToBounds = YES;
    _stopTaskRightCarBodyImageView.contentMode = UIViewContentModeScaleAspectFill;
    _stopTaskRightCarBodyImageView.image = [UIImage imageNamed:@"icon_home_LatestAD"];
    [contentView addSubview:_stopTaskRightCarBodyImageView];
    [_stopTaskRightCarBodyImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView0.bottom).offset(10);
        make.left.equalTo(_stopTaskLeftCarBodyImageView.right).offset(10);
        make.width.equalTo(@(CarBodyWidth));
        make.height.equalTo(@(CarBodyWidth - 20));
    }];
    _stopTaskRightCarBodyImageView.image = [UIImage imageWithSize:CGSizeMake(CarBodyWidth, CarBodyWidth - 20) borderColor:[UIColor colorFromHexString:@"#e7e7e7" alpha:1.0] borderWidth:2.0];
    UIImageView *rightCarBodyCameraImageView = [UIImageView new];
    rightCarBodyCameraImageView.contentMode = UIViewContentModeCenter;
    UIImage *rightImage = [UIImage imageNamed:@"icon_camera_gray"];
    rightCarBodyCameraImageView.image = [rightImage imageWithColor:[UIColor colorFromHexString:@"#e7e7e7" alpha:1.0]];
    [_stopTaskRightCarBodyImageView addSubview:rightCarBodyCameraImageView];
    [rightCarBodyCameraImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_stopTaskRightCarBodyImageView.centerX);
        make.centerY.equalTo(_stopTaskRightCarBodyImageView.centerY).offset(-20);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    UILabel *rightCarBodyLabel = [UILabel new];
    rightCarBodyLabel.font = [UIFont systemFontOfSize:11];
    rightCarBodyLabel.textAlignment = NSTextAlignmentCenter;
    rightCarBodyLabel.text = @"车身右侧广告照片";
    rightCarBodyLabel.textColor = [UIColor colorFromHexString:@"#e7e7e7" alpha:1.0];
    [_stopTaskRightCarBodyImageView addSubview:rightCarBodyLabel];
    [rightCarBodyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightCarBodyCameraImageView.bottom);
        make.centerX.equalTo(@0);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    UIView *horizonalSeparetedView1 = [UIView new];
    horizonalSeparetedView1.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [contentView addSubview:horizonalSeparetedView1];
    [horizonalSeparetedView1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_stopTaskLeftCarBodyImageView.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@5);
    }];
    
    UILabel *odometerNoteLabel = [UILabel new];
    odometerNoteLabel.textAlignment = NSTextAlignmentLeft;
    odometerNoteLabel.text = @"里程照片:";
    odometerNoteLabel.font = [UIFont systemFontOfSize:11];
    odometerNoteLabel.textColor = [UIColor colorFromHexString:@"#202020" alpha:1.0];
    [contentView addSubview:odometerNoteLabel];
    [odometerNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView1.bottom).offset(10);
        make.left.equalTo(contentView.left).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@50);
    }];
    
    _stopTaskOdometerSampleButton = [UIButton new];
    _stopTaskOdometerSampleButton.layer.cornerRadius = 15.0;
    _stopTaskOdometerSampleButton.layer.masksToBounds = YES;
    [_stopTaskOdometerSampleButton setTitleColor:[UIColor colorFromHexString:@"#fda522" alpha:1.0] forState:UIControlStateNormal];
    NSString *odometerSampleButtonTitleString = @"(案例图)";
    NSMutableAttributedString *odometerSampleAttrStr = [[NSMutableAttributedString alloc] initWithString:odometerSampleButtonTitleString];
    [odometerSampleAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:@"#202020" alpha:1.0] range:NSMakeRange(0, 1)];
    [odometerSampleAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:@"#fda522" alpha:1.0] range:NSMakeRange(1, 3)];
    [odometerSampleAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:@"#202020" alpha:1.0] range:NSMakeRange(4, 1)];
    //    ackCoinLeftButton.titleLabel.attributedText = ackCoinLeftAttrStr;
    [_stopTaskOdometerSampleButton setAttributedTitle:odometerSampleAttrStr forState:UIControlStateNormal];
    [_stopTaskOdometerSampleButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [_stopTaskOdometerSampleButton setTitle:rightSampleButtonTitleString forState:UIControlStateNormal];
    _stopTaskOdometerSampleButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [contentView addSubview:_stopTaskOdometerSampleButton];
    [_stopTaskOdometerSampleButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(odometerNoteLabel.right);
        make.top.equalTo(horizonalSeparetedView1.bottom).offset(10);
        make.width.equalTo(@50);
        make.height.equalTo(@20);
    }];
    
    UIView *horizonalSeparetedView2 = [UIView new];
    horizonalSeparetedView2.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [contentView addSubview:horizonalSeparetedView2];
    [horizonalSeparetedView2 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(odometerNoteLabel.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    _stopTaskOdometerImageView = [UIImageView new];
    _stopTaskOdometerImageView.layer.masksToBounds = YES;
    _stopTaskOdometerImageView.contentMode = UIViewContentModeScaleAspectFill;
    _stopTaskOdometerImageView.image = [UIImage imageNamed:@"icon_home_LatestAD"];
    [contentView addSubview:_stopTaskOdometerImageView];
    [_stopTaskOdometerImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView2.bottom).offset(10);
        make.left.equalTo(contentView.left).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.height.equalTo(@(CarBodyWidth/2));
    }];
    _stopTaskOdometerImageView.image = [UIImage imageWithSize:CGSizeMake((SCREEN_WIDTH - 20), CarBodyWidth/2) borderColor:[UIColor colorFromHexString:@"#e7e7e7" alpha:1.0] borderWidth:2.0];
    UIImageView *odometerCameraImageView = [UIImageView new];
    odometerCameraImageView.contentMode = UIViewContentModeCenter;
    UIImage *odometerImage = [UIImage imageNamed:@"icon_camera_gray"];
    odometerCameraImageView.image = [odometerImage imageWithColor:[UIColor colorFromHexString:@"#e7e7e7" alpha:1.0]];
    [_stopTaskOdometerImageView addSubview:odometerCameraImageView];
    [odometerCameraImageView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_stopTaskOdometerImageView);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    
    UIView *horizonalSeparetedView3 = [UIView new];
    horizonalSeparetedView3.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [contentView addSubview:horizonalSeparetedView3];
    [horizonalSeparetedView3 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_stopTaskOdometerImageView.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    _stopTaskUploadRequestButton = [UIButton new];
    _stopTaskUploadRequestButton.layer.cornerRadius = 4.0;
    _stopTaskUploadRequestButton.layer.masksToBounds = YES;
    [_stopTaskUploadRequestButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_stopTaskUploadRequestButton setTitle:@"提交申请" forState:UIControlStateNormal];
    _stopTaskUploadRequestButton.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    _stopTaskUploadRequestButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [contentView addSubview:_stopTaskUploadRequestButton];
    [_stopTaskUploadRequestButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(horizonalSeparetedView3.bottom).offset(10);
        make.width.equalTo(@(CarBodyWidth));
        make.height.equalTo(@44);
    }];
    
    _stopTaskCloseDirectlyButton = [UIButton new];
    _stopTaskCloseDirectlyButton.layer.cornerRadius = 4.0;
    _stopTaskCloseDirectlyButton.layer.masksToBounds = YES;
    [_stopTaskCloseDirectlyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_stopTaskCloseDirectlyButton setTitle:@"直接关闭" forState:UIControlStateNormal];
    _stopTaskCloseDirectlyButton.backgroundColor = [UIColor colorFromHexString:@"#7d8281" alpha:1.0];
    _stopTaskCloseDirectlyButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [contentView addSubview:_stopTaskCloseDirectlyButton];
    [_stopTaskCloseDirectlyButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_stopTaskUploadRequestButton.right).offset(10);
        make.top.equalTo(horizonalSeparetedView3.bottom).offset(10);
        make.width.equalTo(@(CarBodyWidth));
        make.height.equalTo(@44);
    }];
    
    [detailScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_stopTaskUploadRequestButton.bottom);
    }];
    
    return self;
}

@end
