//
//  ExchangePasswordViewController.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/17.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangePasswordViewController : UIViewController

@property (copy, nonatomic) NSString                *chargeCountString;
/** 充值类型 1:油卡充值， 2:爱车币充值 */
@property (assign, nonatomic) NSInteger             chargeAckCoinType;


@end
