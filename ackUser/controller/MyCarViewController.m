//
//  MyCarViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/23.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "MyCarViewController.h"
#import "ackUserPCH.pch"
#import "EachCarView.h"
#import "CarInformationViewController.h"
#import "HTTPRequest.h"
#import "UIColor+HexColor.h"
#import "CarInformationModel.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"



@interface MyCarViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIImageView                   *navigationImageView;
@property (strong, nonatomic) UITableView                   *myCarTableView;
@property (assign, nonatomic) BOOL                          addCarInformationEnable;    //YES:添加车辆;  NO:查看车辆信息
@property (strong, nonatomic) NSString                      *ownerName;

@property (strong, nonatomic) HTTPRequest                   *myCarsListSessionManager;

@property (strong, nonatomic) NSMutableArray                *allCarsInfoArray;
@property (copy, nonatomic) CarInformationModel             *currentCarInfoModel;




@end

@implementation MyCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self dataInitialization];
    [self settingNetwork];
    [self customMyCarView];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    [self settingNavBar];
    
    [self getMyCarsInformation];
    
}



#pragma mark -privateMethod

- (void)dataInitialization
{
    _allCarsInfoArray = [[NSMutableArray alloc] init];
    
}

- (void)getMyCarsInformation
{
    __weak typeof(self) weakSelf = self;
    
    [_myCarsListSessionManager getAllCarsListsSuccess:^(id finish) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"%@",finish);
        if ([finish[@"code"] integerValue] == RequestSuccess) {
            NSArray *carsArray = finish[@"rows"];
            
            [strongSelf filterCarsListWithResult:carsArray];
            
        }
        else if ([finish[@"code"] integerValue] == TokenExpired)
        {
            
        }
        
        
        
        
    } failure:^(NSError *reqError) {
        NSLog(@"%@",reqError.localizedDescription);
        
        
    }];
    
    
}

