//
//  CarInformationViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/11/23.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "CarInformationViewController.h"
#import "ackUserPCH.pch"
#import "AddCarInformationView.h"
#import "CarInformationView.h"
#import "CarTypeViewController.h"
#import "CarBrandViewController.h"
#import "RetakePhotoView.h"
#import "SignInViewController.h"
#import "HTTPRequest.h"
#import "UIColor+HexColor.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "SVProgressHUD.h"

#define carTypeTextFieldTag         100
#define carBrandTextFieldTag        101

@interface CarInformationViewController ()<UITextFieldDelegate, CarTypeViewControllerDelegate, CarBrandViewControllerDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImageView                       *navigationImageView;
@property (strong, nonatomic) AddCarInformationView             *addCarInfomationView;
@property (strong, nonatomic) CarInformationView                *checkCarInfomationView;
@property (strong, nonatomic) RetakePhotoView                   *retakePhotoView;
@property (assign, nonatomic) NSInteger                         currentSelectImageViewTag;
@property (strong, nonatomic) UIImageView                       *currentImageView;
@property (strong, nonatomic) UIImage                           *drivingLicenseImage;
@property (strong, nonatomic) UIImage                           *carBodyFrontImage;

@property (strong, nonatomic) HTTPRequest                       *httpRequest;

@property (strong, nonatomic) NSString                          *imageDrivingLicenseURLString;
@property (strong, nonatomic) NSString                          *imageCarFrontURLString;

@end

@implementation CarInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    [self settingNetwork];
    [self customCarInformationView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    [self settingNavBar];
    
}



#pragma mark -privateMethod

- (void)settingNetwork
{
    _httpRequest = [HTTPRequest sharedManager];
    
}

