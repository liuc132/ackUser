//
//  UserDetailView.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/14.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "UserDetailView.h"
#import "ackUserPCH.pch"
#import "UIColor+HexColor.h"
#import "Masonry.h"

@implementation UserDetailView

- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    UIScrollView *detailScrollView = [UIScrollView new];
    detailScrollView.scrollEnabled = YES;
    detailScrollView.showsVerticalScrollIndicator = YES;
    detailScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:detailScrollView];
    [detailScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *contentView = [UIView new];
    [detailScrollView addSubview:contentView];
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(detailScrollView);
        make.width.equalTo(detailScrollView);
    }];
    
    _avatarView = [UIView new];
    [contentView addSubview:_avatarView];
    /*UITapGestureRecognizer *avatarTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showActionSheetToSettingAvatar:)];
    avatarTapGesture.numberOfTouchesRequired = 1;
    avatarTapGesture.numberOfTapsRequired = 1;
    avatarTapGesture.delegate = self;
    [_avatarView addGestureRecognizer:avatarTapGesture];*/
    
    [_avatarView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(contentView.top);
        make.height.equalTo(@80);
    }];
    
    UILabel *avatarNameLabel = [UILabel new];
    avatarNameLabel.textAlignment = NSTextAlignmentLeft;
    avatarNameLabel.text = @"头像";
    [_avatarView addSubview:avatarNameLabel];
    [avatarNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.left.equalTo(_avatarView.left).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@40);
    }];
    
    _avatarImageView = [UIImageView new];
    _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    _avatarImageView.layer.masksToBounds = YES;
    _avatarImageView.layer.cornerRadius = 35;
    _avatarImageView.image = [UIImage imageNamed:@"detailInformation_avatar"];
    /*[_avatarImageView sd_setImageWithURL:[NSURL URLWithString:[[NSString stringWithFormat:@"%@",_userDetailModel.headImgUrl] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"detailInformation_avatar"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];*/
    
    _avatarImageView.image = [UIImage imageNamed:@"detailInformation_avatar"];
    [_avatarView addSubview:_avatarImageView];
    [_avatarImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(_avatarView.right).offset(-40);
        make.height.equalTo(@70);
        make.width.equalTo(@70);
    }];
    
    UIImageView *avatarRightArrowImageView = [UIImageView new];
    avatarRightArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    avatarRightArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [_avatarView addSubview:avatarRightArrowImageView];
    [avatarRightArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.right.equalTo(_avatarView.right).offset(-10);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    UIView *separetedView0 = [UIView new];
    separetedView0.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView0];
    [separetedView0 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(_avatarView.bottom).offset(4);
        make.height.equalTo(@1);
    }];
    
    _registeredCityLabel = [UILabel new];
    [contentView addSubview:_registeredCityLabel];
    _registeredCityLabel.textAlignment = NSTextAlignmentLeft;
    
    //NSString *regCity = _userDetailModel.regCity;
    NSString *registeredCityString = @"城市";//(regCity.length > 0)?@"城市":@"城市(必填)";
    _registeredCityLabel.text = registeredCityString;
    /*if (regCity.length <= 0) {
        NSMutableAttributedString *registeredCityAttrStr = [[NSMutableAttributedString alloc] initWithString:registeredCityString];
        //setting font
        //    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
        [registeredCityAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(2, 4)];
        [registeredCityAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1.0 green:200/255.0 blue:200/255.0 alpha:1.0] range:NSMakeRange(2, 4)];
        registeredCityLabel.attributedText = registeredCityAttrStr;
    }*/
    [_registeredCityLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView0.bottom).offset(10);
        make.width.equalTo(@150);
        make.height.equalTo(@30);
    }];
    
    _registeredCityTextField = [UITextField new];
    //registeredCityTextField.tag = SelectPickerViewTag;
    //registeredCityTextField.delegate = self;
    _registeredCityTextField.userInteractionEnabled = YES;
    _registeredCityTextField.placeholder = @"请选择";
    _registeredCityTextField.textAlignment = NSTextAlignmentRight;
    [_registeredCityTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _registeredCityTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_registeredCityTextField];
    [_registeredCityTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView0.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    UIImageView *registeredCityArrowImageView = [UIImageView new];
    registeredCityArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    registeredCityArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:registeredCityArrowImageView];
    [registeredCityArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView0.bottom).offset(17);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    UIView *separetedView7 = [UIView new];
    separetedView7.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView7];
    [separetedView7 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(_registeredCityLabel.bottom).offset(4);
        make.height.equalTo(@1);
    }];
    
    _phoneNumberLabel = [UILabel new];
    [contentView addSubview:_phoneNumberLabel];
    _phoneNumberLabel.textAlignment = NSTextAlignmentLeft;
    /*
    NSString *userTel = _userDetailModel.tel;
    NSString *phoneNameString = (userTel.length > 0)?@"手机":@"手机(必填)";
     */
    _phoneNumberLabel.text = @"手机";
    /*
    if (userTel.length <= 0) {
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:phoneNameString];
        //setting font
        //    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(2, 4)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1.0 green:200/255.0 blue:200/255.0 alpha:1.0] range:NSMakeRange(2, 4)];
        phoneNumberLabel.attributedText = attrStr;
    }*/
    [_phoneNumberLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView7.bottom).offset(10);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    _phoneNumInputTextField = [UITextField new];
    //phoneNumInputTextField.delegate = self;
    //phoneNumInputTextField.tag = InPutPhonePickerViewTag;
    _phoneNumInputTextField.userInteractionEnabled = YES;
    _phoneNumInputTextField.placeholder = @"请输入";
    /*if (userTel.length > 0) {
        _phoneNumInputTextField.text = [NSString stringWithFormat:@"%@*****%@",[userTel substringWithRange:NSMakeRange(0, 3)],[userTel substringWithRange:NSMakeRange(8, 3)]];
    }
    */
    _phoneNumInputTextField.textAlignment = NSTextAlignmentRight;
    [_phoneNumInputTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _phoneNumInputTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_phoneNumInputTextField];
    [_phoneNumInputTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView7.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@140);
    }];
    
    UIImageView *phoneNumArrowImageView = [UIImageView new];
    phoneNumArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    phoneNumArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:phoneNumArrowImageView];
    [phoneNumArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView7.bottom).offset(17);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    UIView *separetedView1 = [UIView new];
    separetedView1.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView1];
    [separetedView1 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(_phoneNumberLabel.bottom).offset(4);
        make.height.equalTo(@1);
    }];
    /*
    _verifyCodeLabel = [UILabel new];
    if (!_signInTag) {
        [contentView addSubview:_verifyCodeLabel];
        _verifyCodeLabel.textAlignment = NSTextAlignmentLeft;
        _verifyCodeLabel.text = @"验证码";
        [_verifyCodeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView.left).offset(10);
            make.top.equalTo(separetedView1.bottom).offset(10);
            make.width.equalTo(@80);
            make.height.equalTo(@30);
        }];
    }
    
    _verifyCodeTextField = [UITextField new];
    _verifyCodeTextField.tag = InPutPickerViewTag;
    _verifyCodeTextField.delegate = self;
    _verifyCodeTextField.userInteractionEnabled = YES;
    _verifyCodeTextField.placeholder = @"请输入";
    _verifyCodeTextField.textAlignment = NSTextAlignmentRight;
    [_verifyCodeTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _verifyCodeTextField.borderStyle = UITextBorderStyleNone;
    if (!_signInTag) {
        [contentView addSubview:_verifyCodeTextField];
        [_verifyCodeTextField makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(separetedView1.bottom).offset(10);
            make.left.equalTo(_verifyCodeLabel.right).offset(30);
            make.height.equalTo(@30);
            make.width.equalTo(@80);
        }];
    }
    
    _getVerifyCodeButton = [UIButton new];
    _getVerifyCodeButton.layer.cornerRadius = 4.0;
    _getVerifyCodeButton.layer.masksToBounds = YES;
    _getVerifyCodeButton.layer.borderWidth = 2.0;
    _getVerifyCodeButton.layer.borderColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0].CGColor;
    [_getVerifyCodeButton addTarget:self action:@selector(pressToGetVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    [_getVerifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_getVerifyCodeButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [_getVerifyCodeButton setTitleColor:[UIColor colorFromHexString:@"#767978" alpha:1.0] forState:UIControlStateNormal];
    _getVerifyCodeButton.backgroundColor = [UIColor whiteColor];
    if (!_signInTag) {
        [contentView addSubview:_getVerifyCodeButton];
        [_getVerifyCodeButton makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(contentView.right).offset(-10);
            make.top.equalTo(separetedView1.bottom).offset(10);
            make.height.equalTo(@25);
            make.width.equalTo(@80);
        }];
    }
    
    UIView *separetedView2 = [UIView new];
    separetedView2.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    if (!_signInTag) {
        [contentView addSubview:separetedView2];
        [separetedView2 makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView.left);
            make.right.equalTo(contentView.right);
            make.top.equalTo(_verifyCodeLabel.bottom).offset(4);
            make.height.equalTo(@1);
        }];
    }
    */
    
    _registeredCodeLabel = [UILabel new];
    [contentView addSubview:_registeredCodeLabel];
    _registeredCodeLabel.textAlignment = NSTextAlignmentLeft;
    _registeredCodeLabel.text = @"注册码";//_signInTag?@"所属群":@"注册码";
    [_registeredCodeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView1.bottom).offset(10);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    _registeredCodeTextField = [UITextField new];
    //registeredCodeTextField.tag = InPutPickerViewTag;
    //registeredCodeTextField.delegate = self;
    _registeredCodeTextField.userInteractionEnabled = YES;
    _registeredCodeTextField.placeholder = @"请输入";
    
    _registeredCodeTextField.textAlignment = NSTextAlignmentRight;
    [_registeredCodeTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _registeredCodeTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_registeredCodeTextField];
    [_registeredCodeTextField makeConstraints:^(MASConstraintMaker *make) {
        /*if (!_signInTag) {
            make.top.equalTo(separetedView2.bottom).offset(10);
        }
        else{
            make.top.equalTo(separetedView1.bottom).offset(10);
        }*/
        make.top.equalTo(separetedView1.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    UIView *separetedView3 = [UIView new];
    separetedView3.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView3];
    [separetedView3 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(_registeredCodeLabel.bottom).offset(4);
        make.height.equalTo(@4);
    }];
    
    UILabel *nickNameLabel = [UILabel new];
    [contentView addSubview:nickNameLabel];
    nickNameLabel.textAlignment = NSTextAlignmentLeft;
    nickNameLabel.text = @"昵称";
    [nickNameLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView3.bottom).offset(10);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    
    _nickNameTextField = [UITextField new];
    //nickNameTextField.tag = InPutPickerViewTag;
    //nickNameTextField.delegate = self;
    _nickNameTextField.userInteractionEnabled = YES;
    _nickNameTextField.placeholder = @"请输入";
    _nickNameTextField.textAlignment = NSTextAlignmentRight;
    [_nickNameTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _nickNameTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_nickNameTextField];
    [_nickNameTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView3.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    UIView *separetedView4 = [UIView new];
    separetedView4.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView4];
    [separetedView4 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(nickNameLabel.bottom).offset(4);
        make.height.equalTo(@1);
    }];
    
    _sexLabel = [UILabel new];
    [contentView addSubview:_sexLabel];
    _sexLabel.textAlignment = NSTextAlignmentLeft;
    //NSString *sex = [NSString stringWithFormat:@"%@",_userDetailModel.sex];
    NSString *sexString = @"性别(必填)";//(sex.length > 0)?@"性别":@"性别(必填)";
    _sexLabel.text = sexString;
    /*if (sex.length <= 0) {
        NSMutableAttributedString *sexattrStr = [[NSMutableAttributedString alloc] initWithString:sexString];
        //setting font
        //    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
        [sexattrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(2, 4)];
        [sexattrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1.0 green:200/255.0 blue:200/255.0 alpha:1.0] range:NSMakeRange(2, 4)];
        sexLabel.attributedText = sexattrStr;
    }*/
    [_sexLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView4.bottom).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    _sexTextField = [UITextField new];
    //sexTextField.tag = InPutSexPickerViewTag;
    //sexTextField.delegate = self;
    _sexTextField.userInteractionEnabled = YES;
    _sexTextField.placeholder = @"请选择";
    _sexTextField.textAlignment = NSTextAlignmentRight;
    [_sexTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _sexTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_sexTextField];
    [_sexTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView4.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    /*switch ([sex integerValue]) {
        case 0:
            sexTextField.text = @"未知";
            break;
        case 1:
            sexTextField.text = @"男";
            break;
        case 2:
            sexTextField.text = @"女";
            break;
            
        default:
            break;
    }
    */
    
    UIImageView *sexArrowImageView = [UIImageView new];
    sexArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    sexArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:sexArrowImageView];
    [sexArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView4.bottom).offset(17);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    UIView *separetedView5 = [UIView new];
    separetedView5.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView5];
    [separetedView5 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(_sexLabel.bottom).offset(4);
        make.height.equalTo(@1);
    }];
    
    _birthdayLabel = [UILabel new];
    [contentView addSubview:_birthdayLabel];
    _birthdayLabel.textAlignment = NSTextAlignmentLeft;
    //NSString *birthday = [NSString stringWithFormat:@"%@",_userDetailModel.birthDate];
    NSString *birthdayString = @"出生日期";//(birthday.length > 0)?@"出生日期":@"出生日期(必填)";
    _birthdayLabel.text = birthdayString;
    /*if (birthday.length <= 0) {
        NSMutableAttributedString *birthdayAttrStr = [[NSMutableAttributedString alloc] initWithString:birthdayString];
        //setting font
        //    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
        [birthdayAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(4, 4)];
        [birthdayAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1.0 green:200/255.0 blue:200/255.0 alpha:1.0] range:NSMakeRange(4, 4)];
        birthdayLabel.attributedText = birthdayAttrStr;
    }*/
    [_birthdayLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView5.bottom).offset(10);
        make.width.equalTo(@150);
        make.height.equalTo(@30);
    }];
    
    _birthdayTextField = [UITextField new];
    //birthdayTextField.tag = SelectPickerViewTag;
    //birthdayTextField.delegate = self;
    _birthdayTextField.userInteractionEnabled = YES;
    _birthdayTextField.placeholder = @"请选择";
    _birthdayTextField.textAlignment = NSTextAlignmentRight;
    [_birthdayTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _birthdayTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_birthdayTextField];
    [_birthdayTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView5.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@100);
    }];
    /*if (birthday.length > 0) {
        birthdayTextField.text = birthday;
    }
    */
    
    UIImageView *birthdayArrowImageView = [UIImageView new];
    birthdayArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    birthdayArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:birthdayArrowImageView];
    [birthdayArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView5.bottom).offset(17);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    UIView *separetedView6 = [UIView new];
    separetedView6.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView6];
    [separetedView6 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(_birthdayLabel.bottom).offset(4);
        make.height.equalTo(@1);
    }];
    
    _liveCityLabel = [UILabel new];
    [contentView addSubview:_liveCityLabel];
    _liveCityLabel.textAlignment = NSTextAlignmentLeft;
    //NSString *liveCity = [NSString stringWithFormat:@"%@",_userDetailModel.resiArea];
    NSString *liveCityString = @"居住区域";//(liveCity.length > 0)?@"居住区域":@"居住区域(必填)";
    _liveCityLabel.text = liveCityString;
    /*if (liveCity.length <= 0) {
        NSMutableAttributedString *liveCityAttrStr = [[NSMutableAttributedString alloc] initWithString:liveCityString];
        //setting font
        //    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
        [liveCityAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(4, 4)];
        [liveCityAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1.0 green:200/255.0 blue:200/255.0 alpha:1.0] range:NSMakeRange(4, 4)];
        liveCityLabel.attributedText = liveCityAttrStr;
    }*/
    [_liveCityLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView6.bottom).offset(10);
        make.width.equalTo(@150);
        make.height.equalTo(@30);
    }];
    
    _liveCityTextField = [UITextField new];
    //liveCityTextField.tag = SelectPickerViewTag;
    //liveCityTextField.delegate = self;
    _liveCityTextField.userInteractionEnabled = YES;
    _liveCityTextField.placeholder = @"请选择";
    _liveCityTextField.textAlignment = NSTextAlignmentRight;
    [_liveCityTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _liveCityTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_liveCityTextField];
    [_liveCityTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView6.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    /*if (liveCity.length > 0) {
        liveCityTextField.text = liveCity;
    }*/
    
    UIImageView *liveCityArrowImageView = [UIImageView new];
    liveCityArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    liveCityArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:liveCityArrowImageView];
    [liveCityArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView6.bottom).offset(17);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    UIView *separetedView8 = [UIView new];
    separetedView8.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView8];
    [separetedView8 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(_liveCityLabel.bottom).offset(4);
        make.height.equalTo(@1);
    }];
    
    _workCityLabel = [UILabel new];
    [contentView addSubview:_workCityLabel];
    _workCityLabel.textAlignment = NSTextAlignmentLeft;
    NSString *workCityString = @"工作区域";//(workCity.length > 0)?@"工作区域":@"工作区域(必填)";
    _workCityLabel.text = workCityString;
    
    [_workCityLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView8.bottom).offset(10);
        make.width.equalTo(@150);
        make.height.equalTo(@30);
    }];
    
    _workCityTextField = [UITextField new];
    _workCityTextField.userInteractionEnabled = YES;
    _workCityTextField.placeholder = @"请选择";
    _workCityTextField.textAlignment = NSTextAlignmentRight;
    [_workCityTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _workCityTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_workCityTextField];
    [_workCityTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView8.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    UIImageView *workCityArrowImageView = [UIImageView new];
    workCityArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    workCityArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:workCityArrowImageView];
    [workCityArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView8.bottom).offset(17);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    UIView *separetedView9 = [UIView new];
    separetedView9.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView9];
    [separetedView9 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(_workCityLabel.bottom).offset(4);
        make.height.equalTo(@1);
    }];
    
    _detailAddressLabel = [UILabel new];
    [contentView addSubview:_detailAddressLabel];
    _detailAddressLabel.textAlignment = NSTextAlignmentLeft;
    NSString *detailAddressString = @"通讯地址";
    _detailAddressLabel.text = detailAddressString;
    
    [_detailAddressLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView9.bottom).offset(10);
        make.width.equalTo(@150);
        make.height.equalTo(@30);
    }];
    
    _detailAddressTextField = [UITextField new];
    _detailAddressTextField.userInteractionEnabled = YES;
    _detailAddressTextField.placeholder = @"请填写";
    _detailAddressTextField.textAlignment = NSTextAlignmentRight;
    [_detailAddressTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _detailAddressTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_detailAddressTextField];
    [_detailAddressTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView9.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    UIView *separetedView18 = [UIView new];
    separetedView18.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView18];
    [separetedView18 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(_detailAddressLabel.bottom).offset(4);
        make.height.equalTo(@4);
    }];
    
    UILabel *marriageStatusLabel = [UILabel new];
    [contentView addSubview:marriageStatusLabel];
    marriageStatusLabel.textAlignment = NSTextAlignmentLeft;
    marriageStatusLabel.text = @"婚姻状态";
    [marriageStatusLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView18.bottom).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    _marriageStatusTextField = [UITextField new];
    //marriageStatusTextField.tag = SelectPickerViewTag;
    //marriageStatusTextField.delegate = self;
    _marriageStatusTextField.userInteractionEnabled = YES;
    _marriageStatusTextField.placeholder = @"请选择";
    _marriageStatusTextField.textAlignment = NSTextAlignmentRight;
    [_marriageStatusTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _marriageStatusTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_marriageStatusTextField];
    [_marriageStatusTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView18.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    UIImageView *marriageStatusArrowImageView = [UIImageView new];
    marriageStatusArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    marriageStatusArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:marriageStatusArrowImageView];
    [marriageStatusArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView18.bottom).offset(17);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    UIView *separetedView10 = [UIView new];
    separetedView10.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView10];
    [separetedView10 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(marriageStatusLabel.bottom).offset(4);
        make.height.equalTo(@1);
    }];
    
    UILabel *industryLabel = [UILabel new];
    [contentView addSubview:industryLabel];
    industryLabel.textAlignment = NSTextAlignmentLeft;
    industryLabel.text = @"行业";
    [industryLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView10.bottom).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    _industryTextField = [UITextField new];
    //industryTextField.tag = SelectPickerViewTag;
    //industryTextField.delegate = self;
    _industryTextField.userInteractionEnabled = YES;
    _industryTextField.placeholder = @"请选择";
    _industryTextField.textAlignment = NSTextAlignmentRight;
    [_industryTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _industryTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_industryTextField];
    [_industryTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView10.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@120);
    }];
    /*
    NSString *industry = [NSString stringWithFormat:@"%@",_userDetailModel.industryCd];
    if (industry.length > 0) {
        industryTextField.text = industry;
    }
    */
    
    UIImageView *industryArrowImageView = [UIImageView new];
    industryArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    industryArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:industryArrowImageView];
    [industryArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView10.bottom).offset(17);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    UIView *separetedView11 = [UIView new];
    separetedView11.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView11];
    [separetedView11 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(industryLabel.bottom).offset(4);
        make.height.equalTo(@1);
    }];
    
    UILabel *jobRoleLabel = [UILabel new];
    [contentView addSubview:jobRoleLabel];
    jobRoleLabel.textAlignment = NSTextAlignmentLeft;
    jobRoleLabel.text = @"职业角色";
    [jobRoleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView11.bottom).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    _jobRoleTextField = [UITextField new];
    //jobRoleTextField.tag = SelectPickerViewTag;
    //jobRoleTextField.delegate = self;
    _jobRoleTextField.userInteractionEnabled = YES;
    _jobRoleTextField.placeholder = @"请选择";
    _jobRoleTextField.textAlignment = NSTextAlignmentRight;
    [_jobRoleTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _jobRoleTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_jobRoleTextField];
    [_jobRoleTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView11.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@120);
    }];
    
    UIImageView *jobRoleArrowImageView = [UIImageView new];
    jobRoleArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    jobRoleArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:jobRoleArrowImageView];
    [jobRoleArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView11.bottom).offset(17);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    UIView *separetedView12 = [UIView new];
    separetedView12.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView12];
    [separetedView12 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(jobRoleLabel.bottom).offset(4);
        make.height.equalTo(@1);
    }];
    
    UILabel *monthlyIncomeLabel = [UILabel new];
    [contentView addSubview:monthlyIncomeLabel];
    monthlyIncomeLabel.textAlignment = NSTextAlignmentLeft;
    monthlyIncomeLabel.text = @"年收入";
    [monthlyIncomeLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView12.bottom).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    _monthlyIncomeTextField = [UITextField new];
    //monthlyIncomeTextField.tag = SelectPickerViewTag;
    //monthlyIncomeTextField.delegate = self;
    _monthlyIncomeTextField.userInteractionEnabled = YES;
    _monthlyIncomeTextField.placeholder = @"请选择";
    _monthlyIncomeTextField.textAlignment = NSTextAlignmentRight;
    [_monthlyIncomeTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _monthlyIncomeTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_monthlyIncomeTextField];
    [_monthlyIncomeTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView12.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@120);
    }];
    
    UIImageView *monthlyIncomeArrowImageView = [UIImageView new];
    monthlyIncomeArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    monthlyIncomeArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:monthlyIncomeArrowImageView];
    [monthlyIncomeArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView12.bottom).offset(17);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    UIView *separetedView13 = [UIView new];
    separetedView13.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView13];
    [separetedView13 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(monthlyIncomeLabel.bottom).offset(4);
        make.height.equalTo(@1);
    }];
    
    UILabel *interestLabel = [UILabel new];
    [contentView addSubview:interestLabel];
    interestLabel.textAlignment = NSTextAlignmentLeft;
    interestLabel.text = @"兴趣爱好";
    [interestLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView13.bottom).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    
    _interestTextField = [UITextField new];
    //interestTextField.tag = SelectPickerViewTag;
    //interestTextField.delegate = self;
    _interestTextField.userInteractionEnabled = YES;
    _interestTextField.placeholder = @"请选择";
    _interestTextField.textAlignment = NSTextAlignmentRight;
    [_interestTextField setValue:[UIFont boldSystemFontOfSize:13] forKeyPath:@"_placeholderLabel.font"];
    _interestTextField.borderStyle = UITextBorderStyleNone;
    [contentView addSubview:_interestTextField];
    [_interestTextField makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView13.bottom).offset(10);
        make.right.equalTo(contentView.right).offset(-25);
        make.height.equalTo(@30);
        make.width.equalTo(@80);
    }];
    
    UIImageView *interestArrowImageView = [UIImageView new];
    interestArrowImageView.contentMode = UIViewContentModeScaleAspectFill;
    interestArrowImageView.image = [UIImage imageNamed:@"detailInformation_rightArrow"];
    [contentView addSubview:interestArrowImageView];
    [interestArrowImageView makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separetedView13.bottom).offset(17);
        make.right.equalTo(contentView.right).offset(-10);
        make.height.equalTo(@10);
        make.width.equalTo(@10);
    }];
    
    UIView *separetedView14 = [UIView new];
    separetedView14.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView14];
    [separetedView14 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(interestLabel.bottom).offset(4);
        make.height.equalTo(@4);
    }];
    
    UIImageView *detailWeChatBindImageView = [UIImageView new];
    detailWeChatBindImageView.image = [UIImage imageNamed:@"detailInformation_wechat"];
    detailWeChatBindImageView.contentMode = UIViewContentModeScaleAspectFill;
    [contentView addSubview:detailWeChatBindImageView];
    [detailWeChatBindImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView14.bottom).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    _detailWeChatBindLable = [UILabel new];
    _detailWeChatBindLable.textAlignment = NSTextAlignmentLeft;
    NSString *weChatBindString = @"微信(未绑定)";//通过条件来进行判定
    _detailWeChatBindLable.text = weChatBindString;
    NSMutableAttributedString *weChatBindAttrStr = [[NSMutableAttributedString alloc] initWithString:weChatBindString];
    //setting font
    //    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
    [weChatBindAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(2, 5)];
    [weChatBindAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1.0 green:200/255.0 blue:200/255.0 alpha:1.0] range:NSMakeRange(2, 5)];
    _detailWeChatBindLable.attributedText = weChatBindAttrStr;
    [contentView addSubview:_detailWeChatBindLable];
    [_detailWeChatBindLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(detailWeChatBindImageView.right).offset(10);
        make.top.equalTo(separetedView14.bottom).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@100);
    }];
    
    _detailWeChatBindButton = [UIButton new];
    _detailWeChatBindButton.layer.cornerRadius = 4.0;
    _detailWeChatBindButton.layer.masksToBounds = YES;
    _detailWeChatBindButton.layer.borderWidth = 2.0;
    _detailWeChatBindButton.layer.borderColor = [UIColor colorFromHexString:@"#e6e6e6" alpha:1.0].CGColor;
    [_detailWeChatBindButton setTitle:@"立即绑定" forState:UIControlStateNormal];
    [_detailWeChatBindButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    _detailWeChatBindButton.backgroundColor = [UIColor whiteColor];
    [_detailWeChatBindButton setTitleColor:[UIColor colorFromHexString:@"#767978" alpha:1.0] forState:UIControlStateNormal];
    [contentView addSubview:_detailWeChatBindButton];
    [_detailWeChatBindButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView.right).offset(-10);
        make.top.equalTo(separetedView14.bottom).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@70);
    }];
    
    UIView *separetedView15 = [UIView new];
    separetedView15.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView15];
    [separetedView15 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(detailWeChatBindImageView.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    UIImageView *detailQQBindImageView = [UIImageView new];
    detailQQBindImageView.image = [UIImage imageNamed:@"detailInformation_QQ"];
    detailQQBindImageView.contentMode = UIViewContentModeScaleAspectFill;
    [contentView addSubview:detailQQBindImageView];
    [detailQQBindImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView15.bottom).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    _detailQQBindLable = [UILabel new];
    _detailQQBindLable.textAlignment = NSTextAlignmentLeft;
    NSString *QQBindString = @"QQ(未绑定)";//通过条件来进行判定
    _detailQQBindLable.text = QQBindString;
    NSMutableAttributedString *QQBindAttrStr = [[NSMutableAttributedString alloc] initWithString:QQBindString];
    //setting font
    //    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
    [QQBindAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(2, 5)];
    [QQBindAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1.0 green:200/255.0 blue:200/255.0 alpha:1.0] range:NSMakeRange(2, 5)];
    _detailQQBindLable.attributedText = QQBindAttrStr;
    [contentView addSubview:_detailQQBindLable];
    [_detailQQBindLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(detailWeChatBindImageView.right).offset(10);
        make.top.equalTo(separetedView15.bottom).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@100);
    }];
    
    _detailQQBindButton = [UIButton new];
    _detailQQBindButton.layer.cornerRadius = 4.0;
    _detailQQBindButton.layer.masksToBounds = YES;
    _detailQQBindButton.layer.borderWidth = 2.0;
    _detailQQBindButton.layer.borderColor = [UIColor colorFromHexString:@"#e6e6e6" alpha:1.0].CGColor;
    [_detailQQBindButton setTitle:@"立即绑定" forState:UIControlStateNormal];
    [_detailQQBindButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    _detailQQBindButton.backgroundColor = [UIColor whiteColor];
    [_detailQQBindButton setTitleColor:[UIColor colorFromHexString:@"#767978" alpha:1.0] forState:UIControlStateNormal];
    [contentView addSubview:_detailQQBindButton];
    [_detailQQBindButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView.right).offset(-10);
        make.top.equalTo(separetedView15.bottom).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@70);
    }];
    
    UIView *separetedView16 = [UIView new];
    separetedView16.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView16];
    [separetedView16 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(detailQQBindImageView.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    UIImageView *detailWeboBindImageView = [UIImageView new];
    detailWeboBindImageView.image = [UIImage imageNamed:@"detailInformation_webo"];
    detailWeboBindImageView.contentMode = UIViewContentModeScaleAspectFill;
    [contentView addSubview:detailWeboBindImageView];
    [detailWeboBindImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.top.equalTo(separetedView16.bottom).offset(10);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    _detailWeboBindLable = [UILabel new];
    _detailWeboBindLable.textAlignment = NSTextAlignmentLeft;
    NSString *weboBindString = @"微博(未绑定)";//通过条件来进行判定
    _detailWeboBindLable.text = weboBindString;
    NSMutableAttributedString *weboBindAttrStr = [[NSMutableAttributedString alloc] initWithString:weboBindString];
    //setting font
    //    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
    [weboBindAttrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(2, 5)];
    [weboBindAttrStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1.0 green:200/255.0 blue:200/255.0 alpha:1.0] range:NSMakeRange(2, 5)];
    _detailWeboBindLable.attributedText = weboBindAttrStr;
    
    [contentView addSubview:_detailWeboBindLable];
    [_detailWeboBindLable makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(detailWeboBindImageView.right).offset(10);
        make.top.equalTo(separetedView16.bottom).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@100);
    }];
    
    _detailWeboBindButton = [UIButton new];
    _detailWeboBindButton.layer.cornerRadius = 4.0;
    _detailWeboBindButton.layer.masksToBounds = YES;
    _detailWeboBindButton.layer.borderWidth = 2.0;
    _detailWeboBindButton.layer.borderColor = [UIColor colorFromHexString:@"#e6e6e6" alpha:1.0].CGColor;
    [_detailWeboBindButton setTitle:@"立即绑定" forState:UIControlStateNormal];
    [_detailWeboBindButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    _detailWeboBindButton.backgroundColor = [UIColor whiteColor];
    [_detailWeboBindButton setTitleColor:[UIColor colorFromHexString:@"#767978" alpha:1.0] forState:UIControlStateNormal];
    [contentView addSubview:_detailWeboBindButton];
    [_detailWeboBindButton makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView.right).offset(-10);
        make.top.equalTo(separetedView16.bottom).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@70);
    }];
    
    UIView *separetedView17 = [UIView new];
    separetedView17.backgroundColor = [UIColor colorWithRed:229/255.2 green:229/255.0 blue:229/255.0 alpha:1.0];
    [contentView addSubview:separetedView17];
    [separetedView17 makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left);
        make.right.equalTo(contentView.right);
        make.top.equalTo(detailWeboBindImageView.bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    _detailSaveButton = [UIButton new];
    //[detailSaveButton addTarget:self action:@selector(personalInformationSave:) forControlEvents:UIControlEventTouchUpInside];
    _detailSaveButton.layer.cornerRadius = 4.0;
    _detailSaveButton.layer.masksToBounds = YES;
    [_detailSaveButton setTitle:@"保存" forState:UIControlStateNormal];
    [_detailSaveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _detailSaveButton.backgroundColor = [UIColor colorWithRed:1.0 green:160/255.0 blue:34/255.0 alpha:1.0];
    [contentView addSubview:_detailSaveButton];
    [_detailSaveButton makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView.left).offset(10);
        make.right.equalTo(contentView.right).offset(-10);
        make.top.equalTo(separetedView17.bottom).offset(10);
        make.height.equalTo(@44);
    }];
    
    [detailScrollView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_detailSaveButton.bottom).offset(10);
    }];
    
    return self;
}

@end
