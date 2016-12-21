//
//  CarTypeView.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/29.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NormalCarViewTag        100
#define OffRoadVehicleViewTag   101
#define CarSUVViewTag           102
#define BusinessVehicleTag      103


@interface CarTypeView : UIView


@property (strong, nonatomic) UIView            *normalCarView;
@property (strong, nonatomic) UILabel           *normalCarLabel;
@property (strong, nonatomic) UIImageView       *normalCarImageView;
@property (strong, nonatomic) UIView            *offRoadVehicleView;
@property (strong, nonatomic) UILabel           *offRoadVehicleLabel;
@property (strong, nonatomic) UIImageView       *offRoadVehicleImageView;
@property (strong, nonatomic) UIView            *carSUVVehicleView;
@property (strong, nonatomic) UILabel           *carSUVVehicleLabel;
@property (strong, nonatomic) UIImageView       *carSUVVehicleImageView;
@property (strong, nonatomic) UIView            *businessVehicleView;
@property (strong, nonatomic) UILabel           *businessVehicleLabel;
@property (strong, nonatomic) UIImageView       *businessVehicleImageView;


/**
 dismiss the CarTypeView
 */
- (void)dismissCarTypeViewAction;

/**
 show the CarTypeView
 */
- (void)showCarTypeView;

@end
