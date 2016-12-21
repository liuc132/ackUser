//
//  CarInformationViewController.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/23.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarInformationModel.h"

@interface CarInformationViewController : UIViewController

@property (copy, nonatomic) NSString                        *carInfoOwnerName;
@property (assign, nonatomic) BOOL                          carInfoReviewType;//YES:add car ; NO:preview CarInformation
@property (strong, nonatomic) CarInformationModel           *carInfoDetail;

@end
