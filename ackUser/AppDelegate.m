//
//  AppDelegate.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/8.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "AppDelegate.h"
#import "LLTabBar.h"
#import "PersonalCenterViewController.h"
#import "InformationViewController.h"
#import "HomePageViewController.h"
#import "ackUserPCH.pch"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self settingCustomDatabase];
    //
    UIStoryboard *infoStory = [UIStoryboard storyboardWithName:@"information" bundle:[NSBundle mainBundle]];
    InformationViewController *infoViewController = [infoStory instantiateViewControllerWithIdentifier:@"information"];
    UINavigationController *NCinfoViewController = [[UINavigationController alloc] initWithRootViewController:infoViewController];
    UIStoryboard *personalCenterStory = [UIStoryboard storyboardWithName:@"personalCenter" bundle:[NSBundle mainBundle]];
    PersonalCenterViewController *personalVC = [personalCenterStory instantiateViewControllerWithIdentifier:@"personalCenter"];
    UINavigationController *NCpersonalVC = [[UINavigationController alloc] initWithRootViewController:personalVC];
    UIStoryboard *homePageStory = [UIStoryboard storyboardWithName:@"HomePage" bundle:[NSBundle mainBundle]];
    HomePageViewController *homeVC = [homePageStory instantiateViewControllerWithIdentifier:@"HomePage"];
    UINavigationController *NCHomeVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers = @[NCinfoViewController,NCHomeVC,NCpersonalVC];
    [tabBarController setSelectedIndex:1];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    LLTabBar *tabBar = [[LLTabBar alloc] initWithFrame:tabBarController.tabBar.bounds];
    
    tabBar.tabBarItemAttributes = @[@{kLLTabBarItemAttributeTitle : @"资讯", kLLTabBarItemAttributeNormalImageName : @"information_normal.png", kLLTabBarItemAttributeSelectedImageName : @"information_selected.png", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)},
                                    @{kLLTabBarItemAttributeTitle : @"爱车客", kLLTabBarItemAttributeNormalImageName : @"homePage_Tabbar", kLLTabBarItemAttributeSelectedImageName : @"homePage_Tabbar", kLLTabBarItemAttributeType : @(LLTabBarItemRise)},
                                    @{kLLTabBarItemAttributeTitle : @"个人中心", kLLTabBarItemAttributeNormalImageName : @"persionalStation_normal", kLLTabBarItemAttributeSelectedImageName : @"persionalStation_selected", kLLTabBarItemAttributeType : @(LLTabBarItemNormal)}];
    
//    tabBar.delegate = self;
    [tabBarController.tabBar addSubview:tabBar];
    
    self.window.rootViewController = tabBarController;
    
    return YES;
}

#pragma mark -privateMethod
- (void)settingCustomDatabase
{
    FMDatabase *db;
    NSString *pathString = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"dbPath"]];
    if (![pathString boolValue]) {
        NSString *docsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *dbPath   = [docsPath stringByAppendingPathComponent:@"ackUser.db"];
        [[NSUserDefaults standardUserDefaults] setObject:dbPath forKey:@"ackUserDBPath"];
        db = [FMDatabase databaseWithPath:dbPath];
    }
    else
        db = [FMDatabase databaseWithPath:pathString];
    
    if ([db open]) {
        NSLog(@"can open db");
        [db executeUpdate:@"create table if not exists tbl_userAccountInfo(id integer primary key autoincrement, userID text, carClubsId text, wechatId text, qqId text, sinaWeboId text, userName text, nickname text, userTel text, regCity text, creditLevel text, creditScore text, invtCode text, headImgUrl text);"];
        
        
        [db close];
        
        
    }
}



#pragma mark -applicationDelegate
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
