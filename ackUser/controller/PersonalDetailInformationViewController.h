//
//  PersonalDetailInformationViewController.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/16.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PersonalDetailInformationViewControllerDelegate <NSObject>

- (void)passAvatarImage:(UIImage *)image;

@end

@interface PersonalDetailInformationViewController : UIViewController

@property (retain, nonatomic) id <PersonalDetailInformationViewControllerDelegate> personalDelegate;
@property (assign, nonatomic) BOOL                  isFinishUserData;//YES:完善资料  NO:查看与修改资料
@property (copy, nonatomic)   NSString              *userTel;




@end
