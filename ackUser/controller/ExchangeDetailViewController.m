//
//  ExchangeDetailViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/18.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "ExchangeDetailViewController.h"
#import "ackUserPCH.pch"
#import "AckCoinExchangeTableViewCell.h"
#import "CustomDatePickView.h"
#import "Masonry.h"

@interface ExchangeDetailViewController ()<UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
{
    CustomDatePickView *customDatePickerView;
}

@property (strong, nonatomic) UIImageView           *navigationImageView;
@property (strong, nonatomic) UITableView           *ackCoinExchangeDetailTableView;
@property (strong, nonatomic) UITextField           *selectYearMonthTextField;
@property (strong, nonatomic) UITextField           *selectContentTextField;

@property (strong, nonatomic) NSMutableArray        *exchangeItemsArray;
@property (strong, nonatomic) NSMutableDictionary   *exchangeItemDictionary;

@property (strong, nonatomic) NSArray               *testDataArray;

@property (strong, nonatomic) NSDate                *startDate;

@end

@implementation ExchangeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self settingInitializationaData];
    
    [self customAckCoinExchangeDetailView];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    [self settingNavBar];
    [self settingCustomPickerView];
    
}


#pragma mark -privateMethod

- (void)settingInitializationaData
{
    _testDataArray = @[@{@"exchangeType":@"0",@"taskName":@"完成“任务名称任务名称任务名称160801”任务",@"taskTime":@"2016-08-01 10:10:10",@"taskStatus":@"0",@"currentTaskCask":@"30000",@"currentaskTotalAckCoin":@"70000"},@{@"exchangeType":@"1",@"taskName":@"油卡充值",@"taskTime":@"2016-08-01 10:10:10",@"taskStatus":@"1",@"currentTaskCask":@"30000",@"currentaskTotalAckCoin":@"40000"},@{@"exchangeType":@"0",@"taskName":@"完成“任务名称任务名称任务名称160801”任务",@"taskTime":@"2016-08-01 10:10:10",@"taskStatus":@"0",@"currentTaskCask":@"3000",@"currentaskTotalAckCoin":@"70000"},@{@"exchangeType":@"1",@"taskName":@"油卡充值",@"taskTime":@"2016-08-01 10:10:10",@"taskStatus":@"1",@"currentTaskCask":@"30000",@"currentaskTotalAckCoin":@"40000"},@{@"exchangeType":@"0",@"taskName":@"完成“任务名称任务名称任务名称160801”任务",@"taskTime":@"2016-08-01 10:10:10",@"taskStatus":@"0",@"currentTaskCask":@"2000",@"currentaskTotalAckCoin":@"70000"},@{@"exchangeType":@"1",@"taskName":@"油卡充值",@"taskTime":@"2016-08-01 10:10:10",@"taskStatus":@"1",@"currentTaskCask":@"30000",@"currentaskTotalAckCoin":@"70000"}];
}

- (void)settingCustomPickerView
{
    _startDate = [NSDate date];
    
    if (customDatePickerView == nil) {
        customDatePickerView = [[CustomDatePickView alloc] init];
        [self.view addSubview:customDatePickerView];
        [customDatePickerView makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.bottom);
            make.left.equalTo(self.view.left);
            make.right.equalTo(self.view.right);
            make.height.equalTo(@280);
        }];
        
        [customDatePickerView.dateCancleButton addTarget:self action:@selector(dateCancle) forControlEvents:UIControlEventTouchUpInside];
        [customDatePickerView.dateConfirmButton addTarget:self action:@selector(dateConfirm) forControlEvents:UIControlEventTouchUpInside];
        [customDatePickerView setHidden:YES];
        
    }
}

- (void)dateConfirm
{
    NSDate *curDate = customDatePickerView.datePickerView.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *selectDate = [formatter stringFromDate:curDate];
    
    
    _selectYearMonthTextField.text = selectDate;
    
    [self hideCusDatePicker];
}

- (void)dateCancle
{
    [self hideCusDatePicker];
}

- (void)hideCusDatePicker
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [customDatePickerView setHidden:YES];
        [weakSelf.view sendSubviewToBack:customDatePickerView];
        
    });
}

- (void)showingCusDatePicker
{
    __unsafe_unretained typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.view endEditing:YES];
        [customDatePickerView setHidden:NO];
        [customDatePickerView.datePickerView setDate:_startDate animated:YES];
        [weakSelf.view bringSubviewToFront:customDatePickerView];
    });
}

