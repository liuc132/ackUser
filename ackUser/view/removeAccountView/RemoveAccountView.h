//
//  RemoveAccountView.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/29.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemoveAccountView : UIView

@property (strong, nonatomic) UIButton      *removeAccountConfirmButton;
@property (strong, nonatomic) UIButton      *removeAccountCancelButton;
@property (strong, nonatomic) UILabel       *noteSubTitleLabel;
@property (strong, nonatomic) UILabel       *noteTitleLabel;


/**
 dismiss the RemoveAccountView
 */
- (void)dismissRemoveAccountViewAction;

/**
 show the RemoveAccountView
 */
- (void)showRemoveAccountView;

@end
