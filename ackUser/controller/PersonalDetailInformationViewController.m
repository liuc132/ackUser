//
//  PersonalDetailInformationViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/16.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "PersonalDetailInformationViewController.h"
#import "ackUserPCH.pch"
#import "CustomDatePickView.h"
#import "NormalPickerView.h"
#import "AckUserDBManager.h"
#import "UIImageView+WebCache.h"
#import "UIColor+HexColor.h"
#import "VerifyIDViewController.h"
#import "PersonalCenterViewController.h"
#import "UIImageView+WebCache.h"
#import "HTTPRequest.h"
#import "PersonalCenterMainModel.h"
#import "UserDetailBaseDataModel.h"
#import "UserDetailView.h"
#import "UserDetailSelectViewController.h"
#import "Masonry.h"
#import "SVProgressHUD.h"

#define CityTag                     100
#define PhoneTag                    101
#define NickNameTag                 102
#define SexTag                      103
#define BirthDayTag                 104
#define LiveCityTag                 105
#define WorkCityTag                 106
#define MarrigeTag                  107
#define IndustryTag                 108
#define JobRoleTag                  109
#define IncomeTag                   110
#define HobbyTag                    111
#define GroupTag                    112



@interface PersonalDetailInformationViewController ()<UIScrollViewDelegate, UIGestureRecognizerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UserDetailSelectViewControllerDelegate>
{
    CustomDatePickView *cusDatePickerView;
    NormalPickerView   *customNormalPickerView;
}

@property (strong, nonatomic) AckUserDBManager          *userDetailInformationDBManager;
@property (strong, nonatomic) NSMutableDictionary       *userCachedDictionary;


@property (strong, nonatomic) UserDetailView            *userDetailView;

@property (strong, nonatomic) NSDate                    *startInstallDate;
@property (strong, nonatomic) NSDate                    *endInstallDate;

@property (strong, nonatomic) NSDate                    *startDate;

@property (strong, nonatomic) UITextField               *currentTextField;

@property (strong, nonatomic) NSArray                   *sexKindArray;
@property (copy, nonatomic)   NSString                  *selectedResult;
@property (copy, nonatomic)   NSString                  *headerImageURLString;

@property (assign, nonatomic) BOOL                      signInTag;

@property (strong, nonatomic) HTTPRequest               *userDetailHttpSession;
@property (strong, nonatomic) PersonalCenterMainModel   *userDetailModel;

@property (strong, nonatomic) PersonalCenterMainModel   *uploadUserDetailModel;
@property (strong, nonatomic) UserDetailBaseDataModel   *sexBaseDataModel;
@property (strong, nonatomic) UserDetailBaseDataModel   *marrigeStatusBaseDataModel;
@property (strong, nonatomic) UserDetailBaseDataModel   *industryBaseDataModel;
@property (strong, nonatomic) UserDetailBaseDataModel   *jobRoleBaseDataModel;
@property (strong, nonatomic) UserDetailBaseDataModel   *incomeBaseDataModel;
@property (strong, nonatomic) UserDetailBaseDataModel   *hobbyBaseDataModel;

@end

@implementation PersonalDetailInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _signInTag = [[[NSUserDefaults standardUserDefaults] objectForKey:@"signInTag"] boolValue];
    
    [self settingNetworkInitialization];
    
    [self loadInitializationData];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    [self settingNavBar];
    
    
    [self settingCustomPickerView];
    [self settingNormalPickerView];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if ([SVProgressHUD isVisible]) {
        [SVProgressHUD dismiss];
    }
    
    
}


#pragma mark -privateMethod

- (void)settingNetworkInitialization
{
    _userDetailHttpSession = [HTTPRequest sharedManager];
    
}

- (void)loadInitializationData
{
    __weak typeof(self) weakSelf = self;
    _sexKindArray = @[@"男", @"女"];
    _selectedResult = @"男";
    
    _sexBaseDataModel = [[UserDetailBaseDataModel alloc] init];
    _marrigeStatusBaseDataModel = [[UserDetailBaseDataModel alloc] init];
    _industryBaseDataModel = [[UserDetailBaseDataModel alloc] init];
    _jobRoleBaseDataModel = [[UserDetailBaseDataModel alloc] init];
    _incomeBaseDataModel = [[UserDetailBaseDataModel alloc] init];
    _hobbyBaseDataModel = [[UserDetailBaseDataModel alloc] init];
    
    [_userDetailHttpSession getUserDetailDictionarySuccess:^(id finish) {
        if ([finish[@"code"] integerValue] == RequestSuccess) {
            
            
            
        }
        else if ([finish[@"code"] integerValue] == TokenExpired)
        {
            
        }
        
        
    } failure:^(NSError *reqError) {
        NSLog(@"%@",reqError.localizedDescription);
        
        
    }];
    
    if (_isFinishUserData) {
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            [strongSelf customCreateDetailInformationView];
            [SVProgressHUD dismiss];
        });
        
    }
    else
    {
        [_userDetailHttpSession UserDetailInitialDataRequestSuccess:^(id finish) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if ([finish[@"code"] integerValue] == TokenExpired)
            {
                [strongSelf pcDetailToPCVC];
                NSLog(@"重新登录...");
                [SVProgressHUD dismiss];
                
                return ;
            }
            else if ([finish[@"code"] integerValue] == RequestSuccess)
            {
                NSDictionary *resultDictionary = (NSDictionary *)finish[@"entity"];
                [strongSelf filterUserDetailWithResult:resultDictionary];
            }
            
            
        } failure:^(NSError *reqError) {
            
        }];
    }
    
    
}

