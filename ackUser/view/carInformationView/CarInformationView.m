//
//  CarInformationView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/23.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "CarInformationView.h"
#import "ackUserPCH.pch"
#import "UIImageView+WebCache.h"
#import "UIColor+HexColor.h"
#import "SampleNoteView.h"
#import "Masonry.h"


@interface CarInformationView ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>
{
    SampleNoteView *drivingSampleView;
    SampleNoteView *carFrontSampleView;
}


@end

@implementation CarInformationView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    UIScrollView *detailScrollView = [UIScrollView new];
    detailScrollView.delegate = self;
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
    
    UILabel *carOwnerLabel = [UILabel new];
    [contentView addSubview:carOwnerLabel];
    carOwnerLabel.textAlignment = NSTextAlignmentLeft;
    NSString *carOwnerString = @"车主姓名";
    carOwnerLabel.text = carOwnerString;
    [carOwnerLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(contentView.top).offset(10);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    _carOwnerTextField = [UITextField new];
    _carOwnerTextField.userInteractionEnabled = YES;
    _carOwnerTextField.placeholder = @"请输入";
    _carOwnerTextField.textAlignment = NSTextAlignmentRight;
    [_carOwnerTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _carOwnerTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_carOwnerTextField];
    [_carOwnerTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.top).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@140);
    }];
    
    UIView *separetedView0 = [UIView new];
    separetedView0.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView0];
    [separetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(carOwnerLabel.bottom).offset(4);
        make.height.equalTo(@1);
    }];
    
    UILabel *carPlateLabel = [UILabel new];
    [contentView addSubview:carPlateLabel];
    carPlateLabel.textAlignment = NSTextAlignmentLeft;
    NSString *carPlateString = @"车辆牌照";
    carPlateLabel.text = carPlateString;
    [carPlateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView0.bottom).offset(10);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    _carPlateTextField = [UITextField new];
    _carPlateTextField.userInteractionEnabled = YES;
    _carPlateTextField.placeholder = @"请输入";
    _carPlateTextField.textAlignment = NSTextAlignmentRight;
    [_carPlateTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _carPlateTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_carPlateTextField];
    [_carPlateTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView0.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@90);
    }];
    
    _carStatusLabel = [UILabel new];
    _carStatusLabel.textAlignment = NSTextAlignmentCenter;
    _carStatusLabel.textColor = [UIColor whiteColor];
    _carStatusLabel.layer.cornerRadius = 15.0;
    _carStatusLabel.layer.masksToBounds = YES;
    [_carStatusLabel setFont:[UIFont systemFontOfSize:14]];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],};
    _carStatusLabel.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    NSString *carStatusString = @"待审核";
    CGSize textSize = [carStatusString boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    _carStatusLabel.text = carStatusString;
    [contentView addSubview:_carStatusLabel];
    [_carStatusLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_carPlateTextField.left).offset(-10);
        make.top.equalTo(separetedView0.bottom).offset(10);
        make.width.equalTo(@(textSize.width+10));
        make.height.equalTo(@30);
    }];
    
    UIView *separetedView1 = [UIView new];
    separetedView1.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView1];
    [separetedView1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(carPlateLabel.bottom).offset(4);
        make.height.equalTo(@4);
    }];
    
    UILabel *carTypeLabel = [UILabel new];
    [contentView addSubview:carTypeLabel];
    carTypeLabel.textAlignment = NSTextAlignmentLeft;
    NSString *carTypeString = @"车型";
    carTypeLabel.text = carTypeString;
    [carTypeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView1.bottom).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    _carTypeField = [UITextField new];
    _carTypeField.userInteractionEnabled = YES;
    _carTypeField.placeholder = @"请选择";
    _carTypeField.textAlignment = NSTextAlignmentRight;
    [_carTypeField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _carTypeField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_carTypeField];
    [_carTypeField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView1.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    _carTypeArrowImageView = [UIImageView new];
    _carTypeArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    _carTypeArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:_carTypeArrowImageView];
    [_carTypeArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView1.bottom).offset(17);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    UIView *separetedView2 = [UIView new];
    separetedView2.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView2];
    [separetedView2 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(carTypeLabel.bottom).offset(4);
        make.height.equalTo(@1);
    }];
    
    UILabel *carBrandLabel = [UILabel new];
    [contentView addSubview:carBrandLabel];
    carBrandLabel.textAlignment = NSTextAlignmentLeft;
    NSString *carBrandString = @"品牌";
    carBrandLabel.text = carBrandString;
    [carBrandLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView2.bottom).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    _carBrandField = [UITextField new];
    _carBrandField.userInteractionEnabled = YES;
    _carBrandField.placeholder = @"请选择";
    _carBrandField.textAlignment = NSTextAlignmentRight;
    [_carBrandField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _carBrandField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_carBrandField];
    [_carBrandField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView2.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    _carBrandArrowImageView = [UIImageView new];
    _carBrandArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    _carBrandArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:_carBrandArrowImageView];
    [_carBrandArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView2.bottom).offset(17);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    UIView *separetedView3 = [UIView new];
    separetedView3.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView3];
    [separetedView3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(carBrandLabel.bottom).offset(4);
        make.height.equalTo(@1);
    }];
    
    UILabel *priceRangeLabel = [UILabel new];
    [contentView addSubview:priceRangeLabel];
    priceRangeLabel.textAlignment = NSTextAlignmentLeft;
    NSString *priceRangeString = @"价格区间";
    priceRangeLabel.text = priceRangeString;
    [priceRangeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView3.bottom).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    _priceRangeTextField = [UITextField new];
    _priceRangeTextField.userInteractionEnabled = YES;
    _priceRangeTextField.placeholder = @"请选择";
    _priceRangeTextField.textAlignment = NSTextAlignmentRight;
    [_priceRangeTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _priceRangeTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_priceRangeTextField];
    [_priceRangeTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView3.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    _priceRangeArrowImageView = [UIImageView new];
    _priceRangeArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    _priceRangeArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:_priceRangeArrowImageView];
    [_priceRangeArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView3.bottom).offset(17);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    UIView *separetedView4 = [UIView new];
    separetedView4.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView4];
    [separetedView4 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(priceRangeLabel.bottom).offset(4);
        make.height.equalTo(@1);
    }];
    
    UILabel *carColorLabel = [UILabel new];
    [contentView addSubview:carColorLabel];
    carColorLabel.textAlignment = NSTextAlignmentLeft;
    NSString *carColorString = @"颜色";
    carColorLabel.text = carColorString;
    [carColorLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView4.bottom).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    _carColorTextField = [UITextField new];
    _carColorTextField.userInteractionEnabled = YES;
    _carColorTextField.placeholder = @"请选择";
    _carColorTextField.textAlignment = NSTextAlignmentRight;
    [_carColorTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _carColorTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_carColorTextField];
    [_carColorTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView4.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    _carColorArrowImageView = [UIImageView new];
    _carColorArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    _carColorArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:_carColorArrowImageView];
    [_carColorArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView4.bottom).offset(17);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    UIView *separetedView5 = [UIView new];
    separetedView5.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView5];
    [separetedView5 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(carColorLabel.bottom).offset(4);
        make.height.equalTo(@4);
    }];
    
    UILabel *certificateIssueDateLabel = [UILabel new];
    [contentView addSubview:certificateIssueDateLabel];
    certificateIssueDateLabel.textAlignment = NSTextAlignmentLeft;
    NSString *certificateIssueDateString = @"发证日期";
    certificateIssueDateLabel.text = certificateIssueDateString;
    [certificateIssueDateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView5.bottom).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    _certificateIssueDateTextField = [UITextField new];
    _certificateIssueDateTextField.userInteractionEnabled = YES;
    _certificateIssueDateTextField.placeholder = @"请选择";
    _certificateIssueDateTextField.textAlignment = NSTextAlignmentRight;
    [_certificateIssueDateTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _certificateIssueDateTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_certificateIssueDateTextField];
    [_certificateIssueDateTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView5.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@100);
    }];
    
    _certificateIssueDateArrowImageView = [UIImageView new];
    _certificateIssueDateArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    _certificateIssueDateArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:_certificateIssueDateArrowImageView];
    [_certificateIssueDateArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView5.bottom).offset(17);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    UIView *separetedView6 = [UIView new];
    separetedView6.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView6];
    [separetedView6 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(certificateIssueDateLabel.bottom).offset(4);
        make.height.equalTo(@1);
    }];
    
    UILabel *latestInspectionDateLabel = [UILabel new];
    [contentView addSubview:latestInspectionDateLabel];
    latestInspectionDateLabel.textAlignment = NSTextAlignmentLeft;
    NSString *latestInspectionDateString = @"最近年检日期";
    latestInspectionDateLabel.text = latestInspectionDateString;
    [latestInspectionDateLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView6.bottom).offset(10);
        make.width.equalTo(@120);
        make.height.equalTo(@30);
    }];
    
    _latestInspectionDateTextField = [UITextField new];
    _latestInspectionDateTextField.userInteractionEnabled = YES;
    _latestInspectionDateTextField.placeholder = @"请选择";
    _latestInspectionDateTextField.textAlignment = NSTextAlignmentRight;
    [_latestInspectionDateTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _latestInspectionDateTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_latestInspectionDateTextField];
    [_latestInspectionDateTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView6.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@100);
    }];
    
    _latestInspectionDateArrowImageView = [UIImageView new];
    _latestInspectionDateArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    _latestInspectionDateArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:_latestInspectionDateArrowImageView];
    [_latestInspectionDateArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView6.bottom).offset(17);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    UIView *separetedView7 = [UIView new];
    separetedView7.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView7];
    [separetedView7 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(latestInspectionDateLabel.bottom).offset(4);
        make.height.equalTo(@4);
    }];
    
    UILabel *drivingLicenseLabel = [UILabel new];
    [contentView addSubview:drivingLicenseLabel];
    drivingLicenseLabel.textAlignment = NSTextAlignmentLeft;
    NSString *drivingLicenseString = @"行驶证照片";
    drivingLicenseLabel.text = drivingLicenseString;
    [drivingLicenseLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView7.bottom).offset(20);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    _drivingLicenseCameraImageView = [UIImageView new];
    _drivingLicenseCameraImageView.tag = CarInformationDrivingLicenseImageViewTag;
    _drivingLicenseCameraImageView.layer.cornerRadius = 4.0;
    _drivingLicenseCameraImageView.layer.masksToBounds = YES;
    _drivingLicenseCameraImageView.contentMode = UIViewContentModeCenter;
    _drivingLicenseCameraImageView.backgroundColor = [UIColor colorFromHexString:@"#e5e5e5" alpha:1.0];
    _drivingLicenseCameraImageView.image = [UIImage imageNamed:@"icon_camera_gray"];
    [contentView addSubview:_drivingLicenseCameraImageView];
    [_drivingLicenseCameraImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView7.bottom).offset(5);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@60);
        make.width.equalTo(@80);
    }];
    
    UILabel *drivingLicenseSampleLabel = [UILabel new];
    drivingLicenseSampleLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *drivingLicenseSampleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(drivingLicenseSampleAction)];
    drivingLicenseSampleGesture.delegate = self;
    drivingLicenseSampleGesture.numberOfTapsRequired = 1;
    drivingLicenseSampleGesture.numberOfTouchesRequired = 1;
    [drivingLicenseSampleLabel addGestureRecognizer:drivingLicenseSampleGesture];
    
    [contentView addSubview:drivingLicenseSampleLabel];
    drivingLicenseSampleLabel.textAlignment = NSTextAlignmentRight;
    drivingLicenseSampleLabel.textColor = [UIColor colorFromHexString:@"#ffa44b" alpha:1.0];
    NSString *drivingLicenseSampleString = @"(案例图)";
    drivingLicenseSampleLabel.text = drivingLicenseSampleString;
    [drivingLicenseSampleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_drivingLicenseCameraImageView.left).offset(-10);
        make.top.equalTo(separetedView7.bottom).offset(20);
        make.width.equalTo(@70);
        make.height.equalTo(@30);
    }];
    
    UIView *separetedView8 = [UIView new];
    separetedView8.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView8];
    [separetedView8 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(_drivingLicenseCameraImageView.bottom).offset(4);
        make.height.equalTo(@1);
    }];
    
    UILabel *bodyFrontLabel = [UILabel new];
    [contentView addSubview:bodyFrontLabel];
    bodyFrontLabel.textAlignment = NSTextAlignmentLeft;
    NSString *bodyFrontString = @"车身正面照片";
    bodyFrontLabel.text = bodyFrontString;
    [bodyFrontLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView8.bottom).offset(20);
        make.width.equalTo(@120);
        make.height.equalTo(@30);
    }];
    
    _bodyFrontCameraImageView = [UIImageView new];
    _bodyFrontCameraImageView.tag = CarInformationCarBodyFrontImageViewTag;
    _bodyFrontCameraImageView.layer.cornerRadius = 4.0;
    _bodyFrontCameraImageView.layer.masksToBounds = YES;
    _bodyFrontCameraImageView.contentMode = UIViewContentModeCenter;
    _bodyFrontCameraImageView.image = [UIImage imageNamed:@"icon_camera_gray"];
    _bodyFrontCameraImageView.backgroundColor = [UIColor colorFromHexString:@"#e5e5e5" alpha:1.0];
    [contentView addSubview:_bodyFrontCameraImageView];
    [_bodyFrontCameraImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView8.bottom).offset(5);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@60);
        make.width.equalTo(@80);
    }];
    
    UILabel *bodyFrontSampleLabel = [UILabel new];
    UITapGestureRecognizer *bodyFrontSampleGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bodyFrontSampleAction)];
    bodyFrontSampleGesture.delegate = self;
    bodyFrontSampleGesture.numberOfTapsRequired = 1;
    bodyFrontSampleGesture.numberOfTouchesRequired = 1;
    [bodyFrontSampleLabel addGestureRecognizer:bodyFrontSampleGesture];
    bodyFrontSampleLabel.userInteractionEnabled = YES;
    [contentView addSubview:bodyFrontSampleLabel];
    bodyFrontSampleLabel.textAlignment = NSTextAlignmentRight;
    bodyFrontSampleLabel.textColor = [UIColor colorFromHexString:@"#ffa44b" alpha:1.0];
    NSString *bodyFrontSampleString = @"(案例图)";
    bodyFrontSampleLabel.text = bodyFrontSampleString;
    [bodyFrontSampleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bodyFrontCameraImageView.left).offset(-10);
        make.top.equalTo(separetedView8.bottom).offset(20);
        make.width.equalTo(@70);
        make.height.equalTo(@30);
    }];
    
    UIView *separetedView9 = [UIView new];
    separetedView9.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView9];
    [separetedView9 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(_bodyFrontCameraImageView.bottom).offset(4);
        make.height.equalTo(@1);
    }];
    
    UIButton *requestCheckButton = [UIButton new];
    requestCheckButton.layer.cornerRadius = 4.0;
    requestCheckButton.layer.masksToBounds = YES;
    [requestCheckButton setTitle:@"提醒审核" forState:UIControlStateNormal];
    [requestCheckButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    requestCheckButton.backgroundColor = [UIColor colorFromHexString:@"#ffa122" alpha:1.0];
    [contentView addSubview:requestCheckButton];
    [requestCheckButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@(-((SCREEN_WIDTH-30)/4 + 5)));
        make.width.equalTo(@((SCREEN_WIDTH-30)/2));
        make.top.equalTo(separetedView9.bottom).offset(10);
        make.height.equalTo(@44);
    }];
    
    UIButton *callHotLineButton = [UIButton new];
    callHotLineButton.layer.cornerRadius = 4.0;
    callHotLineButton.layer.masksToBounds = YES;
    [callHotLineButton setTitle:@"呼叫热线" forState:UIControlStateNormal];
    [callHotLineButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    callHotLineButton.backgroundColor = [UIColor colorFromHexString:@"#00b9ed" alpha:1.0];
    [contentView addSubview:callHotLineButton];
    [callHotLineButton makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(@((SCREEN_WIDTH-30)/4 + 5));
        make.width.equalTo(@((SCREEN_WIDTH-30)/2));
        make.top.equalTo(separetedView9.bottom).offset(10);
        make.height.equalTo(@44);
    }];
    
    [detailScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(requestCheckButton.bottom);
    }];
    
    
    return self;
}

- (void)bodyFrontSampleAction
{
    NSLog(@"车前照示意图...");
    if (!carFrontSampleView) {
        carFrontSampleView = [[SampleNoteView alloc] init];
        [self addSubview:carFrontSampleView];
        [carFrontSampleView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        carFrontSampleView.backImageView.image = [UIImage imageNamed:@"icon_myCar_carFront"];
        carFrontSampleView.noteTitleLabel.text = @"车身正面照片(案例图)";
    }
    [carFrontSampleView showSampleNoteView];
    
}

- (void)drivingLicenseSampleAction
{
    NSLog(@"行驶证示意图...");
    if (!drivingSampleView) {
        drivingSampleView = [[SampleNoteView alloc] init];
        [self addSubview:drivingSampleView];
        [drivingSampleView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        drivingSampleView.backImageView.image = [UIImage imageNamed:@"icon_drivingLicense"];
        drivingSampleView.noteTitleLabel.text = @"行驶证照片(案例图)";
    }
    [drivingSampleView showSampleNoteView];
    
    
    
}


@end
