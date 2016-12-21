//
//  ChargeOilCardViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/18.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "OilCardListViewController.h"
#import "ackUserPCH.pch"
#import "ActivateOilCardViewController.h"
#import "OilCardListTableViewCell.h"
#import "ChargePetroleumCardViewController.h"
#import "OilCardsListModel.h"
#import "HTTPRequest.h"
#import "UIColor+HexColor.h"
#import "UIImage+ChangeImageColor.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"

@interface OilCardListViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UIImageView       *navigationImageView;
@property (strong, nonatomic) UITableView       *chargeOilCardTableView;

@property (strong, nonatomic) HTTPRequest       *oilCardSessionManager;

@property (strong, nonatomic) NSMutableArray    *allOilCardsArray;
@property (strong, nonatomic) OilCardsListModel *curSelectOilCardListModel;



@end

@implementation OilCardListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self networkInitialization];
    [self oilCardDataInitialization];
    
    [self customChargeOilCardView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    [self settingNavBar];
    
    
}

#pragma mark -privateMethod

- (void)networkInitialization
{
    _oilCardSessionManager = [HTTPRequest sharedManager];
}

- (void)oilCardDataInitialization
{
    _allOilCardsArray = [[NSMutableArray alloc] init];
    
    __weak typeof(self) weakSelf = self;
    [_oilCardSessionManager getOilCardListsSuccess:^(id finish) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        
        if ([finish[@"code"] integerValue] == RequestSuccess) {
            NSArray *oilCardsArray = finish[@"rows"];
            [strongSelf filterOilCardDataWithArray:oilCardsArray];
            
        }
        else if ([finish[@"code"] integerValue] == TokenExpired)
        {
            
        }
        
    } failure:^(NSError *reqError) {
        NSLog(@"%@",reqError.localizedDescription);
        
        
    }];
}

- (void)filterOilCardDataWithArray:(NSArray *)resultArray
{
    for (NSDictionary *eachOilCard in resultArray) {
        OilCardsListModel *eachCardModel = [[OilCardsListModel alloc] init];
        NSString *backimgurl = eachOilCard[@"backimgurl"];
        if ([backimgurl isEqual:[NSNull null]]) {
            eachCardModel.backimgurl = @"";
        }
        else
        {
            eachCardModel.backimgurl = backimgurl;
        }
        NSString *bindStatus = eachOilCard[@"bindStatus"];
        if ([bindStatus isEqual:[NSNull null]]) {
            eachCardModel.bindStatus = @"";
        }
        else
        {
            eachCardModel.bindStatus = bindStatus;
        }
        NSString *cardNumber = eachOilCard[@"cardNumber"];
        if ([cardNumber isEqual:[NSNull null]]) {
            eachCardModel.cardNumber = @"";
        }
        else
        {
            eachCardModel.cardNumber = cardNumber;
        }
        NSString *custel = eachOilCard[@"custel"];
        if ([custel isEqual:[NSNull null]]) {
            eachCardModel.custel = @"";
        }
        else
        {
            eachCardModel.custel = custel;
        }
        NSString *hotlinename = eachOilCard[@"hotlinename"];
        if ([hotlinename isEqual:[NSNull null]]) {
            eachCardModel.hotlinename = @"";
        }
        else
        {
            eachCardModel.hotlinename = hotlinename;
        }
        NSString *oilCardId = eachOilCard[@"id"];
        if ([oilCardId isEqual:[NSNull null]]) {
            eachCardModel.oilCardId = @"";
        }
        else
        {
            eachCardModel.oilCardId = oilCardId;
        }
        NSString *imgurl = eachOilCard[@"imgurl"];
        if ([imgurl isEqual:[NSNull null]]) {
            eachCardModel.imgurl = @"";
        }
        else
        {
            eachCardModel.imgurl = imgurl;
        }
        NSString *issettradpwd = eachOilCard[@"issettradpwd"];
        if ([issettradpwd isEqual:[NSNull null]]) {
            eachCardModel.issettradpwd = @"";
        }
        else
        {
            eachCardModel.issettradpwd = issettradpwd;
        }
        NSString *name = eachOilCard[@"name"];
        if ([name isEqual:[NSNull null]]) {
            eachCardModel.name = @"";
        }
        else
        {
            eachCardModel.name = name;
        }
        NSString *ownerId = eachOilCard[@"ownerId"];
        if ([ownerId isEqual:[NSNull null]]) {
            eachCardModel.ownerId = @"";
        }
        else
        {
            eachCardModel.ownerId = ownerId;
        }
        NSString *status = eachOilCard[@"status"];
        if ([status isEqual:[NSNull null]]) {
            eachCardModel.status = @"";
        }
        else
        {
            eachCardModel.status = status;
        }
        NSString *tel = eachOilCard[@"tel"];
        if ([tel isEqual:[NSNull null]]) {
            eachCardModel.tel = @"";
        }
        else
        {
            eachCardModel.tel = tel;
        }
        
        [_allOilCardsArray addObject:eachCardModel];
    }
    
    [_chargeOilCardTableView reloadData];
    
}