- (void)filterCarsListWithResult:(NSArray *)results
{
    //清除所有旧的车辆信息数据
    [_allCarsInfoArray removeAllObjects];
    
    for (NSDictionary *eachCar in results) {
        CarInformationModel *eachCarInfo = [[CarInformationModel alloc] init];
        NSString *brand = eachCar[@"brand"];
        if ([brand isEqual:[NSNull null]]) {
            eachCarInfo.brand = @"";
        }
        else
        {
            eachCarInfo.brand = brand;
        }
        NSString *brandImageUrl = eachCar[@"brandImgUrl"];
        if ([brandImageUrl isEqual:[NSNull null]]) {
            eachCarInfo.brandImgUrl = @"";
        }
        else
        {
            eachCarInfo.brandImgUrl = brandImageUrl;
        }
        NSString *colorCd = eachCar[@"colorCd"];
        if ([colorCd isEqual:[NSNull null]]) {
            eachCarInfo.colorCd = @"";
        }
        else
        {
            eachCarInfo.colorCd = colorCd;
        }
        NSString *colorName = eachCar[@"colorName"];
        if ([colorName isEqual:[NSNull null]]) {
            eachCarInfo.colorName = @"";
        }
        else
        {
            eachCarInfo.colorName = colorName;
        }
        NSString *creTime = eachCar[@"creTime"];
        if ([creTime isEqual:[NSNull null]]) {
            eachCarInfo.creTime = @"";//
        }
        else
        {
            eachCarInfo.creTime = creTime;
        }
        NSString *iD = eachCar[@"id"];
        if ([iD isEqual:[NSNull null]]) {
            eachCarInfo.iD = @"";//
        }
        else
        {
            eachCarInfo.iD = iD;
        }
        NSString *isreport = eachCar[@"isreport"];
        if ([isreport isEqual:[NSNull null]]) {
            eachCarInfo.isreport = @"";//
        }
        else
        {
            eachCarInfo.isreport = isreport;
        }
        NSString *issuetime = eachCar[@"issuetime"];
        if ([issuetime isEqual:[NSNull null]]) {
            eachCarInfo.issuetime = @"";//
        }
        else
        {
            eachCarInfo.issuetime = issuetime;
        }
        NSString *lastUpdateTime = eachCar[@"lastUpdateTime"];
        if ([lastUpdateTime isEqual:[NSNull null]]) {
            eachCarInfo.lastUpdateTime = @"";//
        }
        else
        {
            eachCarInfo.lastUpdateTime = lastUpdateTime;
        }
        NSString *latetime = eachCar[@"latetime"];
        if ([latetime isEqual:[NSNull null]]) {
            eachCarInfo.latetime = @"";//
        }
        else
        {
            eachCarInfo.latetime = latetime;
        }
        NSString *name = eachCar[@"name"];
        if ([name isEqual:[NSNull null]]) {
            eachCarInfo.name = @"";//
            _ownerName = @"";
        }
        else
        {
            eachCarInfo.name = name;
            _ownerName = name;
        }
        NSString *ownerId = eachCar[@"ownerId"];
        if ([ownerId isEqual:[NSNull null]]) {
            eachCarInfo.ownerId = @"";//
        }
        else
        {
            eachCarInfo.ownerId = ownerId;
        }
        NSString *plate = eachCar[@"plate"];
        if ([plate isEqual:[NSNull null]]) {
            eachCarInfo.plate = @"";//
        }
        else
        {
            eachCarInfo.plate = plate;
        }
        NSString *positivepic = eachCar[@"positivepic"];
        if ([positivepic isEqual:[NSNull null]]) {
            eachCarInfo.positivepic = @"";//
        }
        else
        {
            eachCarInfo.positivepic = positivepic;
        }
        NSString *priceCd = eachCar[@"priceCd"];
        if ([priceCd isEqual:[NSNull null]]) {
            eachCarInfo.priceCd = @"";//
        }
        else
        {
            eachCarInfo.priceCd = priceCd;
        }
        NSString *priceName = eachCar[@"priceName"];
        if ([priceName isEqual:[NSNull null]]) {
            eachCarInfo.priceName = @"";//
        }
        else
        {
            eachCarInfo.priceName = priceName;
        }
        NSString *series = eachCar[@"series"];
        if ([series isEqual:[NSNull null]]) {
            eachCarInfo.series = @"";//
        }
        else
        {
            eachCarInfo.series = series;
        }
        NSString *status = eachCar[@"status"];
        if ([status isEqual:[NSNull null]]) {
            eachCarInfo.status = @"";//
        }
        else
        {
            eachCarInfo.status = status;
        }
        NSString *travelpic = eachCar[@"travelpic"];
        if ([travelpic isEqual:[NSNull null]]) {
            eachCarInfo.travelpic = @"";//
        }
        else
        {
            eachCarInfo.travelpic = travelpic;
        }
        NSString *typeCd = eachCar[@"typeCd"];
        if ([typeCd isEqual:[NSNull null]]) {
            eachCarInfo.typeCd = @"";//
        }
        else
        {
            eachCarInfo.typeCd = typeCd;
        }
        NSString *typeName = eachCar[@"typeName"];
        if ([typeName isEqual:[NSNull null]]) {
            eachCarInfo.typeName = @"";//
        }
        else
        {
            eachCarInfo.typeName = typeName;
        }
        NSString *ventripic = eachCar[@"ventripic"];
        if ([ventripic isEqual:[NSNull null]]) {
            eachCarInfo.ventripic = @"";//
        }
        else
        {
            eachCarInfo.ventripic = ventripic;
        }
        
        //添加车辆信息到数组中
        [_allCarsInfoArray addObject:eachCarInfo];
    }
    
    [_myCarTableView reloadData];
    
}


- (void)settingNetwork
{
    /*
    _logInSessionManager = [AFHTTPSessionManager manager];
    _logInSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"text/javascript",@"application/json", nil];
    
    [_logInSessionManager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"userToken"] forHTTPHeaderField:@"Authorization"];
    
    _reachabilityManager = [AFNetworkReachabilityManager manager];
    [_reachabilityManager startMonitoring];
    */
    
    _myCarsListSessionManager = [HTTPRequest sharedManager];
    
}

