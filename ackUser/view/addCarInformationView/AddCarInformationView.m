//
//  AddCarInformationView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/23.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "AddCarInformationView.h"
#import "ackUserPCH.pch"
#import "UIImageView+WebCache.h"
#import "UIColor+HexColor.h"
#import "SampleNoteView.h"
#import "Masonry.h"


@interface AddCarInformationView ()<UIScrollViewDelegate, UIGestureRecognizerDelegate>
{
    SampleNoteView *drivingSampleView;
    SampleNoteView *carFrontSampleView;
}


@end

@implementation AddCarInformationView

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
    
    _addCarOwnerTextField = [UITextField new];
    _addCarOwnerTextField.userInteractionEnabled = YES;
    _addCarOwnerTextField.placeholder = @"请输入";
    _addCarOwnerTextField.textAlignment = NSTextAlignmentRight;
    [_addCarOwnerTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _addCarOwnerTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_addCarOwnerTextField];
    [_addCarOwnerTextField makeConstraints:^(MASConstraintMaker *make) {
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
    
    _addCarPlateTextField = [UITextField new];
    _addCarPlateTextField.userInteractionEnabled = YES;
    _addCarPlateTextField.placeholder = @"请输入";
    _addCarPlateTextField.textAlignment = NSTextAlignmentRight;
    [_addCarPlateTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _addCarPlateTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_addCarPlateTextField];
    [_addCarPlateTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView0.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@100);
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
    
    _addCarTypeField = [UITextField new];
    _addCarTypeField.userInteractionEnabled = YES;
    _addCarTypeField.placeholder = @"请选择";
    _addCarTypeField.textAlignment = NSTextAlignmentRight;
    [_addCarTypeField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _addCarTypeField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_addCarTypeField];
    [_addCarTypeField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView1.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    _addCarTypeArrowImageView = [UIImageView new];
    _addCarTypeArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    _addCarTypeArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:_addCarTypeArrowImageView];
    [_addCarTypeArrowImageView makeConstraints:^(MASConstraintMaker *make) {
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
    
    _addCarBrandField = [UITextField new];
    _addCarBrandField.userInteractionEnabled = YES;
    _addCarBrandField.placeholder = @"请选择";
    _addCarBrandField.textAlignment = NSTextAlignmentRight;
    [_addCarBrandField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _addCarBrandField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_addCarBrandField];
    [_addCarBrandField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView2.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    _addCarBrandArrowImageView = [UIImageView new];
    _addCarBrandArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    _addCarBrandArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:_addCarBrandArrowImageView];
    [_addCarBrandArrowImageView makeConstraints:^(MASConstraintMaker *make) {
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
    
    _addCarpriceRangeTextField = [UITextField new];
    _addCarpriceRangeTextField.userInteractionEnabled = YES;
    _addCarpriceRangeTextField.placeholder = @"请选择";
    _addCarpriceRangeTextField.textAlignment = NSTextAlignmentRight;
    [_addCarpriceRangeTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _addCarpriceRangeTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_addCarpriceRangeTextField];
    [_addCarpriceRangeTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView3.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    _addCarpriceRangeArrowImageView = [UIImageView new];
    _addCarpriceRangeArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    _addCarpriceRangeArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:_addCarpriceRangeArrowImageView];
    [_addCarpriceRangeArrowImageView makeConstraints:^(MASConstraintMaker *make) {
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
    
    _addCarColorTextField = [UITextField new];
    _addCarColorTextField.userInteractionEnabled = YES;
    _addCarColorTextField.placeholder = @"请选择";
    _addCarColorTextField.textAlignment = NSTextAlignmentRight;
    [_addCarColorTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _addCarColorTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_addCarColorTextField];
    [_addCarColorTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView4.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    _addCarColorArrowImageView = [UIImageView new];
    _addCarColorArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    _addCarColorArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:_addCarColorArrowImageView];
    [_addCarColorArrowImageView makeConstraints:^(MASConstraintMaker *make) {
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
    
    _addCarcertificateIssueDateTextField = [UITextField new];
    _addCarcertificateIssueDateTextField.userInteractionEnabled = YES;
    _addCarcertificateIssueDateTextField.placeholder = @"请选择";
    _addCarcertificateIssueDateTextField.textAlignment = NSTextAlignmentRight;
    [_addCarcertificateIssueDateTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _addCarcertificateIssueDateTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_addCarcertificateIssueDateTextField];
    [_addCarcertificateIssueDateTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView5.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    _addCarcertificateIssueDateArrowImageView = [UIImageView new];
    _addCarcertificateIssueDateArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    _addCarcertificateIssueDateArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:_addCarcertificateIssueDateArrowImageView];
    [_addCarcertificateIssueDateArrowImageView makeConstraints:^(MASConstraintMaker *make) {
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
    
    _addCarlatestInspectionDateTextField = [UITextField new];
    _addCarlatestInspectionDateTextField.userInteractionEnabled = YES;
    _addCarlatestInspectionDateTextField.placeholder = @"请选择";
    _addCarlatestInspectionDateTextField.textAlignment = NSTextAlignmentRight;
    [_addCarlatestInspectionDateTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _addCarlatestInspectionDateTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_addCarlatestInspectionDateTextField];
    [_addCarlatestInspectionDateTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView6.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    _addCarlatestInspectionDateArrowImageView = [UIImageView new];
    _addCarlatestInspectionDateArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    _addCarlatestInspectionDateArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:_addCarlatestInspectionDateArrowImageView];
    [_addCarlatestInspectionDateArrowImageView makeConstraints:^(MASConstraintMaker *make) {
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
    
    _addCardrivingLicenseCameraImageView = [UIImageView new];
    _addCardrivingLicenseCameraImageView.tag = AddCarInformationDrivingLicenseImageViewTag;
    _addCardrivingLicenseCameraImageView.layer.cornerRadius = 4.0;
    _addCardrivingLicenseCameraImageView.layer.masksToBounds = YES;
    _addCardrivingLicenseCameraImageView.contentMode = UIViewContentModeCenter;
    _addCardrivingLicenseCameraImageView.backgroundColor = [UIColor colorFromHexString:@"#e5e5e5" alpha:1.0];
    _addCardrivingLicenseCameraImageView.image = [UIImage imageNamed:@"icon_camera_gray"];
    [contentView addSubview:_addCardrivingLicenseCameraImageView];
    [_addCardrivingLicenseCameraImageView makeConstraints:^(MASConstraintMaker *make) {
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
        make.right.equalTo(_addCardrivingLicenseCameraImageView.left).offset(-10);
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
        make.top.equalTo(_addCardrivingLicenseCameraImageView.bottom).offset(4);
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
    
    _addCarbodyFrontCameraImageView = [UIImageView new];
    _addCarbodyFrontCameraImageView.tag = AddCarInformationCarBodyFrontImageViewTag;
    _addCarbodyFrontCameraImageView.layer.cornerRadius = 4.0;
    _addCarbodyFrontCameraImageView.layer.masksToBounds = YES;
    _addCarbodyFrontCameraImageView.contentMode = UIViewContentModeCenter;
    _addCarbodyFrontCameraImageView.image = [UIImage imageNamed:@"icon_camera_gray"];
    _addCarbodyFrontCameraImageView.backgroundColor = [UIColor colorFromHexString:@"#e5e5e5" alpha:1.0];
    [contentView addSubview:_addCarbodyFrontCameraImageView];
    [_addCarbodyFrontCameraImageView makeConstraints:^(MASConstraintMaker *make) {
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
        make.right.equalTo(_addCarbodyFrontCameraImageView.left).offset(-10);
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
        make.top.equalTo(_addCarbodyFrontCameraImageView.bottom).offset(4);
        make.height.equalTo(@1);
    }];
    
    _addCarInfoSaveButton = [UIButton new];
    _addCarInfoSaveButton.layer.cornerRadius = 4.0;
    _addCarInfoSaveButton.layer.masksToBounds = YES;
    [_addCarInfoSaveButton setTitle:@"提交" forState:UIControlStateNormal];
    [_addCarInfoSaveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _addCarInfoSaveButton.backgroundColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];
    [contentView addSubview:_addCarInfoSaveButton];
    [_addCarInfoSaveButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.right.equalTo(contentView.right).offset(-10);
        make.top.equalTo(separetedView9.bottom).offset(10);
        make.height.equalTo(@44);
    }];
    
    [detailScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_addCarInfoSaveButton.bottom);
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