- (void)filterUserDetailWithResult:(NSDictionary *)result
{
    __weak typeof(self) weakSelf = self;
    
    _userDetailModel = [[PersonalCenterMainModel alloc] init];
    NSString *wechatId = result[@"wechatId"];
    if ([wechatId isEqual:[NSNull null]]) {
        _userDetailModel.wechatId = @"";
    }
    else
    {
        _userDetailModel.wechatId = wechatId;
    }
    NSString *qqId = result[@"qqId"];
    if ([qqId isEqual:[NSNull null]]) {
        _userDetailModel.qqId = @"";
    }
    else
    {
        _userDetailModel.qqId = qqId;
    }
    NSString *microblogId = result[@"microblogId"];
    if ([microblogId isEqual:[NSNull null]]) {
        _userDetailModel.microblogId = @"";
    }
    else
    {
        _userDetailModel.microblogId = microblogId;
    }
    NSString *contactAddr = result[@"contactAddr"];
    if ([contactAddr isEqual:[NSNull null]]) {
        _userDetailModel.contactAddr = @"";
    }
    else
    {
        _userDetailModel.contactAddr = contactAddr;
    }
    NSString *nickname = result[@"nickname"];
    if ([nickname isEqual:[NSNull null]]) {
        _userDetailModel.nickname = @"";
    }
    else
    {
        _userDetailModel.nickname = nickname;
    }
    NSString *sex = result[@"sex"];
    if ([sex isEqual:[NSNull null]]) {
        _userDetailModel.sex = @"";
    }
    else
    {
        _userDetailModel.sex = sex;
    }
    NSString *tel = result[@"tel"];
    if ([tel isEqual:[NSNull null]]) {
        _userDetailModel.tel = @"";
    }
    else
    {
        _userDetailModel.tel = tel;
    }
    NSString *idno = result[@"idno"];
    if ([idno isEqual:[NSNull null]]) {
        _userDetailModel.idno = @"";
    }
    else
    {
        _userDetailModel.idno = idno;
    }
    NSString *birthDate = result[@"birthDate"];
    if ([birthDate isEqual:[NSNull null]]) {
        _userDetailModel.birthDate = @"";
    }
    else
    {
        _userDetailModel.birthDate = birthDate;
    }
    NSString *marigStatus = result[@"marigStatus"];
    if ([marigStatus isEqual:[NSNull null]]) {
        _userDetailModel.marigStatus = @"";
    }
    else
    {
        _userDetailModel.marigStatus = marigStatus;
    }
    NSString *province = result[@"province"];
    if ([province isEqual:[NSNull null]]) {
        _userDetailModel.province = @"";
    }
    else
    {
        _userDetailModel.province = province;
    }
    NSString *regCity = result[@"regCity"];
    if ([regCity isEqual:[NSNull null]]) {
        _userDetailModel.regCity = @"";
    }
    else
    {
        _userDetailModel.regCity = regCity;
    }
    NSString *workarea = result[@"workarea"];
    if ([workarea isEqual:[NSNull null]]) {
        _userDetailModel.workarea = @"";
    }
    else
    {
        _userDetailModel.workarea = workarea;
    }
    NSString *resiArea = result[@"resiArea"];
    if ([resiArea isEqual:[NSNull null]]) {
        _userDetailModel.resiArea = @"";
    }
    else
    {
        _userDetailModel.resiArea = resiArea;
    }
    NSString *invtCode = result[@"resiArea"];
    if ([invtCode isEqual:[NSNull null]]) {
        _userDetailModel.invtCode = @"";
    }
    else
    {
        _userDetailModel.invtCode = invtCode;
    }
    NSString *invtCodeRel = result[@"invtCodeRel"];
    if ([invtCodeRel isEqual:[NSNull null]]) {
        _userDetailModel.invtCodeRel = @"";
    }
    else
    {
        _userDetailModel.invtCodeRel = invtCodeRel;
    }
    NSString *industryCd = result[@"industryCd"];
    if ([industryCd isEqual:[NSNull null]]) {
        _userDetailModel.industryCd = @"";
    }
    else
    {
        _userDetailModel.industryCd = industryCd;
    }
    NSString *occpCd = result[@"occpCd"];
    if ([occpCd isEqual:[NSNull null]]) {
        _userDetailModel.occpCd = @"";
    }
    else
    {
        _userDetailModel.occpCd = occpCd;
    }
    NSString *incomeCd = result[@"incomeCd"];
    if ([incomeCd isEqual:[NSNull null]]) {
        _userDetailModel.incomeCd = @"";
    }
    else
    {
        _userDetailModel.incomeCd = incomeCd;
    }
    NSString *hobbyCd = result[@"hobbyCd"];
    if ([hobbyCd isEqual:[NSNull null]]) {
        _userDetailModel.hobbyCd = @"";
    }
    else
    {
        _userDetailModel.hobbyCd = hobbyCd;
    }
    NSString *headImgUrl = result[@"headImgUrl"];
    if ([hobbyCd isEqual:[NSNull null]]) {
        _userDetailModel.headImgUrl = @"";
    }
    else
    {
        _userDetailModel.headImgUrl = headImgUrl;
    }
    NSString *score = result[@"score"];
    if ([score isEqual:[NSNull null]]) {
        _userDetailModel.score = @"";
    }
    else
    {
        _userDetailModel.score = score;
    }
    NSString *cash = result[@"cash"];
    if ([score isEqual:[NSNull null]]) {
        _userDetailModel.cash = @"";
    }
    else
    {
        _userDetailModel.cash = cash;
    }
    NSString *creditLevel = result[@"creditLevel"];
    if ([creditLevel isEqual:[NSNull null]]) {
        _userDetailModel.creditLevel = @"";
    }
    else
    {
        _userDetailModel.creditLevel = creditLevel;
    }
    NSString *creditScore = result[@"creditScore"];
    if ([creditScore isEqual:[NSNull null]]) {
        _userDetailModel.creditScore = @"";
    }
    else
    {
        _userDetailModel.creditScore = creditScore;
    }
    NSString *carClubsVlue = result[@"carClubsVlue"];
    if ([carClubsVlue isEqual:[NSNull null]]) {
        _userDetailModel.carClubsVlue = @"";
    }
    else
    {
        _userDetailModel.carClubsVlue = carClubsVlue;
    }
    NSString *userId = result[@"id"];
    if ([carClubsVlue isEqual:[NSNull null]]) {
        _userDetailModel.userId = @"";
    }
    else
    {
        _userDetailModel.userId = userId;
    }
    
    _userDetailModel.isUpdateResiArea = [result[@"updateResiArea"] boolValue];
    _userDetailModel.isUpdateWorkarea = [result[@"updateWorkarea"] boolValue];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf customCreateDetailInformationView];
        [SVProgressHUD dismiss];
    });
    
}

