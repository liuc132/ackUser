//
//  CarTypeViewController.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/29.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CarTypeViewControllerDelegate <NSObject>

- (void)passCarTypeToCarInformationVCWithCarType:(NSString *)carType;

@end

@interface CarTypeViewController : UIViewController

@property (retain,nonatomic) id <CarTypeViewControllerDelegate> carTypeDelegate;

@end