- (void)customCarInformationView
{
    if (_retakePhotoView == nil) {
        _retakePhotoView = [[RetakePhotoView alloc] init];
        [_retakePhotoView dismissRetakePhotoView];
        [self.navigationController.view addSubview:_retakePhotoView];
        [_retakePhotoView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        UITapGestureRecognizer *retakeDismissGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissRetakeViewAction:)];
        retakeDismissGesture.delegate = self;
        retakeDismissGesture.numberOfTapsRequired = 1;
        retakeDismissGesture.numberOfTouchesRequired = 1;
        [_retakePhotoView addGestureRecognizer:retakeDismissGesture];
        
        [_retakePhotoView.retakeButton addTarget:self action:@selector(retakePhotoAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    if (_carInfoReviewType) {
        _addCarInfomationView = [[AddCarInformationView alloc] init];
        [self.view addSubview:_addCarInfomationView];
        [_addCarInfomationView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        _addCarInfomationView.addCarTypeField.tag = carTypeTextFieldTag;
        _addCarInfomationView.addCarTypeField.delegate = self;
        _addCarInfomationView.addCarBrandField.tag = carBrandTextFieldTag;
        _addCarInfomationView.addCarBrandField.delegate = self;
        
        UITapGestureRecognizer *dismissGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissActionKeyBoard)];
        dismissGesture.delegate = self;
        dismissGesture.numberOfTapsRequired = 1;
        dismissGesture.numberOfTouchesRequired = 1;
        [_addCarInfomationView addGestureRecognizer:dismissGesture];
        
        UITapGestureRecognizer *carDrivingLicenseGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(carDrivingLicenseAction:)];
        carDrivingLicenseGesture.delegate = self;
        carDrivingLicenseGesture.numberOfTapsRequired = 1;
        carDrivingLicenseGesture.numberOfTouchesRequired = 1;
        [_addCarInfomationView.addCardrivingLicenseCameraImageView addGestureRecognizer:carDrivingLicenseGesture];
        _addCarInfomationView.addCardrivingLicenseCameraImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *carbodyFrontGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(carbodyFrontAction:)];
        carbodyFrontGesture.delegate = self;
        carbodyFrontGesture.numberOfTapsRequired = 1;
        carbodyFrontGesture.numberOfTouchesRequired = 1;
        [_addCarInfomationView.addCarbodyFrontCameraImageView addGestureRecognizer:carbodyFrontGesture];
        _addCarInfomationView.addCarbodyFrontCameraImageView.userInteractionEnabled = YES;
        
        [_addCarInfomationView.addCarInfoSaveButton addTarget:self action:@selector(upLoadNewCarInformationAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _addCarInfomationView.addCarOwnerTextField.text = [NSString stringWithFormat:@"%@",_carInfoDetail.name];
        
    }
    else
    {
        _checkCarInfomationView = [[CarInformationView alloc] init];
        [self.view addSubview:_checkCarInfomationView];
        [_checkCarInfomationView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        _checkCarInfomationView.carTypeField.tag = carTypeTextFieldTag;
        _checkCarInfomationView.carTypeField.delegate = self;
        _checkCarInfomationView.carBrandField.tag = carBrandTextFieldTag;
        _checkCarInfomationView.carBrandField.delegate = self;
        
        UITapGestureRecognizer *dismissGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissActionKeyBoard)];
        dismissGesture.delegate = self;
        dismissGesture.numberOfTapsRequired = 1;
        dismissGesture.numberOfTouchesRequired = 1;
        [_checkCarInfomationView addGestureRecognizer:dismissGesture];
        
        UITapGestureRecognizer *carDrivingLicenseGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(carDrivingLicenseAction:)];
        carDrivingLicenseGesture.delegate = self;
        carDrivingLicenseGesture.numberOfTapsRequired = 1;
        carDrivingLicenseGesture.numberOfTouchesRequired = 1;
        [_checkCarInfomationView.drivingLicenseCameraImageView addGestureRecognizer:carDrivingLicenseGesture];
        _checkCarInfomationView.drivingLicenseCameraImageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *carbodyFrontGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(carbodyFrontAction:)];
        carbodyFrontGesture.delegate = self;
        carbodyFrontGesture.numberOfTapsRequired = 1;
        carbodyFrontGesture.numberOfTouchesRequired = 1;
        [_checkCarInfomationView.bodyFrontCameraImageView addGestureRecognizer:carbodyFrontGesture];
        _checkCarInfomationView.bodyFrontCameraImageView.userInteractionEnabled = YES;
        
        _checkCarInfomationView.carOwnerTextField.text = [NSString stringWithFormat:@"%@",_carInfoDetail.name];
        _checkCarInfomationView.carPlateTextField.text = [NSString stringWithFormat:@"%@",_carInfoDetail.plate];
        
        //状态还没加判断0:待审核 1:审核通过 2:审核不通过3:待完善 9:已注销
        NSString *status = [NSString stringWithFormat:@"%@",_carInfoDetail.status];
        NSString *statusString;
        switch ([status integerValue]) {
            case 0:
                statusString = @"待审核";
                _checkCarInfomationView.carStatusLabel.backgroundColor = [UIColor colorFromHexString:@"#ffa022" alpha:1.0];
                break;
                
            case 1:
                statusString = @"审核通过";
                _checkCarInfomationView.carStatusLabel.backgroundColor = [UIColor colorFromHexString:@"#7aaa3d" alpha:1.0];
                break;
                
            case 2:
                statusString = @"审核不通过";
                _checkCarInfomationView.carStatusLabel.backgroundColor = [UIColor colorFromHexString:@"#f9503b" alpha:1.0];
                break;
                
            case 3:
                statusString = @"待完善";
                _checkCarInfomationView.carStatusLabel.backgroundColor = [UIColor colorFromHexString:@"#516192" alpha:1.0];
                break;
                
            case 9:
                statusString = @"已注销";
                _checkCarInfomationView.carStatusLabel.backgroundColor = [UIColor colorFromHexString:@"#7d8182" alpha:1.0];
                break;
                
            default:
                break;
        }
        
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14],};
        CGSize textSize = [statusString boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
        _checkCarInfomationView.carStatusLabel.text = statusString;
        [_checkCarInfomationView.carStatusLabel updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(textSize.width+15));
        }];
        
        _checkCarInfomationView.carStatusLabel.text = [NSString stringWithFormat:@"%@",statusString];
        _checkCarInfomationView.carTypeField.text = [NSString stringWithFormat:@"%@",_carInfoDetail.typeName];
        _checkCarInfomationView.carBrandField.text = [NSString stringWithFormat:@"%@",_carInfoDetail.brand];
        _checkCarInfomationView.priceRangeTextField.text = [NSString stringWithFormat:@"%@",_carInfoDetail.priceName];
        _checkCarInfomationView.carColorTextField.text = [NSString stringWithFormat:@"%@",_carInfoDetail.colorName];
        _checkCarInfomationView.certificateIssueDateTextField.text = [NSString stringWithFormat:@"%@",_carInfoDetail.issuetime];
        _checkCarInfomationView.latestInspectionDateTextField.text = [NSString stringWithFormat:@"%@",_carInfoDetail.latetime];
        [_checkCarInfomationView.drivingLicenseCameraImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",_carInfoDetail.travelpic] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"icon_camera_gray"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                _checkCarInfomationView.drivingLicenseCameraImageView.image = image;
            }
        }];
        [_checkCarInfomationView.bodyFrontCameraImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",_carInfoDetail.positivepic] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"icon_camera_gray"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            if (image) {
                _checkCarInfomationView.bodyFrontCameraImageView.image = image;
            }
        }];
        
    }
    
    
    
    
}