- (void)settingNormalPickerView
{
    if (customNormalPickerView == nil) {
        customNormalPickerView = [[NormalPickerView alloc] init];
        customNormalPickerView.normalPickerView.delegate = self;
        customNormalPickerView.normalPickerView.dataSource = self;
        [self.view addSubview:customNormalPickerView];
        [customNormalPickerView makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.bottom);
            make.left.equalTo(self.view.left);
            make.right.equalTo(self.view.right);
            make.height.equalTo(@200);
        }];
        [customNormalPickerView.normalPickerCancleButton addTarget:self action:@selector(normalPickerCancle) forControlEvents:UIControlEventTouchUpInside];
        [customNormalPickerView.normalPickerConfirmButton addTarget:self action:@selector(normalPickerConfirm) forControlEvents:UIControlEventTouchUpInside];
        [customNormalPickerView setHidden:YES];
    }
}

- (void)normalPickerConfirm
{
    _currentTextField.text = _selectedResult;
    
    [self hideCusNormalPicker];
}

- (void)normalPickerCancle
{
    [self hideCusNormalPicker];
}

- (void)hideCusNormalPicker
{
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [customNormalPickerView setHidden:YES];
        [weakSelf.view sendSubviewToBack:customNormalPickerView];
        
    });
}

- (void)showingCusNormalPicker
{
    __unsafe_unretained typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.view endEditing:YES];
        [customNormalPickerView setHidden:NO];
        [weakSelf.view bringSubviewToFront:customNormalPickerView];
    });
}

//
- (void)settingCustomPickerView
{
    _startDate = [NSDate date];
    
    if (cusDatePickerView == nil) {
        cusDatePickerView = [[CustomDatePickView alloc] init];
        [self.view addSubview:cusDatePickerView];
        [cusDatePickerView makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.bottom);
            make.left.equalTo(self.view.left);
            make.right.equalTo(self.view.right);
            make.height.equalTo(@280);
        }];
        
        [cusDatePickerView.dateCancleButton addTarget:self action:@selector(dateCancle) forControlEvents:UIControlEventTouchUpInside];
        [cusDatePickerView.dateConfirmButton addTarget:self action:@selector(dateConfirm) forControlEvents:UIControlEventTouchUpInside];
        [cusDatePickerView setHidden:YES];
        
    }
}

- (void)dateConfirm
{
    NSDate *curDate = cusDatePickerView.datePickerView.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *selectDate = [formatter stringFromDate:curDate];
    
    
    _currentTextField.text = selectDate;
    
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
        [cusDatePickerView setHidden:YES];
        [weakSelf.view sendSubviewToBack:cusDatePickerView];
        
    });
}

- (void)showingCusDatePicker
{
    __unsafe_unretained typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.view endEditing:YES];
        [cusDatePickerView setHidden:NO];
        [cusDatePickerView.datePickerView setDate:_startDate animated:YES];
        [weakSelf.view bringSubviewToFront:cusDatePickerView];
    });
}