- (void)customChargeOilCardView
{
    _chargeOilCardTableView = [UITableView new];
    _chargeOilCardTableView.delegate = self;
    _chargeOilCardTableView.dataSource = self;
    _chargeOilCardTableView.allowsSelection = NO;
    _chargeOilCardTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_chargeOilCardTableView];
    [_chargeOilCardTableView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    
}

- (void)forgetPasswordAction:(UIButton *)sender
{
    NSLog(@"忘记密码...");
    
    
}

- (void)confirmPasswordInputAction:(UIButton *)sender
{
    NSLog(@"确认...");
    
    
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
    
    //    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"查看交易明细" style:UIBarButtonItemStylePlain target:self action:@selector(ViewExchangeDetail)];
    //    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"油卡列表";
    
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
- (void)forgetBackToSignVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)oilCardChargeAction:(UIButton *)sender
{
    NSLog(@"进入油卡充值...");
    _curSelectOilCardListModel = (OilCardsListModel *)_allOilCardsArray[sender.tag];
    [self performSegueWithIdentifier:@"oilCarListToChargeVC" sender:nil];
    
    
}

- (void)activeOilCardAction:(UIButton *)sender
{
    NSLog(@"进入油卡挂失或者激活页面");
    //进入油卡激活页面，先判断是否是挂失或者激活
    _curSelectOilCardListModel = (OilCardsListModel *)_allOilCardsArray[sender.tag];
    NSString *status = [NSString stringWithFormat:@"%@",_curSelectOilCardListModel.status];
    
    if ([status integerValue] == UnactiveOilCard) {
        [self performSegueWithIdentifier:@"oilCardListToActiveVC" sender:nil];
    }
    else if ([status integerValue] == ActiveOilCard)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"为了保障您的资金安全，请您自点击确定挂失后立即拨打官方热线进行油卡冻结，我们将在24小时内联系您收取补办油卡的信息，请保持您的手机畅通。确定挂失吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
            
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确定");
            
        }]];
        
        [self presentViewController:alertController animated:YES completion: nil];
    }
    
    
}

/**
 设置油卡状态的默认背景图片，卡状态（ 0 未激活 1激活 2 废弃 3已挂失 ）

 @param status status 状态
 */
- (void)setTableCellDisplay:(OilCardListTableViewCell *)cusTableCell Status:(NSString *)status dataModel:(OilCardsListModel *)curCardListModel
{
    UIImage *oilCompanyLogo = [UIImage imageNamed:@"ackCoinAccount_oilCard_status"];
    
    switch ([status integerValue]) {
        case UnactiveOilCard:
            {
                UIImage *backDefaultImage = [UIImage imageNamed:@"ackCoinAccount_oilCard_negative"];
                [cusTableCell.backCellImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",curCardListModel.backimgurl] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:backDefaultImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (image) {
                        cusTableCell.backCellImageView.image = image;
                    }
                }];
                
                [cusTableCell.companyImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",curCardListModel.imgurl] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:oilCompanyLogo completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (image) {
                        cusTableCell.companyImageView.image = image;
                    }
                }];
                
                [cusTableCell.activeOilCardButton setBackgroundColor:[UIColor colorFromHexString:@"#ffa122" alpha:1.0]];
                cusTableCell.activeOilCardButton.enabled = YES;
                [cusTableCell.activeOilCardButton setTitle:@"激活" forState:UIControlStateNormal];
                [cusTableCell.oilCardChargeButton setBackgroundColor:[UIColor colorFromHexString:@"#7d8281" alpha:1.0]];
                cusTableCell.oilCardChargeButton.enabled = NO;
                
            }
            break;
        case ActiveOilCard:
            {
                UIImage *backDefaultImage = [UIImage imageNamed:@"ackCoinAccount_oilCard_positive"];
                [cusTableCell.backCellImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",curCardListModel.backimgurl] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:backDefaultImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (image) {
                        cusTableCell.backCellImageView.image = image;
                    }
                }];
                
                [cusTableCell.companyImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",curCardListModel.imgurl] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:oilCompanyLogo completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (image) {
                        cusTableCell.companyImageView.image = image;
                    }
                }];
                
                [cusTableCell.activeOilCardButton setBackgroundColor:[UIColor colorFromHexString:@"#ffa122" alpha:1.0]];
                cusTableCell.activeOilCardButton.enabled = YES;
                [cusTableCell.activeOilCardButton setTitle:@"挂失" forState:UIControlStateNormal];
                [cusTableCell.oilCardChargeButton setBackgroundColor:[UIColor colorFromHexString:@"#79aa3d" alpha:1.0]];
                cusTableCell.oilCardChargeButton.enabled = YES;
            }
            
            break;
        case AbandonOilCard:
            {
                UIImage *backDefaultImage = [UIImage imageNamed:@"ackCoinAccount_oilCard_loss"];
                [cusTableCell.backCellImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",curCardListModel.backimgurl] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:backDefaultImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (image) {
                        cusTableCell.backCellImageView.image = image;
                    }
                }];
                
                [cusTableCell.companyImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",curCardListModel.imgurl] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:oilCompanyLogo completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (image) {
                        cusTableCell.companyImageView.image = image;
                    }
                }];
                
                [cusTableCell.activeOilCardButton setBackgroundColor:[UIColor colorFromHexString:@"#7d8281" alpha:1.0]];
                cusTableCell.activeOilCardButton.enabled = NO;
                [cusTableCell.activeOilCardButton setTitle:@"废弃" forState:UIControlStateNormal];
                [cusTableCell.oilCardChargeButton setBackgroundColor:[UIColor colorFromHexString:@"#7d8281" alpha:1.0]];
                cusTableCell.oilCardChargeButton.enabled = NO;
                
            }
            
            break;
        case ReportLossOilCard:
            {
                UIImage *backDefaultImage = [UIImage imageNamed:@"ackCoinAccount_oilCard_loss"];
                [cusTableCell.backCellImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",curCardListModel.backimgurl] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:backDefaultImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (image) {
                        cusTableCell.backCellImageView.image = image;
                    }
                }];
                
                [cusTableCell.companyImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",curCardListModel.imgurl] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:oilCompanyLogo completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    if (image) {
                        cusTableCell.companyImageView.image = image;
                    }
                }];
                
                [cusTableCell.activeOilCardButton setBackgroundColor:[UIColor colorFromHexString:@"#7d8281" alpha:1.0]];
                cusTableCell.activeOilCardButton.enabled = NO;
                [cusTableCell.activeOilCardButton setTitle:@"挂失中" forState:UIControlStateNormal];
                [cusTableCell.oilCardChargeButton setBackgroundColor:[UIColor colorFromHexString:@"#7d8281" alpha:1.0]];
                cusTableCell.oilCardChargeButton.enabled = NO;
                
            }
            
            break;
            
        default:
            break;
    }
    
}