- (void)dismissActionKeyBoard
{
    [self.view endEditing:YES];
}

/**
 上传新的车辆信息到服务器

 @param sender sender 提交button
 */
- (void)upLoadNewCarInformationAction:(UIButton *)sender
{
    if (_imageCarFrontURLString.length <= 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"未上传车身图片,请上传!" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancle");
            
        }]];
        
        [self presentViewController:alertController animated:YES completion: nil];
        
        return;
    }
    if (_imageDrivingLicenseURLString <= 0) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"未上传行驶证图片,请上传!" preferredStyle:UIAlertControllerStyleAlert];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"cancle");
            
        }]];
        
        [self presentViewController:alertController animated:YES completion: nil];
        
        return;
    }
    
    NSDictionary *newCarPrameters = @{@"brand":[NSString stringWithFormat:@"%@",_addCarInfomationView.addCarBrandField.text],@"brandImgUrl":@"232",@"colorCd":@"2",@"colorName":[NSString stringWithFormat:@"%@",_addCarInfomationView.addCarColorTextField.text],@"creTime":@"2016-12-05T02:28:19.002Z",@"id":@"0",@"isreport":@"0",@"issuetime":[NSString stringWithFormat:@"%@",_addCarInfomationView.addCarcertificateIssueDateTextField.text],@"lastUpdateTime":[NSString stringWithFormat:@"%@",_addCarInfomationView.addCarlatestInspectionDateTextField.text],@"latetime":@"2016-12-15",@"name":[NSString stringWithFormat:@"%@",_addCarInfomationView.addCarOwnerTextField.text],@"ownerId":@"0",@"plate":[NSString stringWithFormat:@"%@",_addCarInfomationView.addCarPlateTextField.text],@"positivepic":_imageCarFrontURLString,@"priceCd":@"2",@"priceName":[NSString stringWithFormat:@"%@",_addCarInfomationView.addCarpriceRangeTextField.text],@"series":@"de",@"status":@"0",@"travelpic":_imageDrivingLicenseURLString,@"typeCd":@"2",@"typeName":[NSString stringWithFormat:@"%@",_addCarInfomationView.addCarTypeField.text],@"ventripic":@"ventripic"};
    [_httpRequest upLoadNewCarInformationWithParemeter:newCarPrameters complete:^(id finish) {
        NSLog(@"%@",finish);
        if (finish[@"code"]) {
            [SVProgressHUD showInfoWithStatus:finish[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
        
    } error:^(id reqError) {
        NSError *backError = (NSError *)reqError;
        NSLog(@"%@",backError.localizedDescription);
        
        
    }];
    
}

- (void)retakePhotoAction:(UIButton *)sender
{
    __weak typeof(self) weakSelf = self;
    [_retakePhotoView dismissRetakePhotoView];
    dispatch_async(dispatch_get_main_queue(), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf startCameraOrAlumn];
    });
    
}

- (void)dismissRetakeViewAction:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded) {
        [_retakePhotoView dismissRetakePhotoView];
    }
    
}

- (void)carbodyFrontAction:(UITapGestureRecognizer *)sender
{
    NSLog(@"车身前照...");UIImageView *imageView = (UIImageView *)sender.view;
    [self decideCurrentImageViewWithTag:imageView.tag];
    
    if (_carBodyFrontImage) {
        _retakePhotoView.oldPhotoImageView.image = _carBodyFrontImage;
        [_retakePhotoView showRetakePhotoView];
        
        return;
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self startCameraOrAlumn];
        
    }
    
    
    
}

- (void)carDrivingLicenseAction:(UITapGestureRecognizer *)sender
{
    NSLog(@"行驶证...");
    UIImageView *imageView = (UIImageView *)sender.view;
    [self decideCurrentImageViewWithTag:imageView.tag];
    
    if (_drivingLicenseImage) {
        _retakePhotoView.oldPhotoImageView.image = _drivingLicenseImage;
        [_retakePhotoView showRetakePhotoView];
        
        return;
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        [self startCameraOrAlumn];
        
    }
    
    
}