- (void)customCreateDetailInformationView
{
    if (_userDetailView == nil) {
        _userDetailView = [[UserDetailView alloc] init];
        [self.view addSubview:_userDetailView];
        [_userDetailView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        UITapGestureRecognizer *avatarTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showActionSheetToSettingAvatar:)];
        avatarTapGesture.numberOfTouchesRequired = 1;
        avatarTapGesture.numberOfTapsRequired = 1;
        avatarTapGesture.delegate = self;
        [_userDetailView.avatarView addGestureRecognizer:avatarTapGesture];
        [_userDetailView.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",_userDetailModel.headImgUrl] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"detailInformation_avatar"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                _userDetailView.avatarImageView.image = image;
            }
        }];
        
        NSString *regCity = _userDetailModel.regCity;
        NSString *registeredCityString = (regCity.length > 0)?@"城市":@"城市(必填)";
        _userDetailView.registeredCityLabel.text = registeredCityString;
        if (regCity.length <= 0) {
            NSMutableAttributedString *registeredCityAttrStr = [[NSMutableAttributedString alloc] initWithString:registeredCityString];
            //setting font
            //    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
            [registeredCityAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(2, 4)];
            [registeredCityAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1.0 green:200/255.0 blue:200/255.0 alpha:1.0] range:NSMakeRange(2, 4)];
            _userDetailView.registeredCityLabel.attributedText = registeredCityAttrStr;
        }
        
        _userDetailView.registeredCityTextField.tag = CityTag;
        _userDetailView.registeredCityTextField.delegate = self;
        if (regCity.length > 0) {
            _userDetailView.registeredCityTextField.userInteractionEnabled = NO;
            _userDetailView.registeredCityTextField.text = regCity;
        }
        
        NSString *userTel = _userDetailModel.tel;
        NSString *phoneNameString = (userTel.length > 0)?@"手机":@"手机(必填)";
        _userDetailView.phoneNumberLabel.text = @"手机";
        if (userTel.length <= 0) {
            NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:phoneNameString];
            //setting font
            //    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
            [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(2, 4)];
            [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1.0 green:200/255.0 blue:200/255.0 alpha:1.0] range:NSMakeRange(2, 4)];
            _userDetailView.phoneNumberLabel.attributedText = attrStr;
        }
        _userDetailView.phoneNumInputTextField.delegate = self;
        _userDetailView.phoneNumInputTextField.tag = PhoneTag;
        if (userTel.length > 0) {
            _userDetailView.phoneNumInputTextField.text = [NSString stringWithFormat:@"%@*****%@",[userTel substringWithRange:NSMakeRange(0, 3)],[userTel substringWithRange:NSMakeRange(8, 3)]];
        }
        
        _userDetailView.registeredCodeLabel.text = _signInTag?@"所属群":@"注册码";
        _userDetailView.registeredCodeTextField.tag = GroupTag;
        _userDetailView.registeredCodeTextField.delegate = self;
        if (_signInTag) {
            _userDetailView.registeredCodeTextField.text = _userDetailModel.invtCode;
            _userDetailView.registeredCodeTextField.userInteractionEnabled = NO;
        }
        else
        {
            _userDetailView.registeredCodeTextField.userInteractionEnabled = YES;
        }
        
        _userDetailView.nickNameTextField.tag = NickNameTag;
        _userDetailView.nickNameTextField.delegate = self;
        NSString *nickname = _userDetailModel.nickname;
        if (nickname.length > 0) {
            _userDetailView.nickNameTextField.text = nickname;
        }
        
        NSString *sex = [NSString stringWithFormat:@"%@",_userDetailModel.sex];
        NSString *sexString = (sex.length > 0)?@"性别":@"性别(必填)";
        _userDetailView.sexLabel.text = sexString;
        if (sex.length <= 0) {
            NSMutableAttributedString *sexattrStr = [[NSMutableAttributedString alloc] initWithString:sexString];
            //setting font
            //    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
            [sexattrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(2, 4)];
            [sexattrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1.0 green:200/255.0 blue:200/255.0 alpha:1.0] range:NSMakeRange(2, 4)];
            _userDetailView.sexLabel.attributedText = sexattrStr;
         }
        _userDetailView.sexTextField.tag = SexTag;
        _userDetailView.sexTextField.delegate = self;
        _userDetailView.sexTextField.text = sex;
        
        NSString *birthday = [NSString stringWithFormat:@"%@",_userDetailModel.birthDate];
        NSString *birthdayString = (birthday.length > 0)?@"出生日期":@"出生日期(必填)";
        _userDetailView.birthdayLabel.text = birthdayString;
        if (birthday.length <= 0) {
            NSMutableAttributedString *birthdayAttrStr = [[NSMutableAttributedString alloc] initWithString:birthdayString];
            //setting font
            //    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
            [birthdayAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(4, 4)];
            [birthdayAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1.0 green:200/255.0 blue:200/255.0 alpha:1.0] range:NSMakeRange(4, 4)];
            _userDetailView.birthdayLabel.attributedText = birthdayAttrStr;
         }
        _userDetailView.birthdayTextField.tag = BirthDayTag;
        _userDetailView.birthdayTextField.delegate = self;
        if (birthday.length > 0) {
            _userDetailView.birthdayTextField.text = birthday;
        }
        
        NSString *liveCity = [NSString stringWithFormat:@"%@",_userDetailModel.resiArea];
        NSString *liveCityString = (liveCity.length > 0)?@"居住区域":@"居住区域(必填)";
        _userDetailView.liveCityLabel.text = liveCityString;
        if (liveCity.length <= 0) {
            NSMutableAttributedString *liveCityAttrStr = [[NSMutableAttributedString alloc] initWithString:liveCityString];
            //setting font
            //    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
            [liveCityAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(4, 4)];
            [liveCityAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1.0 green:200/255.0 blue:200/255.0 alpha:1.0] range:NSMakeRange(4, 4)];
            _userDetailView.liveCityLabel.attributedText = liveCityAttrStr;
         }
        _userDetailView.liveCityTextField.tag = LiveCityTag;
        _userDetailView.liveCityTextField.delegate = self;
        if (liveCity.length > 0) {
            _userDetailView.liveCityTextField.text = liveCity;
        }
        
        NSString *workCity = [NSString stringWithFormat:@"%@",_userDetailModel.workarea];
        NSString *workCityString = (workCity.length > 0)?@"工作区域":@"工作区域(必填)";
        _userDetailView.workCityLabel.text = workCityString;
        if (workCity.length <= 0) {
            NSMutableAttributedString *workCityAttrStr = [[NSMutableAttributedString alloc] initWithString:workCityString];
            //setting font
            //    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
            [workCityAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(4, 4)];
            [workCityAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1.0 green:200/255.0 blue:200/255.0 alpha:1.0] range:NSMakeRange(4, 4)];
            _userDetailView.workCityLabel.attributedText = workCityAttrStr;
         }
        _userDetailView.workCityTextField.tag = WorkCityTag;
        _userDetailView.workCityTextField.delegate = self;
        if (workCity.length > 0) {
            _userDetailView.workCityTextField.text = workCity;
        }
        
        _userDetailView.detailAddressTextField.tag = NickNameTag;
        _userDetailView.detailAddressTextField.delegate = self;
        NSString *detailAddr = [NSString stringWithFormat:@"%@",_userDetailModel.contactAddr];
        if (detailAddr.length > 0) {
            _userDetailView.detailAddressTextField.text = detailAddr;
        }
        
        _userDetailView.marriageStatusTextField.tag = MarrigeTag;
        _userDetailView.marriageStatusTextField.delegate = self;
        NSString *marriedState = [NSString stringWithFormat:@"%@",_userDetailModel.marigStatus];
        switch ([marriedState integerValue]) {
            case 0:
                _userDetailView.marriageStatusTextField.text = @"未婚";
                break;
                
            case 1:
                _userDetailView.marriageStatusTextField.text = @"已婚";
                break;
                
            case 2:
                _userDetailView.marriageStatusTextField.text = @"保密";
                break;
                
            default:
                break;
        }
        
        _userDetailView.industryTextField.tag = IndustryTag;
        _userDetailView.industryTextField.delegate = self;
        NSString *industry = [NSString stringWithFormat:@"%@",_userDetailModel.industryCd];
        if (industry.length > 0) {
            _userDetailView.industryTextField.text = industry;
        }
        
        _userDetailView.jobRoleTextField.tag = JobRoleTag;
        _userDetailView.jobRoleTextField.delegate = self;
        NSString *jobRole = [NSString stringWithFormat:@"%@",_userDetailModel.occpCd];
        if (jobRole.length > 0) {
            _userDetailView.jobRoleTextField.text = jobRole;
        }
        
        _userDetailView.monthlyIncomeTextField.tag = IncomeTag;
        _userDetailView.monthlyIncomeTextField.delegate = self;
        NSString *income = [NSString stringWithFormat:@"%@",_userDetailModel.incomeCd];
        if (income.length > 0) {
            _userDetailView.monthlyIncomeTextField.text = income;
        }
        
        _userDetailView.interestTextField.tag = HobbyTag;
        _userDetailView.interestTextField.delegate = self;
        NSString *hobby = [NSString stringWithFormat:@"%@",_userDetailModel.hobbyCd];
        if (hobby.length > 0) {
            _userDetailView.interestTextField.text = hobby;
        }
        
        [_userDetailView.detailSaveButton addTarget:self action:@selector(personalInformationSave:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    UITapGestureRecognizer *dismissTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDimissAction)];
    dismissTapGesture.delegate = self;
    dismissTapGesture.numberOfTapsRequired = 1;
    dismissTapGesture.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:dismissTapGesture];
    
}

