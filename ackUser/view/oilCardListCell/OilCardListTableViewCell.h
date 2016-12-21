//
//  OilCardListTableViewCell.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/18.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OilCardListTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView               *backCellImageView;
@property (strong, nonatomic) UIImageView               *companyImageView;
@property (strong, nonatomic) UILabel                   *oilCompanyNameLabel;
@property (strong, nonatomic) UILabel                   *oilCardNumberLabel;
@property (strong, nonatomic) UILabel                   *oilCompanyHotLineLabel;
@property (strong, nonatomic) UIButton                  *oilCardChargeButton;
@property (strong, nonatomic) UIButton                  *activeOilCardButton;


@end