#pragma mark -UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allOilCardsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *tableCell;
    tableCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    OilCardListTableViewCell *oilCardCell = [[OilCardListTableViewCell alloc] init];
    
    if (tableCell == nil) {
        tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        oilCardCell.oilCardChargeButton.tag = indexPath.row;
        oilCardCell.activeOilCardButton.tag = indexPath.row;
        [oilCardCell.oilCardChargeButton addTarget:self action:@selector(oilCardChargeAction:) forControlEvents:UIControlEventTouchUpInside];
        [oilCardCell.activeOilCardButton addTarget:self action:@selector(activeOilCardAction:) forControlEvents:UIControlEventTouchUpInside];
        [tableCell addSubview:oilCardCell];
        [oilCardCell makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(tableCell.top).offset(1);
            make.bottom.equalTo(tableCell.bottom).offset(-1);
            make.left.equalTo(tableCell.left);
            make.right.equalTo(tableCell.right);
        }];
        
    }
    tableCell.backgroundColor = [UIColor colorFromHexString:@"#ffffff" alpha:1.0];
    OilCardsListModel *curOilCardModel = [[OilCardsListModel alloc] init];
    curOilCardModel = _allOilCardsArray[indexPath.row];
    
    [self setTableCellDisplay:oilCardCell Status:[NSString stringWithFormat:@"%@",curOilCardModel.status] dataModel:curOilCardModel];
    
    oilCardCell.oilCompanyNameLabel.text = [NSString stringWithFormat:@"%@",curOilCardModel.name];
    NSString *cardNumberString = [NSString stringWithFormat:@"%@",curOilCardModel.cardNumber];
    UIFont *cardNumberFont = [UIFont systemFontOfSize:20.0];
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = UILABEL_LINE_SPACE; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:cardNumberFont, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@2.5f};
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:cardNumberString attributes:dic];
    oilCardCell.oilCardNumberLabel.attributedText = attributeStr;
    oilCardCell.oilCardNumberLabel.text = [NSString stringWithFormat:@"%@****%@",[cardNumberString substringWithRange:NSMakeRange(0, 4)],[cardNumberString substringWithRange:NSMakeRange(cardNumberString.length - 3, 3)]];
    oilCardCell.oilCompanyHotLineLabel.text = [NSString stringWithFormat:@"%@(%@)",curOilCardModel.tel,curOilCardModel.hotlinename];
    
    
    return tableCell;
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
    ActivateOilCardViewController *activeOilCardVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"oilCardListToActiveVC"]) {
        activeOilCardVC.needActiveOilCardModel = _curSelectOilCardListModel;
        
    }
    
    ChargePetroleumCardViewController *chargePetroleumVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"oilCarListToChargeVC"]) {
        chargePetroleumVC.chargeOilCardModel = _curSelectOilCardListModel;
    }
    
}


@end