- (void)decideCurrentImageViewWithTag:(NSInteger)tag
{
    if (tag == CarInformationCarBodyFrontImageViewTag) {
        _currentImageView = _checkCarInfomationView.bodyFrontCameraImageView;
    }
    else if (tag == CarInformationDrivingLicenseImageViewTag)
    {
        _currentImageView = _checkCarInfomationView.drivingLicenseCameraImageView;
    }
    else if (tag == AddCarInformationCarBodyFrontImageViewTag)
    {
        _currentImageView = _addCarInfomationView.addCarbodyFrontCameraImageView;
    }
    else if (tag == AddCarInformationDrivingLicenseImageViewTag)
    {
        _currentImageView = _addCarInfomationView.addCardrivingLicenseCameraImageView;
    }
    
}

- (void)startCameraOrAlumn
{
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
    
    if (!_carInfoReviewType) {
        UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithTitle:@"申请注销" style:UIBarButtonItemStyleDone target:self action:@selector(logOffAction)];
        self.navigationItem.rightBarButtonItem = rightBarButton;
    }
    
    self.navigationItem.title = _carInfoReviewType?@"添加车辆":[NSString stringWithFormat:@"%@",_carInfoDetail.plate];
    
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

- (void)logOffAction
{
    __weak typeof(self) weakSelf = self;
    NSLog(@"注销车辆...");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定注销车辆?" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
        
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"确定");
        NSString *carID = [NSString stringWithFormat:@"%@",strongSelf.carInfoDetail.iD];
        
        [strongSelf.httpRequest deleteCarInformationWithParameter:carID complete:^(id finish) {
            NSLog(@"%@",finish);
            
            
        } failure:^(NSError *reqError) {
            NSLog(@"error:%@",reqError.localizedDescription);
            
            
        }];
        
        
    }]];
    
    [self presentViewController:alertController animated:YES completion: nil];
    
}

#pragma mark -UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.view endEditing:YES];
    
    if (textField.tag == carTypeTextFieldTag) {
        [self performSegueWithIdentifier:@"carInfoToCarType" sender:nil];
        
    }
    else if (textField.tag == carBrandTextFieldTag)
    {
        [self performSegueWithIdentifier:@"carInfoToCarBrand" sender:nil];
        
    }
    
    
    
}

#pragma mark -UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    __weak typeof(self) weakSelf = self;
    NSInteger imageIdex = 0;
    UIImage *respondImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (respondImage) {
        _currentImageView.contentMode = UIViewContentModeScaleAspectFill;
        if (_currentImageView.tag == AddCarInformationDrivingLicenseImageViewTag || _currentImageView.tag == CarInformationDrivingLicenseImageViewTag) {
            _drivingLicenseImage = respondImage;
            imageIdex = 0;
        }
        else if(_currentImageView.tag == AddCarInformationCarBodyFrontImageViewTag || _currentImageView.tag == CarInformationCarBodyFrontImageViewTag)
        {
            _carBodyFrontImage = respondImage;
            imageIdex = 1;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.currentImageView.image = respondImage;
            
            [picker dismissViewControllerAnimated:YES completion:NULL];
        });
        
        [_httpRequest uploadImageToServerWithImage:respondImage andIndex:imageIdex complete:^(id finish) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            NSLog(@"%@",finish);
            if ([finish[@"code"] integerValue] == TokenExpired) {
                
                
                return ;
            }
            else if ([finish[@"code"] integerValue] == RequestSuccess)
            {
                NSArray *imageUrlArray = finish[@"rows"];
                NSDictionary *imageInfoDic = (NSDictionary *)imageUrlArray[0];
                
                switch (imageIdex) {
                    case 0:
                        strongSelf.imageDrivingLicenseURLString = imageInfoDic[@"attachUrl"];
                        break;
                    case 1:
                        strongSelf.imageCarFrontURLString = imageInfoDic[@"attachUrl"];
                        break;
                        
                    default:
                        break;
                }
            }
            
        } error:^(id reqError) {
            NSError *backError = (NSError *)reqError;
            NSLog(@"error:%@",backError.localizedDescription);
            
            
        }];
        
        
    }
    
}

#pragma mark -carTypeViewDelegate
- (void)passCarTypeToCarInformationVCWithCarType:(NSString *)carType
{
    NSLog(@"carType:%@",carType);
    _addCarInfomationView.addCarTypeField.text = carType;
}

#pragma mark -carBrandViewDelegate
- (void)passCarBrandToCarInformationVCWithCarBrand:(NSString *)carBrand
{
    _addCarInfomationView.addCarBrandField.text = carBrand;
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
    CarTypeViewController *carTypeVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"carInfoToCarType"]) {
        carTypeVC.carTypeDelegate = self;
    }
    
    CarBrandViewController *carBrandVC = segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"carInfoToCarBrand"]) {
        carBrandVC.carBrandDelegate = self;
    }
    
}


@end
