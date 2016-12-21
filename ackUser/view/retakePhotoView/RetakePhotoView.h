//
//  RetakePhotoView.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/1.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RetakePhotoView : UIView

@property (strong, nonatomic) UIImageView       *oldPhotoImageView;
@property (strong, nonatomic) UIButton          *retakeButton;




/**
 dismiss the RetakePhotoView
 */
- (void)dismissRetakePhotoView;

/**
 show the RetakePhotoView
 */
- (void)showRetakePhotoView;

@end
