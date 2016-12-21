//
//  CarTypeViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/29.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "CarTypeViewController.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "CarTypeView.h"
#import "Masonry.h"

@interface CarTypeViewController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView       *navigationImageView;
@property (strong, nonatomic) CarTypeView       *carTypeView;
@property (strong, nonatomic) NSString          *selectedCarTypeString;


@end

@implementation CarTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customCarInformationView];
    
    _selectedCarTypeString = [NSString stringWithFormat:@"轿车"];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    [self settingNavBar];
    
}



#pragma mark -privateMethod

- (void)customCarInformationView
{
    if (_carTypeView == nil) {
        _carTypeView = [[CarTypeView alloc] init];
        [self.view addSubview:_carTypeView];
        [_carTypeView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        UITapGestureRecognizer *normalCarViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(normalCarAction:)];
        normalCarViewGesture.delegate = self;
        normalCarViewGesture.numberOfTapsRequired = 1;
        normalCarViewGesture.numberOfTouchesRequired = 1;
        [_carTypeView.normalCarView addGestureRecognizer:normalCarViewGesture];
        
        UITapGestureRecognizer *offRoadVehicleViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(offRoadVehicleAction:)];
        offRoadVehicleViewGesture.delegate = self;
        offRoadVehicleViewGesture.numberOfTapsRequired = 1;
        offRoadVehicleViewGesture.numberOfTouchesRequired = 1;
        [_carTypeView.offRoadVehicleView addGestureRecognizer:offRoadVehicleViewGesture];
        
        UITapGestureRecognizer *carSUVVehicleViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(carSUVVehicleAction:)];
        carSUVVehicleViewGesture.delegate = self;
        carSUVVehicleViewGesture.numberOfTapsRequired = 1;
        carSUVVehicleViewGesture.numberOfTouchesRequired = 1;
        [_carTypeView.carSUVVehicleView addGestureRecognizer:carSUVVehicleViewGesture];
        
        UITapGestureRecognizer *businessVehicleViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(businessVehicleAction:)];
        businessVehicleViewGesture.delegate = self;
        businessVehicleViewGesture.numberOfTapsRequired = 1;
        businessVehicleViewGesture.numberOfTouchesRequired = 1;
        [_carTypeView.businessVehicleView addGestureRecognizer:businessVehicleViewGesture];
        
        
    }
    
}

- (void)normalCarAction:(UITapGestureRecognizer *)sender
{
    _carTypeView.normalCarLabel.textColor = [UIColor colorFromHexString:@"#ffa437" alpha:1.0];
    _carTypeView.normalCarImageView.image = [UIImage imageNamed:@"icon_selected"];
    _carTypeView.offRoadVehicleLabel.textColor = [UIColor colorFromHexString:@"#ebebeb" alpha:1.0];
    _carTypeView.offRoadVehicleImageView.image = [UIImage imageNamed:@"icon_unSelected"];
    _carTypeView.carSUVVehicleLabel.textColor = [UIColor colorFromHexString:@"#ebebeb" alpha:1.0];
    _carTypeView.carSUVVehicleImageView.image = [UIImage imageNamed:@"icon_unSelected"];
    _carTypeView.businessVehicleLabel.textColor = [UIColor colorFromHexString:@"#ebebeb" alpha:1.0];
    _carTypeView.businessVehicleImageView.image = [UIImage imageNamed:@"icon_unSelected"];
    _selectedCarTypeString = [NSString stringWithFormat:@"轿车"];
    NSLog(@"%@",_selectedCarTypeString);
}

