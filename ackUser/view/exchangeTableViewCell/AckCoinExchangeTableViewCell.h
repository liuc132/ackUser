//
//  AckCoinExchangeTableViewCell.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/18.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AckCoinExchangeTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImage       *exchangeItemImage;
@property (copy, nonatomic)   NSString      *exchangeItemName;
@property (copy, nonatomic)   NSString      *exchangeItemHandleTime;
@property (copy, nonatomic)   NSString      *exchangeItemCurrentTimesCash;
@property (copy, nonatomic)   NSString      *exchangeItemState;
@property (copy, nonatomic)   NSString      *exchangeItemTotalCash;

@property (strong, nonatomic) UIImageView   *exchangeItemImageView;
@property (strong, nonatomic) UILabel       *exchangeNameLabel;
@property (strong, nonatomic) UILabel       *exchangeTimeLabel;
@property (strong, nonatomic) UILabel       *exchangeCurrentItemCashLabel;
@property (strong, nonatomic) UILabel       *exchangeStatusLabel;
@property (strong, nonatomic) UILabel       *exchangeCurItemTotalLabel;



@end