- (void)tapDimissAction
{
    [self.view endEditing:YES];
    
}

- (void)personalInformationSave:(UIButton *)sender
{
    __weak typeof(self) weakSelf = self;
    NSLog(@"保存...");
    if (_isFinishUserData)//完善资料
    {
        NSString *sexKey;
        NSString *sexString = _userDetailView.sexTextField.text;
        if ([sexString isEqualToString:@"男"]) {
            sexKey = @"1";
        }
        else if ([sexString isEqualToString:@"女"]) {
            sexKey = @"2";
        }
        else
        {
            sexKey = @"0";
        }
        NSString *marrigeStatus = [NSString stringWithFormat:@"%@",_marrigeStatusBaseDataModel.dataKey];
        if ([marrigeStatus isEqualToString:@"(null)"]) {
            marrigeStatus = @"";
        }
        NSString *industry = [NSString stringWithFormat:@"%@",_industryBaseDataModel.dataKey];
        if ([industry isEqualToString:@"(null)"]) {
            industry = @"";
        }
        NSString *jobRole = [NSString stringWithFormat:@"%@",_jobRoleBaseDataModel.dataKey];
        if ([jobRole isEqualToString:@"(null)"]) {
            jobRole = @"";
        }
        NSString *income = [NSString stringWithFormat:@"%@",_incomeBaseDataModel.dataKey];
        if ([income isEqualToString:@"(null)"]) {
            income = @"";
        }
        NSString *hobby = [NSString stringWithFormat:@"%@",_hobbyBaseDataModel.dataKey];
        if ([hobby isEqualToString:@"(null)"]) {
            hobby = @"";
        }
        
        NSDictionary *userDataDictionary = @{@"regCity":_userDetailView.registeredCityTextField.text,@"province":_userDetailView.registeredCityTextField.text,@"tel":[NSString stringWithFormat:@"%@",_userDetailModel.tel],@"sex":sexKey,@"birthDate":_userDetailView.birthdayTextField.text,@"resiArea":_userDetailView.liveCityTextField.text,@"workarea":_userDetailView.workCityTextField.text,@"contactAddr":_userDetailView.detailAddressTextField.text,@"marigStatus":marrigeStatus,@"industryCd":industry,@"occpCd":jobRole,@"incomeCd":income,@"hobbyCd":hobby};
        
        [_userDetailHttpSession saveUserDetailInformationWithParameter:userDataDictionary success:^(id finish) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if ([finish[@"code"] integerValue] == RequestSuccess) {
                [strongSelf.navigationController popToRootViewControllerAnimated:YES];
            }
            
            NSLog(@"%@",finish);
            
        } failure:^(NSError *reqError) {
            
            NSLog(@"%@",reqError.localizedDescription);
            
            
        }];
        
    }
    else//修改资料
    {
        NSString *sexKey;
        NSString *sexString = _userDetailView.sexTextField.text;
        if ([sexString isEqualToString:@"男"]) {
            sexKey = @"1";
        }
        else if ([sexString isEqualToString:@"女"]) {
            sexKey = @"2";
        }
        else
        {
            sexKey = @"0";
        }
        NSString *marrigeStatus = [NSString stringWithFormat:@"%@",_marrigeStatusBaseDataModel.dataKey];
        if ([marrigeStatus isEqualToString:@"(null)"]) {
            marrigeStatus = @"";
        }
        NSString *industry = [NSString stringWithFormat:@"%@",_industryBaseDataModel.dataKey];
        if ([industry isEqualToString:@"(null)"]) {
            industry = @"";
        }
        NSString *jobRole = [NSString stringWithFormat:@"%@",_jobRoleBaseDataModel.dataKey];
        if ([jobRole isEqualToString:@"(null)"]) {
            jobRole = @"";
        }
        NSString *income = [NSString stringWithFormat:@"%@",_incomeBaseDataModel.dataKey];
        if ([income isEqualToString:@"(null)"]) {
            income = @"";
        }
        NSString *hobby = [NSString stringWithFormat:@"%@",_hobbyBaseDataModel.dataKey];
        if ([hobby isEqualToString:@"(null)"]) {
            hobby = @"";
        }
        
        NSDictionary *userDataDictionary = @{@"sex":sexKey,@"birthDate":_userDetailView.birthdayTextField.text,@"resiArea":_userDetailView.liveCityTextField.text,@"workarea":_userDetailView.workCityTextField.text,@"contactAddr":_userDetailView.detailAddressTextField.text,@"marigStatus":marrigeStatus,@"industryCd":industry,@"occpCd":jobRole,@"incomeCd":income,@"hobbyCd":hobby};
        
        
        
        [_userDetailHttpSession changeUserDetailWithParameter:userDataDictionary success:^(id finish) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            
            if ([finish[@"code"] integerValue] == RequestSuccess) {
                [strongSelf.navigationController popToRootViewControllerAnimated:YES];
            }
        } failure:^(NSError *reqError) {
            
        }];
        
    }
    