- (void)offRoadVehicleAction:(UITapGestureRecognizer *)sender
{
    _carTypeView.normalCarLabel.textColor = [UIColor colorFromHexString:@"#ebebeb" alpha:1.0];
    _carTypeView.normalCarImageView.image = [UIImage imageNamed:@"icon_unSelected"];
    _carTypeView.offRoadVehicleLabel.textColor = [UIColor colorFromHexString:@"#ffa437" alpha:1.0];
    _carTypeView.offRoadVehicleImageView.image = [UIImage imageNamed:@"icon_selected"];
    _carTypeView.carSUVVehicleLabel.textColor = [UIColor colorFromHexString:@"#ebebeb" alpha:1.0];
    _carTypeView.carSUVVehicleImageView.image = [UIImage imageNamed:@"icon_unSelected"];
    _carTypeView.businessVehicleLabel.textColor = [UIColor colorFromHexString:@"#ebebeb" alpha:1.0];
    _carTypeView.businessVehicleImageView.image = [UIImage imageNamed:@"icon_unSelected"];
    _selectedCarTypeString = [NSString stringWithFormat:@"越野车"];
    NSLog(@"%@",_selectedCarTypeString);
}

- (void)carSUVVehicleAction:(UITapGestureRecognizer *)sender
{
    _carTypeView.normalCarLabel.textColor = [UIColor colorFromHexString:@"#ebebeb" alpha:1.0];
    _carTypeView.normalCarImageView.image = [UIImage imageNamed:@"icon_unSelected"];
    _carTypeView.offRoadVehicleLabel.textColor = [UIColor colorFromHexString:@"#ebebeb" alpha:1.0];
    _carTypeView.offRoadVehicleImageView.image = [UIImage imageNamed:@"icon_unSelected"];
    _carTypeView.carSUVVehicleLabel.textColor = [UIColor colorFromHexString:@"#ffa437" alpha:1.0];
    _carTypeView.carSUVVehicleImageView.image = [UIImage imageNamed:@"icon_selected"];
    _carTypeView.businessVehicleLabel.textColor = [UIColor colorFromHexString:@"#ebebeb" alpha:1.0];
    _carTypeView.businessVehicleImageView.image = [UIImage imageNamed:@"icon_unSelected"];
    _selectedCarTypeString = [NSString stringWithFormat:@"SUV"];
    NSLog(@"%@",_selectedCarTypeString);
}

- (void)businessVehicleAction:(UITapGestureRecognizer *)sender
{
    _carTypeView.normalCarLabel.textColor = [UIColor colorFromHexString:@"#ebebeb" alpha:1.0];
    _carTypeView.normalCarImageView.image = [UIImage imageNamed:@"icon_unSelected"];
    _carTypeView.offRoadVehicleLabel.textColor = [UIColor colorFromHexString:@"#ebebeb" alpha:1.0];
    _carTypeView.offRoadVehicleImageView.image = [UIImage imageNamed:@"icon_unSelected"];
    _carTypeView.carSUVVehicleLabel.textColor = [UIColor colorFromHexString:@"#ebebeb" alpha:1.0];
    _carTypeView.carSUVVehicleImageView.image = [UIImage imageNamed:@"icon_unSelected"];
    _carTypeView.businessVehicleLabel.textColor = [UIColor colorFromHexString:@"#ffa437" alpha:1.0];
    _carTypeView.businessVehicleImageView.image = [UIImage imageNamed:@"icon_selected"];
    _selectedCarTypeString = [NSString stringWithFormat:@"商务车"];
    NSLog(@"%@",_selectedCarTypeString);
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
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(selectCarTypeToCarInfo)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(confirmCarTypeAction)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"选择车型";
    
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
- (void)selectCarTypeToCarInfo
{
    [self.navigationController popViewControllerAnimated:YES];
    if ([self.carTypeDelegate respondsToSelector:@selector(passCarTypeToCarInformationVCWithCarType:)]) {
        [self.carTypeDelegate passCarTypeToCarInformationVCWithCarType:_selectedCarTypeString];
    }
}

- (void)confirmCarTypeAction
{
    NSLog(@"确定...");
    [self.navigationController popViewControllerAnimated:YES];
    if ([self.carTypeDelegate respondsToSelector:@selector(passCarTypeToCarInformationVCWithCarType:)]) {
        [self.carTypeDelegate passCarTypeToCarInformationVCWithCarType:_selectedCarTypeString];
    }
    
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
