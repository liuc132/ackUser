//
//  AddCarInformationView.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/23.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCarInformationView : UIView

@property (strong, nonatomic) UITextField   *addCarOwnerTextField;
@property (strong, nonatomic) UITextField   *addCarPlateTextField;
@property (strong, nonatomic) UILabel       *addCarStatusLabel;
@property (strong, nonatomic) UITextField   *addCarTypeField;
@property (strong, nonatomic) UIImageView   *addCarTypeArrowImageView;
@property (strong, nonatomic) UITextField   *addCarBrandField;
@property (strong, nonatomic) UIImageView   *addCarBrandArrowImageView;
@property (strong, nonatomic) UITextField   *addCarpriceRangeTextField;
@property (strong, nonatomic) UIImageView   *addCarpriceRangeArrowImageView;
@property (strong, nonatomic) UITextField   *addCarColorTextField;
@property (strong, nonatomic) UIImageView   *addCarColorArrowImageView;
@property (strong, nonatomic) UITextField   *addCarcertificateIssueDateTextField;
@property (strong, nonatomic) UIImageView   *addCarcertificateIssueDateArrowImageView;
@property (strong, nonatomic) UITextField   *addCarlatestInspectionDateTextField;
@property (strong, nonatomic) UIImageView   *addCarlatestInspectionDateArrowImageView;
@property (strong, nonatomic) UIImageView   *addCardrivingLicenseCameraImageView;
@property (strong, nonatomic) UIImageView   *addCarbodyFrontCameraImageView;
@property (strong, nonatomic) UIButton      *addCarInfoSaveButton;


@end
