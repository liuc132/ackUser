//
//  FeedBackViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/21.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "FeedBackViewController.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "UserFeedBackTableViewCell.h"
#import "AckFeedBackTableViewCell.h"
#import "UITextView+Placeholder.h"
#import "Masonry.h"

@interface FeedBackViewController ()<UITextViewDelegate, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView       *feedBackDetailTableView;

@property (strong, nonatomic) UIImageView       *navigationImageView;
@property (strong, nonatomic) UILabel           *wordCountLabel;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customFeedBackCreateView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self settingNavBar];
    
}

#pragma mark -privateMethod

- (void)customFeedBackCreateView
{
    UITextView *feedBackView = [UITextView new];
    feedBackView.placeholder = @"请描述一下您的反馈";
    feedBackView.placeholderColor = [UIColor colorFromHexString:@"#c9c8ce" alpha:1.0];
    feedBackView.delegate = self;
    [self.view addSubview:feedBackView];
    [feedBackView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.height.equalTo(@160);
    }];
    
    UIView *separetedView = [UIView new];
    separetedView.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:separetedView];
    [separetedView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
        make.top.equalTo(feedBackView.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    _wordCountLabel = [UILabel new];
    _wordCountLabel.text = @"0/200";
    _wordCountLabel.textAlignment = NSTextAlignmentRight;
    _wordCountLabel.textColor = [UIColor colorFromHexString:@"#7d8281" alpha:1.0];
    [self.view addSubview:_wordCountLabel];
    [_wordCountLabel makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.right).offset(-10);
        make.bottom.equalTo(separetedView.top).offset(-10);
        make.width.equalTo(@80);
        make.height.equalTo(@20);
    }];
    
    UIButton *confrimSettingButton = [UIButton new];
    [confrimSettingButton setTitleColor:[UIColor colorWithRed:125/255.0 green:129/255.0 blue:130/255.0 alpha:1.0] forState:UIControlStateNormal];
    confrimSettingButton.backgroundColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];
    [confrimSettingButton setTitle:@"确定" forState:UIControlStateNormal];
    [confrimSettingButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confrimSettingButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [confrimSettingButton addTarget:self action:@selector(uploadFeedBack:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confrimSettingButton];
    [confrimSettingButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
        make.top.equalTo(separetedView.bottom).offset(10);
        make.height.equalTo(@40);
    }];
    
    UILabel *myFeedBackLabel = [UILabel new];
    myFeedBackLabel.text = @"我的留言";
    myFeedBackLabel.textAlignment = NSTextAlignmentCenter;
    myFeedBackLabel.font = [UIFont systemFontOfSize:13];
    myFeedBackLabel.textColor = [UIColor colorWithRed:125/255.0 green:130/255.0 blue:129/255.0 alpha:1.0];
    [self.view addSubview:myFeedBackLabel];
    [myFeedBackLabel makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(confrimSettingButton.bottom).offset(10);
        make.centerX.equalTo(@0);
        make.height.equalTo(@20);
        make.width.equalTo(@60);
    }];
    
    UIView *separetedView1 = [UIView new];
    separetedView1.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:separetedView1];
    [separetedView1 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(confrimSettingButton.bottom).offset(20);
        make.left.equalTo(self.view.left).offset(10);
        make.right.equalTo(myFeedBackLabel.left).offset(-10);
        make.height.equalTo(@1);
    }];
    
    UIView *separetedView2 = [UIView new];
    separetedView2.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:separetedView2];
    [separetedView2 makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(confrimSettingButton.bottom).offset(20);
        make.left.equalTo(myFeedBackLabel.right).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
        make.height.equalTo(@1);
    }];
    
    _feedBackDetailTableView = [UITableView new];
    _feedBackDetailTableView.delegate = self;
    _feedBackDetailTableView.dataSource = self;
    _feedBackDetailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_feedBackDetailTableView];
    [_feedBackDetailTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(myFeedBackLabel.bottom).offset(10);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.bottom.equalTo(self.view.bottom);
    }];
    
    
}

- (void)uploadFeedBack:(UIButton *)sender
{
    NSLog(@"提交反馈...");
    [self.view endEditing:YES];
    
    
}

- (void)findNavigationBarDownLine
{
    UIImageView *navigationImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    self.navigationImageView = navigationImageView;
}

-(UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

/**
 导航栏设置
 */
- (void)settingNavBar
{
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(changePasswordToSettingVC)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refresh_button"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"登录已有账号" style:UIBarButtonItemStylePlain target:self action:@selector(signInAccountAction)];
    //
    //
    //    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"留言反馈";
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];;
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //去掉导航栏最下边的分割线
    
    
    
    
}

/**
 左侧导航按钮对应的action
 */
- (void)changePasswordToSettingVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location > 199) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入的自字符数不能超过200" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancle");
            
        }]];
        
        [self presentViewController:alertController animated:YES completion: nil];
        
        return NO;
    }
    else
    {
        NSLog(@"text length:%ld",textView.text.length);
        return YES;
    }
}

- (void)textViewDidChange:(UITextView *)textView{
    [_wordCountLabel setText:[NSString stringWithFormat:@"%ld/200", textView.text.length]];  //_wordCount是一个显示剩余可输入数字的label
}

#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *tableCell;
    tableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (tableCell == nil) {
        tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        if (indexPath.row%2 == 0) {
            UserFeedBackTableViewCell *userFeedBackTableCell = [[UserFeedBackTableViewCell alloc] init];
            [tableCell addSubview:userFeedBackTableCell];
            [userFeedBackTableCell makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(tableCell.top);
                make.left.equalTo(tableCell.left);
                make.right.equalTo(tableCell.right);
                make.bottom.equalTo(tableCell.bottom);
            }];
        }
        else
        {
            AckFeedBackTableViewCell *ackFeedBackTableCell = [[AckFeedBackTableViewCell alloc] init];
            [tableCell addSubview:ackFeedBackTableCell];
            [ackFeedBackTableCell makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(tableCell.top);
                make.left.equalTo(tableCell.left);
                make.right.equalTo(tableCell.right);
                make.bottom.equalTo(tableCell.bottom);
            }];
        }
        
    }
    
    
    
    
    
    
    
    return tableCell;
}


#pragma mark -memoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