//    NSDictionary *userDataDictionary = @{@"birthDate":@"1993-11-12",@"hobbyCd":@"58",@"incomeCd":@"61",@"industryCd":@"46",@"invtCode":@"",@"marigStatus":@"69",@"microblogId":@"",@"nickname":@"城哥",@"occpCd":@"49",@"province":@"重庆市",@"qqId":@"0",@"regCity":@"重庆市",@"resiArea":@"渝北区",@"sex":@"1",@"tel":@"15000204331",@"wechatId":@"12",@"workarea":@"江北区"};
//    NSDictionary *userDataDictionary = @{@"birthDate":_userDetailView.birthdayTextField.text,@"hobbyCd":_userDetailView.interestTextField.text,@"incomeCd":_userDetailView.monthlyIncomeTextField.text,@"industryCd":_userDetailView.industryTextField.text,@"invtCode":_userDetailView.registeredCodeTextField.text,@"marigStatus":_userDetailView.marriageStatusTextField.text,@"microblogId":@"",@"nickname":_userDetailView.nickNameTextField.text,@"occpCd":_userDetailView.jobRoleTextField.text,@"province":_userDetailView.registeredCityTextField.text,@"qqId":@"0",@"regCity":_userDetailView.registeredCityTextField.text,@"resiArea":_userDetailView.liveCityTextField.text,@"sex":@"1",@"tel":@"15000204331",@"wechatId":@"12",@"workarea":_userDetailView.workCityTextField.text};
    
    
    
}

