//
//  CarInformationView.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/23.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarInformationView : UIView

@property (strong, nonatomic) UITextField   *carOwnerTextField;
@property (strong, nonatomic) UITextField   *carPlateTextField;
@property (strong, nonatomic) UILabel       *carStatusLabel;
@property (strong, nonatomic) UITextField   *carTypeField;
@property (strong, nonatomic) UIImageView   *carTypeArrowImageView;
@property (strong, nonatomic) UITextField   *carBrandField;
@property (strong, nonatomic) UIImageView   *carBrandArrowImageView;
@property (strong, nonatomic) UITextField   *priceRangeTextField;
@property (strong, nonatomic) UIImageView   *priceRangeArrowImageView;
@property (strong, nonatomic) UITextField   *carColorTextField;
@property (strong, nonatomic) UIImageView   *carColorArrowImageView;
@property (strong, nonatomic) UITextField   *certificateIssueDateTextField;
@property (strong, nonatomic) UIImageView   *certificateIssueDateArrowImageView;
@property (strong, nonatomic) UITextField   *latestInspectionDateTextField;
@property (strong, nonatomic) UIImageView   *latestInspectionDateArrowImageView;
@property (strong, nonatomic) UIImageView   *drivingLicenseCameraImageView;
@property (strong, nonatomic) UIImageView   *bodyFrontCameraImageView;


@end
