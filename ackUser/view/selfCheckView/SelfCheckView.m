//
//  SelfCheckView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/2.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "SelfCheckView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "UIImage+ChangeImageColor.h"
#import "Masonry.h"

#define CarBodyWidth    (SCREEN_WIDTH - 30)/2

@implementation SelfCheckView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    UILabel *carBodyNoteLabel = [UILabel new];
    carBodyNoteLabel.textAlignment = NSTextAlignmentLeft;
    carBodyNoteLabel.text = @"车身照片:(左右两张与车牌同框";
    carBodyNoteLabel.font = [UIFont systemFontOfSize:11];
    carBodyNoteLabel.textColor = [UIColor colorFromHexString:@"#202020" alpha:1.0];
    [self addSubview:carBodyNoteLabel];
    [carBodyNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.top).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@160);
    }];
    
    _leftSampleButton = [UIButton new];
    _leftSampleButton.layer.cornerRadius = 15.0;
    _leftSampleButton.layer.masksToBounds = YES;
    [_leftSampleButton setTitleColor:[UIColor colorFromHexString:@"#fda522" alpha:1.0] forState:UIControlStateNormal];
    [_leftSampleButton setTitle:@"左侧案例图" forState:UIControlStateNormal];
    _leftSampleButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [self addSubview:_leftSampleButton];
    [_leftSampleButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(carBodyNoteLabel.right);
        make.top.equalTo(self.top).offset(10);
        make.width.equalTo(@70);
        make.height.equalTo(@20);
    }];
    
    _rightSampleButton = [UIButton new];
    _rightSampleButton.layer.cornerRadius = 15.0;
    _rightSampleButton.layer.masksToBounds = YES;
    NSString *rightSampleButtonTitleString = @"右侧案例图)";
    NSMutableAttributedString *AttrStr = [[NSMutableAttributedString alloc] initWithString:rightSampleButtonTitleString];
    [AttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:@"#fda522" alpha:1.0] range:NSMakeRange(0, 5)];
    [AttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:@"#202020" alpha:1.0] range:NSMakeRange(5, 1)];
    //    ackCoinLeftButton.titleLabel.attributedText = ackCoinLeftAttrStr;
    [_rightSampleButton setAttributedTitle:AttrStr forState:UIControlStateNormal];
    [_rightSampleButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [_rightSampleButton setTitle:rightSampleButtonTitleString forState:UIControlStateNormal];
    [self addSubview:_rightSampleButton];
    [_rightSampleButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftSampleButton.right);
        make.top.equalTo(self.top).offset(10);
        make.width.equalTo(@70);
        make.height.equalTo(@20);
    }];
    
    UIView *horizonalSeparetedView0 = [UIView new];
    horizonalSeparetedView0.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [self addSubview:horizonalSeparetedView0];
    [horizonalSeparetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(carBodyNoteLabel.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    _leftCarBodyImageView = [UIImageView new];
    _leftCarBodyImageView.layer.masksToBounds = YES;
    _leftCarBodyImageView.contentMode = UIViewContentModeScaleAspectFill;
    _leftCarBodyImageView.image = [UIImage imageNamed:@"icon_home_LatestAD"];
    [self addSubview:_leftCarBodyImageView];
    [_leftCarBodyImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView0.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(@(CarBodyWidth));
        make.height.equalTo(@(CarBodyWidth));
    }];
    _leftCarBodyImageView.image = [UIImage imageWithSize:CGSizeMake(CarBodyWidth, CarBodyWidth) borderColor:[UIColor colorFromHexString:@"#e7e7e7" alpha:1.0] borderWidth:2.0];
    UIImageView *leftCarBodyCameraImageView = [UIImageView new];
    leftCarBodyCameraImageView.contentMode = UIViewContentModeCenter;
    UIImage *leftImage = [UIImage imageNamed:@"icon_camera_gray"];
    leftCarBodyCameraImageView.image = [leftImage imageWithColor:[UIColor colorFromHexString:@"#e7e7e7" alpha:1.0]];
    [_leftCarBodyImageView addSubview:leftCarBodyCameraImageView];
    [leftCarBodyCameraImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_leftCarBodyImageView.centerX);
        make.centerY.equalTo(_leftCarBodyImageView.centerY).offset(-20);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    UILabel *leftCarBodyLabel = [UILabel new];
    leftCarBodyLabel.font = [UIFont systemFontOfSize:11];
    leftCarBodyLabel.textAlignment = NSTextAlignmentCenter;
    leftCarBodyLabel.text = @"车身左侧广告照片";
    leftCarBodyLabel.textColor = [UIColor colorFromHexString:@"#e7e7e7" alpha:1.0];
    [_leftCarBodyImageView addSubview:leftCarBodyLabel];
    [leftCarBodyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(leftCarBodyCameraImageView.bottom);
        make.centerX.equalTo(@0);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    
    _rightCarBodyImageView = [UIImageView new];
    _rightCarBodyImageView.layer.masksToBounds = YES;
    _rightCarBodyImageView.contentMode = UIViewContentModeScaleAspectFill;
    _rightCarBodyImageView.image = [UIImage imageNamed:@"icon_home_LatestAD"];
    [self addSubview:_rightCarBodyImageView];
    [_rightCarBodyImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView0.bottom).offset(10);
        make.left.equalTo(_leftCarBodyImageView.right).offset(10);
        make.width.equalTo(@(CarBodyWidth));
        make.height.equalTo(@(CarBodyWidth));
    }];
    _rightCarBodyImageView.image = [UIImage imageWithSize:CGSizeMake(CarBodyWidth, CarBodyWidth) borderColor:[UIColor colorFromHexString:@"#e7e7e7" alpha:1.0] borderWidth:2.0];
    UIImageView *rightCarBodyCameraImageView = [UIImageView new];
    rightCarBodyCameraImageView.contentMode = UIViewContentModeCenter;
    UIImage *rightImage = [UIImage imageNamed:@"icon_camera_gray"];
    rightCarBodyCameraImageView.image = [rightImage imageWithColor:[UIColor colorFromHexString:@"#e7e7e7" alpha:1.0]];
    [_rightCarBodyImageView addSubview:rightCarBodyCameraImageView];
    [rightCarBodyCameraImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_rightCarBodyImageView.centerX);
        make.centerY.equalTo(_rightCarBodyImageView.centerY).offset(-20);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    UILabel *rightCarBodyLabel = [UILabel new];
    rightCarBodyLabel.font = [UIFont systemFontOfSize:11];
    rightCarBodyLabel.textAlignment = NSTextAlignmentCenter;
    rightCarBodyLabel.text = @"车身右侧广告照片";
    rightCarBodyLabel.textColor = [UIColor colorFromHexString:@"#e7e7e7" alpha:1.0];
    [_rightCarBodyImageView addSubview:rightCarBodyLabel];
    [rightCarBodyLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rightCarBodyCameraImageView.bottom);
        make.centerX.equalTo(@0);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    UIView *horizonalSeparetedView1 = [UIView new];
    horizonalSeparetedView1.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [self addSubview:horizonalSeparetedView1];
    [horizonalSeparetedView1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_leftCarBodyImageView.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@5);
    }];
    
    UILabel *odometerNoteLabel = [UILabel new];
    odometerNoteLabel.textAlignment = NSTextAlignmentLeft;
    odometerNoteLabel.text = @"里程照片:";
    odometerNoteLabel.font = [UIFont systemFontOfSize:11];
    odometerNoteLabel.textColor = [UIColor colorFromHexString:@"#202020" alpha:1.0];
    [self addSubview:odometerNoteLabel];
    [odometerNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView1.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@50);
    }];
    
    _odometerSampleButton = [UIButton new];
    _odometerSampleButton.layer.cornerRadius = 15.0;
    _odometerSampleButton.layer.masksToBounds = YES;
    [_odometerSampleButton setTitleColor:[UIColor colorFromHexString:@"#fda522" alpha:1.0] forState:UIControlStateNormal];
    NSString *odometerSampleButtonTitleString = @"(案例图)";
    NSMutableAttributedString *odometerSampleAttrStr = [[NSMutableAttributedString alloc] initWithString:odometerSampleButtonTitleString];
    [odometerSampleAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:@"#202020" alpha:1.0] range:NSMakeRange(0, 1)];
    [odometerSampleAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:@"#fda522" alpha:1.0] range:NSMakeRange(1, 3)];
    [odometerSampleAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorFromHexString:@"#202020" alpha:1.0] range:NSMakeRange(4, 1)];
    //    ackCoinLeftButton.titleLabel.attributedText = ackCoinLeftAttrStr;
    [_odometerSampleButton setAttributedTitle:odometerSampleAttrStr forState:UIControlStateNormal];
    [_odometerSampleButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [_odometerSampleButton setTitle:rightSampleButtonTitleString forState:UIControlStateNormal];
    _odometerSampleButton.titleLabel.font = [UIFont systemFontOfSize:11];
    [self addSubview:_odometerSampleButton];
    [_odometerSampleButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(odometerNoteLabel.right);
        make.top.equalTo(horizonalSeparetedView1.bottom).offset(10);
        make.width.equalTo(@50);
        make.height.equalTo(@20);
    }];
    
    UIView *horizonalSeparetedView2 = [UIView new];
    horizonalSeparetedView2.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [self addSubview:horizonalSeparetedView2];
    [horizonalSeparetedView2 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(odometerNoteLabel.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    _odometerImageView = [UIImageView new];
    _odometerImageView.layer.masksToBounds = YES;
    _odometerImageView.contentMode = UIViewContentModeScaleAspectFill;
    _odometerImageView.image = [UIImage imageNamed:@"icon_home_LatestAD"];
    [self addSubview:_odometerImageView];
    [_odometerImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(horizonalSeparetedView2.bottom).offset(10);
        make.left.equalTo(self.left).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.height.equalTo(@(CarBodyWidth/2));
    }];
    _odometerImageView.image = [UIImage imageWithSize:CGSizeMake((SCREEN_WIDTH - 20), CarBodyWidth/2) borderColor:[UIColor colorFromHexString:@"#e7e7e7" alpha:1.0] borderWidth:2.0];
    
    UIView *horizonalSeparetedView3 = [UIView new];
    horizonalSeparetedView3.backgroundColor = [UIColor colorFromHexString:@"#e4e4e4" alpha:1.0];
    [self addSubview:horizonalSeparetedView3];
    [horizonalSeparetedView3 makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@0);
        make.top.equalTo(_odometerImageView.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@1);
    }];
    
    UIImageView *odometerCameraImageView = [UIImageView new];
    odometerCameraImageView.contentMode = UIViewContentModeCenter;
    UIImage *odometerImage = [UIImage imageNamed:@"icon_camera_gray"];
    odometerCameraImageView.image = [odometerImage imageWithColor:[UIColor colorFromHexString:@"#e7e7e7" alpha:1.0]];
    [_odometerImageView addSubview:odometerCameraImageView];
    [odometerCameraImageView makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_odometerImageView);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    
    _uploadRequestButton = [UIButton new];
    _uploadRequestButton.layer.cornerRadius = 4.0;
    _uploadRequestButton.layer.masksToBounds = YES;
    [_uploadRequestButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_uploadRequestButton setTitle:@"提交" forState:UIControlStateNormal];
    _uploadRequestButton.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    _uploadRequestButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_uploadRequestButton];
    [_uploadRequestButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).offset(10);
        make.top.equalTo(horizonalSeparetedView3.bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH - 20));
        make.height.equalTo(@44);
    }];
    
    
    
    return self;
}




@end
