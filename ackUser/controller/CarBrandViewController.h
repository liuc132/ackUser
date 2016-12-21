//
//  CarBrandViewController.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/30.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarBrandViewControllerDelegate <NSObject>

- (void)passCarBrandToCarInformationVCWithCarBrand:(NSString *)carBrand;

@end

@interface CarBrandViewController : UIViewController

@property (retain,nonatomic) id <CarBrandViewControllerDelegate> carBrandDelegate;


@end
