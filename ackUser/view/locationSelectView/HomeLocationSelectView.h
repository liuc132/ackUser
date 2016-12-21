//
//  HomeLocationSelectView.h
//  ackUser
//
//  Created by LiuC on 16/12/4.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeLocationSelectView : UIView

@property (strong, nonatomic) UILabel           *headlineTitleLabel;
@property (strong, nonatomic) UILabel           *subTitleLabel;
@property (strong, nonatomic) UIView            *addressContentView;
@property (strong, nonatomic) UIButton          *confirmAddressButton;


/**
 dismiss the HomeLocationSelectView
 */
- (void)dismissHomeLocationSelectView;

/**
 show the HomeLocationSelectView
 */
- (void)showHomeLocationSelectView;


@end
