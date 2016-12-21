//
//  UserDetailSelectViewController.h
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/14.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDetailBaseDataModel.h"

@protocol UserDetailSelectViewControllerDelegate <NSObject>

- (void)passSelectDataWithParameter:(UserDetailBaseDataModel *)selectedParameter;
- (void)passAreaWithParameter:(NSString *)areaName;

@end

@interface UserDetailSelectViewController : UIViewController

@property (copy, nonatomic) NSString                *navigationBarTitle;
@property (copy, nonatomic) NSString                *displayTypeString;
@property (copy, nonatomic) NSString                *industryIDString;
/**
 1:获取地区  2:获取职业角色  3:除前两种类型以外的数据
 */
@property (copy, nonatomic) NSString                *dataType;


@property (weak, nonatomic) id<UserDetailSelectViewControllerDelegate> userDetailDelegate;

@end