- (void)customAckCoinExchangeDetailView
{
    UILabel *yearMonthNoteLabel = [UILabel new];
    yearMonthNoteLabel.textAlignment = NSTextAlignmentLeft;
    yearMonthNoteLabel.font = [UIFont systemFontOfSize:15];
    NSString *ackCoinDifferenceString = @"选择年月";
    yearMonthNoteLabel.text = ackCoinDifferenceString;
    [self.view addSubview:yearMonthNoteLabel];
    [yearMonthNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.top.equalTo(self.view.top).equalTo(@10);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    _selectYearMonthTextField = [UITextField new];
    _selectYearMonthTextField.delegate = self;
    _selectYearMonthTextField.userInteractionEnabled = YES;
    _selectYearMonthTextField.textAlignment = NSTextAlignmentRight;
    _selectYearMonthTextField.placeholder = @"请选择年月";
    [_selectYearMonthTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _selectYearMonthTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:_selectYearMonthTextField];
    [_selectYearMonthTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(yearMonthNoteLabel.right).offset(30);
        make.height.equalTo(@20);
        make.top.equalTo(self.view.top).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
    }];
    
    UIView *separetedView = [UIView new];
    separetedView.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:separetedView];
    [separetedView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.top.equalTo(yearMonthNoteLabel.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    UILabel *selectNoteLabel = [UILabel new];
    selectNoteLabel.textAlignment = NSTextAlignmentLeft;
    selectNoteLabel.font = [UIFont systemFontOfSize:15];
    NSString *selectNoteString = @"筛选";
    selectNoteLabel.text = selectNoteString;
    [self.view addSubview:selectNoteLabel];
    [selectNoteLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left).offset(10);
        make.top.equalTo(separetedView.bottom).equalTo(@10);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    
    _selectContentTextField = [UITextField new];
    _selectContentTextField.delegate = self;
    _selectContentTextField.userInteractionEnabled = YES;
    _selectContentTextField.textAlignment = NSTextAlignmentRight;
    _selectContentTextField.placeholder = @"请选择类型";
    [_selectContentTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _selectContentTextField.borderStyle = UITextBorderStyleNone;
    [self.view addSubview:_selectContentTextField];
    [_selectContentTextField makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(selectNoteLabel.right).offset(30);
        make.height.equalTo(@20);
        make.top.equalTo(separetedView.bottom).offset(10);
        make.right.equalTo(self.view.right).offset(-10);
    }];
    
    UIView *separetedView1 = [UIView new];
    separetedView1.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [self.view addSubview:separetedView1];
    [separetedView1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.top.equalTo(selectNoteLabel.bottom).offset(10);
        make.height.equalTo(@5);
    }];
    
    _ackCoinExchangeDetailTableView = [UITableView new];
    _ackCoinExchangeDetailTableView.delegate = self;
    _ackCoinExchangeDetailTableView.dataSource = self;
    _ackCoinExchangeDetailTableView.allowsSelection = NO;
    [self.view addSubview:_ackCoinExchangeDetailTableView];
    [_ackCoinExchangeDetailTableView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView1.bottom);
        make.left.equalTo(self.view.left);
        make.right.equalTo(self.view.right);
        make.bottom.equalTo(self.view.bottom);
    }];
    
    
    
    
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
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(forgetBackToSignVC)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
//    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(filterExchangeDetail)];
//    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"爱车币交易明细";
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];;
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    //NSFontAttributeName
//    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    
}

/**
 左侧导航按钮对应的action
 */
- (void)forgetBackToSignVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)filterExchangeDetail
{
    NSLog(@"筛选...");
//    [self performSegueWithIdentifier:@"ackCoinAccountToExchangeDetail" sender:nil];
    
}

#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _testDataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *tableViewCell;
    tableViewCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (tableViewCell == nil) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        AckCoinExchangeTableViewCell *exchangeTableViewCell = [[AckCoinExchangeTableViewCell alloc] init];
        [tableViewCell addSubview:exchangeTableViewCell];
        [exchangeTableViewCell makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tableViewCell.top);
            make.bottom.equalTo(tableViewCell.bottom);
            make.left.equalTo(tableViewCell.left);
            make.right.equalTo(tableViewCell.right);
        }];
    }
    
    for (id tableCell in tableViewCell.subviews) {
        if ([tableCell isKindOfClass:[AckCoinExchangeTableViewCell class]]) {
            AckCoinExchangeTableViewCell *exchangeTableViewCell = (AckCoinExchangeTableViewCell *)tableCell;
            NSDictionary *currentItemDictionary = _testDataArray[indexPath.row];
            exchangeTableViewCell.exchangeItemImageView.image = ([currentItemDictionary[@"exchangeType"] integerValue] == 0)?[UIImage imageNamed:@"ackCoinAccount_exchangeDetail"]:[UIImage imageNamed:@"ackCoinAccount_oilCardCharge"];
            exchangeTableViewCell.exchangeNameLabel.text = currentItemDictionary[@"taskName"];
            exchangeTableViewCell.exchangeTimeLabel.text = currentItemDictionary[@"taskTime"];
            exchangeTableViewCell.exchangeCurrentItemCashLabel.text = currentItemDictionary[@"currentTaskCask"];
            if ([currentItemDictionary[@"taskStatus"] integerValue] == 0) {
                exchangeTableViewCell.exchangeStatusLabel.hidden = YES;
                exchangeTableViewCell.exchangeCurrentItemCashLabel.textColor = [UIColor colorWithRed:1.0 green:200/255.0 blue:200/255.0 alpha:1.0];
            }
            else
            {
                exchangeTableViewCell.exchangeStatusLabel.hidden = NO;
                exchangeTableViewCell.exchangeStatusLabel.textColor = [UIColor colorWithRed:1.0 green:200/255.0 blue:200/255.0 alpha:1.0];
                exchangeTableViewCell.exchangeCurrentItemCashLabel.textColor = [UIColor lightGrayColor];
            }
            exchangeTableViewCell.exchangeCurItemTotalLabel.text = currentItemDictionary[@"currentaskTotalAckCoin"];
            exchangeTableViewCell.exchangeItemImage = [UIImage imageNamed:@"ackCoinAccount_oilCardCharge"];
        }
        
    }
    
    
    
    return tableViewCell;
}

#pragma mark UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self showingCusDatePicker];
    
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