- (void)pressToGetVerifyCode:(UIButton *)sender
{
    //request
    
    //begin animation
    //[self startTimeCountdown];

    
}
/*
-(void)startTimeCountdown{
    __block int timeout=59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置 特别注明：UI的改变一定要在主线程中进行
                [_getVerifyCodeButton setTitle:@"重新发送" forState:UIControlStateNormal];
                _getVerifyCodeButton.userInteractionEnabled = YES;
                _verifyCodeTextField.placeholder = @"输入验证码";
                
                [self.view setNeedsDisplay];
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //设置界面的按钮显示 根据自己需求设置
                _getVerifyCodeButton.titleLabel.textAlignment = NSTextAlignmentCenter;
                _getVerifyCodeButton.titleLabel.adjustsFontSizeToFitWidth = YES;
                
                [_userDetailView.getVerifyCodeButton setTitle:[NSString stringWithFormat:@"%@秒后重发",strTime] forState:UIControlStateNormal];
                _getVerifyCodeButton.userInteractionEnabled = NO;
            });
            timeout--;
            
        }
    });
    dispatch_resume(_timer);
    
}
*/

- (void)showActionSheetToSettingAvatar:(UITapGestureRecognizer *)tapGesture
{
    if (tapGesture.state == UIGestureRecognizerStateEnded) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        __block NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [alertController addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                sourceType = UIImagePickerControllerSourceTypeCamera;
                NSLog(@"camera");
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
                    imagePickerVC.delegate = self;
                    imagePickerVC.allowsEditing = NO;
                    imagePickerVC.sourceType = sourceType;
                    [self presentViewController:imagePickerVC animated:YES completion:^{
                        NSLog(@"finish enter into camera or albums");
                        if (sourceType == UIImagePickerControllerSourceTypeCamera) {
//                            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
                        }
                    }];
                });
                
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"从手机相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                NSLog(@"album");
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
                    imagePickerVC.delegate = self;
                    imagePickerVC.allowsEditing = NO;
                    imagePickerVC.sourceType = sourceType;
                    [self presentViewController:imagePickerVC animated:YES completion:^{
                        NSLog(@"finish enter into camera or albums");
                        if (sourceType == UIImagePickerControllerSourceTypeCamera) {
//                            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
                        }
                    }];
                });
                
            }]];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"cancle");
                
            }]];
            
            [self presentViewController: alertController animated: YES completion: nil];
        }
        else {
            //初始化actionsheet 不支持相机设备
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"该设备不支持拍照功能" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"cancle");
                
            }]];
            
            [self presentViewController:alertController animated:YES completion: nil];
            
        }
        
        
    }
}

/**
 导航栏设置
 */
- (void)settingNavBar
{
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(pcDetailToPCVC)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"refresh_button"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBarAction)];
    
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"登录已有账号" style:UIBarButtonItemStylePlain target:self action:@selector(signInAccountAction)];
    //
    //
    //    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"个人资料";
    
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
- (void)pcDetailToPCVC
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)settingTimeLabel
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    
    [adcomps setYear:0];
    
    [adcomps setMonth:-1];
    
    [adcomps setDay:0];
    
    NSDate *newdate = [calendar dateByAddingComponents:adcomps toDate:[NSDate date] options:0];
    
    _startInstallDate = newdate;
    _endInstallDate = [NSDate date];
    
    NSString *lastMonth = [dateFormatter stringFromDate:newdate];
    NSString *thisMonth = [dateFormatter stringFromDate:[NSDate date]];
    
    NSLog(@"newdate:%@ lastMonth:%@ thisMonth:%@",newdate,lastMonth,thisMonth);
    
}

- (void)gestureOfStartDate:(UITapGestureRecognizer *)tapGes
{
    __unsafe_unretained typeof(self) weakSelf = self;
    
    //    _currentSelectingLabel = _timeOfInstallingTaskLabel;
    dispatch_async(dispatch_get_main_queue(), ^{
//        [customDatePickerView.datePickerView setDate:_startInstallDate animated:YES];
//        [weakSelf.view bringSubviewToFront:customDatePickerView];
        [cusDatePickerView.datePickerView setDate:_startInstallDate animated:YES];
        [weakSelf.view bringSubviewToFront:cusDatePickerView];
    });
    
}


#pragma mark imagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    __weak typeof(self) weakSelf = self;
    UIImage *respondImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (respondImage) {
        _userDetailView.avatarImageView.image = respondImage;
        
        [_userDetailHttpSession uploadImageToServerWithImage:respondImage andIndex:0 complete:^(id finish) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSLog(@"%@",finish);
            if ([finish[@"code"] integerValue] == TokenExpired) {
                
                
                return ;
            }
            else if ([finish[@"code"] integerValue] == RequestSuccess)
            {
                NSArray *imageUrlArray = finish[@"rows"];
                NSDictionary *imageInfoDic = (NSDictionary *)imageUrlArray[0];
                strongSelf.headerImageURLString = imageInfoDic[@"attachUrl"];
                
                [strongSelf.userDetailView.avatarImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",strongSelf.headerImageURLString] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:respondImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (image) {
                        strongSelf.userDetailView.avatarImageView.image = image;
                    }
                }];
            }
            
        } error:^(id reqError) {
            NSError *backError = (NSError *)reqError;
            NSLog(@"error:%@",backError.localizedDescription);
            
            
        }];
        
        
    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
