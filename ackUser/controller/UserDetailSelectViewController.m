//
//  UserDetailSelectViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/14.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "UserDetailSelectViewController.h"
#import "ackUserPCH.pch"
#import "HTTPRequest.h"
#import "UserDetailBaseDataModel.h"
#import "Masonry.h"

/**
 1:获取地区  2:获取职业角色  3:除前两种类型以外的数据
 */
#define AreaType            1
#define JobRoleType         2
#define OtherType           3

@interface UserDetailSelectViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView               *userInformationTableView;
@property (strong, nonatomic) HTTPRequest               *userBaseDataSessionManager;

@property (strong, nonatomic) NSMutableArray            *displayDataArray;
@property (strong, nonatomic) UserDetailBaseDataModel   *curSelectDataModel;
@property (copy, nonatomic)   NSString                  *selectedAreaString;


@end

@implementation UserDetailSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self settingNavBar];
    [self networkInitialization];
    [self dataInitialization];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self customUserSelectView];
    
}


#pragma mark privateMethod

- (void)networkInitialization
{
    _userBaseDataSessionManager = [HTTPRequest sharedManager];
    
}

- (void)dataInitialization
{
    __weak typeof(self) weakSelf = self;
    _curSelectDataModel = [[UserDetailBaseDataModel alloc] init];
    _displayDataArray = [[NSMutableArray alloc] init];
    
    if ([_displayTypeString isEqualToString:@"hobby"]) {
        _userInformationTableView.allowsMultipleSelection = YES;
    }
    
    if ([_dataType integerValue] == AreaType) {
        [_userBaseDataSessionManager getAreasSuccess:^(id finish) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if ([finish[@"code"] integerValue] == RequestSuccess) {
                NSArray *resultArray = (NSArray *)finish[@"rows"];
                NSDictionary *cityDictionary = (NSDictionary *)resultArray[0];
                NSArray *cityArray = (NSArray *)cityDictionary[@"cityList"];
                NSDictionary *districtDictionary = (NSDictionary *)cityArray[0];
                [strongSelf filterAreasDataWithResult:districtDictionary[@"districtList"]];
                
            }
            else if ([finish[@"code"] integerValue] == TokenExpired)
            {
                
            }
            
        } failure:^(NSError *reqError) {
            NSLog(@"%@",reqError.localizedDescription);
            
        }];
        
    }
    else if ([_dataType integerValue] == JobRoleType) {
        NSDictionary *jobRoleParameter = @{@"industryCdId":_industryIDString};
        [_userBaseDataSessionManager getJobRoleWithParameter:jobRoleParameter success:^(id finish) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if ([finish[@"code"] integerValue] == RequestSuccess) {
                if ([finish[@"code"] integerValue] == RequestSuccess) {
                    NSArray *needDisplayArray = (NSArray *)finish[@"rows"];
                    [strongSelf filterNeedDisplayDataWithResult:needDisplayArray];
                    
                }
                else if ([finish[@"code"] integerValue] == TokenExpired)
                {
                    
                }
                
                
            }
            else if ([finish[@"code"] integerValue] == TokenExpired)
            {
                
            }
            
        } failure:^(NSError *reqError) {
            NSLog(@"%@",reqError.localizedDescription);
            
        }];
        
    }
    else if ([_dataType integerValue] == OtherType) {
        [_userBaseDataSessionManager getUserDetailDictionarySuccess:^(id finish) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if ([finish[@"code"] integerValue] == RequestSuccess) {
                NSArray *needDisplayArray = (NSArray *)finish[@"data"][_displayTypeString];
                [strongSelf filterNeedDisplayDataWithResult:needDisplayArray];
                
            }
            else if ([finish[@"code"] integerValue] == TokenExpired)
            {
                
            }
            
        } failure:^(NSError *reqError) {
            NSLog(@"%@",reqError.localizedDescription);
            
        }];
        
    }
    
}

- (void)filterAreasDataWithResult:(NSArray *)resultArray
{
    for (NSDictionary *eachProvince in resultArray) {
        [_displayDataArray addObject:eachProvince[@"value"]];
    }
    
    [_userInformationTableView reloadData];
    
}

- (void)filterNeedDisplayDataWithResult:(NSArray *)resultArray
{
    for (NSDictionary *eachBaseDic in resultArray) {
        UserDetailBaseDataModel *eachBaseDataModel = [[UserDetailBaseDataModel alloc] init];
        eachBaseDataModel.dataID = eachBaseDic[@"id"];
        eachBaseDataModel.dataKey = eachBaseDic[@"key"];
        eachBaseDataModel.dataValue = eachBaseDic[@"value"];
        [_displayDataArray addObject:eachBaseDataModel];
    }
    
    [_userInformationTableView reloadData];
}

- (void)customUserSelectView
{
    if (_userInformationTableView == nil) {
        _userInformationTableView = [UITableView new];
        _userInformationTableView.delegate = self;
        _userInformationTableView.dataSource = self;
        [self.view addSubview:_userInformationTableView];
        [_userInformationTableView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
    }
}



/**
 导航栏设置
 */
- (void)settingNavBar
{
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(userDetailSelectToUserDetail)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confirmCurrentSelect)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = _navigationBarTitle;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];;
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
}

/**
 左侧导航按钮对应的action
 */
- (void)userDetailSelectToUserDetail
{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)confirmCurrentSelect
{
    NSLog(@"确定选择...");
    if ([_dataType integerValue] == AreaType)
    {
        if (_selectedAreaString.length <= 0) {
            return;
        }
        if ([self.userDetailDelegate respondsToSelector:@selector(passAreaWithParameter:)]) {
            [_userDetailDelegate passAreaWithParameter:_selectedAreaString];
        }
    }
    else
    {
        if ([self.userDetailDelegate respondsToSelector:@selector(passSelectDataWithParameter:)]) {
            [_userDetailDelegate passSelectDataWithParameter:_curSelectDataModel];
        }
        
    }
    [self userDetailSelectToUserDetail];
    
}


#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_dataType integerValue] == AreaType)
    {
        _selectedAreaString = _displayDataArray[indexPath.row];
    }
    else
    {
        _curSelectDataModel = (UserDetailBaseDataModel *)_displayDataArray[indexPath.row];
        NSLog(@"%@",_curSelectDataModel.dataValue);
    }
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _displayDataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *tableCell;
    tableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (tableCell == nil) {
        tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if ([_dataType integerValue] == AreaType)
    {
        NSString *province = _displayDataArray[indexPath.row];
        tableCell.textLabel.text = province;
    }
    else
    {
        UserDetailBaseDataModel *curRowDataModel = [[UserDetailBaseDataModel alloc] init];
        curRowDataModel = _displayDataArray[indexPath.row];
        tableCell.textLabel.text = [NSString stringWithFormat:@"%@",curRowDataModel.dataValue];
    }
    
    
    return tableCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView setTableFooterView:[[UIView alloc]init]];
    //
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

-(void)viewDidLayoutSubviews
{
    if ([_userInformationTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_userInformationTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_userInformationTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_userInformationTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

#pragma mark memoryWarning
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