- (void)customMyCarView
{
    _myCarTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _myCarTableView.delegate = self;
    _myCarTableView.dataSource = self;
    _myCarTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_myCarTableView];
    [_myCarTableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
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
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(myCarToPersonalCenterVC)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"button_addCar"] style:UIBarButtonItemStyleDone target:self action:@selector(addCarAction)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"我的车辆";
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];;
    [self.navigationController.navigationBar setTranslucent:NO];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    //NSFontAttributeName
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    
}

/**
 左侧导航按钮对应的action
 */
- (void)myCarToPersonalCenterVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addCarAction
{
    NSLog(@"添加车辆...");
    _addCarInformationEnable = YES;
    [self performSegueWithIdentifier:@"myCarToCarInformation" sender:nil];
    
}


#pragma mark -UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section:%ld",indexPath.section);
    
    _currentCarInfoModel = _allCarsInfoArray[indexPath.section];
    _addCarInformationEnable = NO;
    [self performSegueWithIdentifier:@"myCarToCarInformation" sender:nil];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _allCarsInfoArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *tableCell;
    tableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (tableCell == nil) {
        tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        EachCarView *eachCarView = [[EachCarView alloc] init];
        [tableCell addSubview:eachCarView];
        [eachCarView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        //初始化数据
        CarInformationModel *curRowCarInfoModel = _allCarsInfoArray[indexPath.section];
        eachCarView.carPlateNumberLabel.text = [NSString stringWithFormat:@"%@",curRowCarInfoModel.plate];
        eachCarView.carBrandLabel.text = [NSString stringWithFormat:@"%@",curRowCarInfoModel.brand];
        eachCarView.carPriceLabel.text = [NSString stringWithFormat:@"%@",curRowCarInfoModel.priceCd];
        [eachCarView.carBodyImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",curRowCarInfoModel.brandImgUrl] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"icon_carBody_sample1"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                eachCarView.carBodyImageView.image = image;
            }
        }];
        //状态还没加判断0:待审核 1:审核通过 2:审核不通过3:待完善 9:已注销
        NSString *status = [NSString stringWithFormat:@"%@",curRowCarInfoModel.status];
        NSString *statusString;
        switch ([status integerValue]) {
            case 0:
                statusString = @"待审核";
                eachCarView.carStatusLabel.backgroundColor = [UIColor colorFromHexString:@"#ffa022" alpha:1.0];
                break;
            
            case 1:
                statusString = @"审核通过";
                eachCarView.carStatusLabel.backgroundColor = [UIColor colorFromHexString:@"#7aaa3d" alpha:1.0];
                break;
                
            case 2:
                statusString = @"审核不通过";
                eachCarView.carStatusLabel.backgroundColor = [UIColor colorFromHexString:@"#f9503b" alpha:1.0];
                break;
                
            case 3:
                statusString = @"待完善";
                eachCarView.carStatusLabel.backgroundColor = [UIColor colorFromHexString:@"#516192" alpha:1.0];
                break;
                
            case 9:
                statusString = @"已注销";
                eachCarView.carStatusLabel.backgroundColor = [UIColor colorFromHexString:@"#7d8182" alpha:1.0];
                break;
                
            default:
                break;
        }
        
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],};
        CGSize textSize = [statusString boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
        eachCarView.carStatusLabel.text = statusString;
        [eachCarView.carStatusLabel updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(textSize.width+15));
        }];
        
        
    }
    tableCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
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
    if ([_myCarTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_myCarTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([_myCarTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_myCarTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}


#pragma mark -memoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    CarInformationViewController *carInfoVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"myCarToCarInformation"]) {
        carInfoVC.carInfoOwnerName = _ownerName;
        carInfoVC.carInfoReviewType = _addCarInformationEnable;
        carInfoVC.carInfoDetail = _currentCarInfoModel;
    }
    
}


@end