//        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        [picker dismissViewControllerAnimated:YES completion:NULL];
    });
}

#pragma mark -UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    __weak typeof(self) weakSelf = self;
    _currentTextField = textField;
    
    if (textField.tag == NickNameTag) {
        NSLog(@"可以输入...");
        [self hideCusDatePicker];
        [self hideCusNormalPicker];
        
    }
    /*else if (textField.tag == SexTag)
    {
        NSLog(@"选择性别");
        [self showingCusNormalPicker];
        [self.view endEditing:YES];
    }*/
    
    else if (textField.tag == PhoneTag)
    {
        NSString *telString = [NSString stringWithFormat:@"%@",_userDetailModel.tel];
        if (telString.length > 0) {
            [self.view endEditing:YES];
            [self performSegueWithIdentifier:@"personalDetailToVerifyID" sender:nil];
            
        }
    }
    
    else if (textField.tag == BirthDayTag)
    {
        NSLog(@"可以选择...");
        [self showingCusDatePicker];
    }
    
    else if (textField.tag == JobRoleTag)
    {
        [self.view endEditing:YES];
        NSString *industryID = [NSString stringWithFormat:@"%@",_industryBaseDataModel.dataID];
        if (industryID.length > 0) {
            [self performSegueWithIdentifier:@"personalDetailToUserSelect" sender:nil];
        }
        else
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先选择所在行业!" preferredStyle:UIAlertControllerStyleAlert];
            
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"confirm");
                
            }]];
            
            [self presentViewController:alertController animated:YES completion: nil];
        }
        
    }
    
    else {
        [self.view endEditing:YES];
        [self performSegueWithIdentifier:@"personalDetailToUserSelect" sender:nil];
        
        
    }
    
}

#pragma mark -UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _sexKindArray[row];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _sexKindArray.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _selectedResult = _sexKindArray[row];
}

#pragma mark -UserDetailSelectViewControllerDelegate
- (void)passSelectDataWithParameter:(UserDetailBaseDataModel *)selectedParameter
{
    switch (_currentTextField.tag) {
        case SexTag:
            _sexBaseDataModel = selectedParameter;
            break;
        case MarrigeTag:
            _marrigeStatusBaseDataModel = selectedParameter;
            break;
        case IndustryTag:
            _industryBaseDataModel = selectedParameter;
            break;
        case JobRoleTag:
            _jobRoleBaseDataModel = selectedParameter;
            break;
        case IncomeTag:
            _incomeBaseDataModel = selectedParameter;
            break;
        case HobbyTag:
            _hobbyBaseDataModel = selectedParameter;
            break;
            
        default:
            break;
    }
    _currentTextField.text = [NSString stringWithFormat:@"%@",selectedParameter.dataValue];
    
}

- (void)passAreaWithParameter:(NSString *)areaName
{
    _currentTextField.text = areaName;
}

#pragma mark memoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UserDetailSelectViewController *selectVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"personalDetailToUserSelect"]) {
        selectVC.userDetailDelegate = self;
        NSString *navigationTitleString;
        NSString *dataTypeString;
        switch (_currentTextField.tag) {
            case CityTag:
                navigationTitleString = @"城市";
                selectVC.dataType = @"1";
                break;
            case GroupTag:
                navigationTitleString = @"所属群";
                dataTypeString = @"";
                selectVC.dataType = @"1";
                break;
            case SexTag:
                navigationTitleString = @"性别";
                dataTypeString = @"sex";
                selectVC.dataType = @"3";
                break;
            case LiveCityTag:
                navigationTitleString = @"居住区域";
                selectVC.dataType = @"1";
                break;
            case WorkCityTag:
                navigationTitleString = @"工作区域";
                selectVC.dataType = @"1";
                break;
            case MarrigeTag:
                navigationTitleString = @"婚姻状态";
                dataTypeString = @"marital_status";
                selectVC.dataType = @"3";
                break;
            case IndustryTag:
                navigationTitleString = @"行业";
                dataTypeString = @"industy";
                selectVC.dataType = @"3";
                break;
            case JobRoleTag:
                navigationTitleString = @"职业角色";
                selectVC.dataType = @"2";
                break;
            case IncomeTag:
                navigationTitleString = @"年收入";
                dataTypeString = @"income";
                selectVC.dataType = @"3";
                break;
            case HobbyTag:
                navigationTitleString = @"兴趣爱好";
                dataTypeString = @"hobby";
                selectVC.dataType = @"3";
                break;
                
            default:
                break;
        }
        selectVC.navigationBarTitle = navigationTitleString;
        selectVC.displayTypeString = dataTypeString;
        NSString *industryID = [NSString stringWithFormat:@"%@",_industryBaseDataModel.dataID];
        selectVC.industryIDString = industryID;
    }
    
}


@end
