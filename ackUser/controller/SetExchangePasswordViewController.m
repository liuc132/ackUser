//
//  SetExchangePasswordViewController.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/20.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "SetExchangePasswordViewController.h"
#import "ackUserPCH.pch"
#import "SetExchangePWView.h"
#import "SecurityQuestionModel.h"
#import "securityQuestionAnswerModel.h"
#import "UIView+LQXkeyboard.h"
#import "NormalPickerView.h"
#import "HTTPRequest.h"
#import "Masonry.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface SetExchangePasswordViewController ()<UIGestureRecognizerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) SetExchangePWView             *exchangePasswordView;
@property (strong, nonatomic) NormalPickerView              *questionPickerView;

@property (strong, nonatomic) HTTPRequest                   *securityQuestionSessionManager;
@property (strong, nonatomic) NSMutableArray                *securityQuestionsArray;

@property (strong, nonatomic) UILabel                       *currentSelectLabel;
@property (strong, nonatomic) SecurityQuestionModel         *currentSelectQuestionModel;


@end

@implementation SetExchangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self customCreateExchangePasswordView];
    
    [self networkInitialization];
    [self dataInitialization];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self settingNavBar];
    
}


#pragma mark customMethod

- (void)networkInitialization
{
    _securityQuestionSessionManager = [HTTPRequest sharedManager];
}

- (void)dataInitialization
{
    __weak typeof(self) weakSelf = self;
    
    _securityQuestionsArray = [[NSMutableArray alloc] init];
    [SVProgressHUD show];
    [_securityQuestionSessionManager getSecurityQuestionSuccess:^(id finish) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if ([finish[@"code"] integerValue] == TokenExpired) {
            NSLog(@"请重新登录");
            
        }
        else if ([finish[@"code"] integerValue] == RequestSuccess)
        {
            NSArray *resultArray = (NSArray *)finish[@"rows"];
            [strongSelf filerSecurityQuestionWithResult:resultArray];
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSError *reqError) {
        NSLog(@"error:%@",reqError.localizedDescription);
        
    }];
}

- (void)filerSecurityQuestionWithResult:(NSArray *)resultArray
{
    for (NSDictionary *eachQuestion in resultArray) {
        SecurityQuestionModel *eachQuestionModel = [[SecurityQuestionModel alloc] init];
        NSString *questionId = eachQuestion[@"id"];
        if ([questionId isEqual:[NSNull null]]) {
            eachQuestionModel.questionId = @"";
        }
        else
        {
            eachQuestionModel.questionId = questionId;
        }
        NSString *parentId = eachQuestion[@"parentId"];
        if ([parentId isEqual:[NSNull null]]) {
            eachQuestionModel.parentId = @"";
        }
        else
        {
            eachQuestionModel.parentId = parentId;
        }
        NSString *key = eachQuestion[@"key"];
        if ([key isEqual:[NSNull null]]) {
            eachQuestionModel.key = @"";
        }
        else
        {
            eachQuestionModel.key = key;
        }
        NSString *value = eachQuestion[@"value"];
        if ([value isEqual:[NSNull null]]) {
            eachQuestionModel.value = @"";
        }
        else
        {
            eachQuestionModel.value = value;
        }
        NSString *type = eachQuestion[@"type"];
        if ([type isEqual:[NSNull null]]) {
            eachQuestionModel.type = @"";
        }
        else
        {
            eachQuestionModel.type = type;
        }
        NSString *status = eachQuestion[@"status"];
        if ([status isEqual:[NSNull null]]) {
            eachQuestionModel.status = @"";
        }
        else
        {
            eachQuestionModel.status = status;
        }
        NSString *sortNo = eachQuestion[@"sortNo"];
        if ([sortNo isEqual:[NSNull null]]) {
            eachQuestionModel.sortNo = @"";
        }
        else
        {
            eachQuestionModel.sortNo = sortNo;
        }
        NSString *questionDescription = eachQuestion[@"description"];
        if ([questionDescription isEqual:[NSNull null]]) {
            eachQuestionModel.questionDescription = @"";
        }
        else
        {
            eachQuestionModel.questionDescription = questionDescription;
        }
        NSString *createTime = eachQuestion[@"createTime"];
        if ([createTime isEqual:[NSNull null]]) {
            eachQuestionModel.createTime = @"";
        }
        else
        {
            eachQuestionModel.createTime = createTime;
        }
        NSDictionary *subList = eachQuestion[@"subList"];
        if ([subList isEqual:[NSNull null]]) {
            eachQuestionModel.subList = @{};
        }
        else
        {
            eachQuestionModel.subList = subList;
        }
        
        [_securityQuestionsArray addObject:eachQuestionModel];
    }
    
    _currentSelectQuestionModel = (SecurityQuestionModel *)_securityQuestionsArray[0];
    [self customCreateExchangePasswordView];
    
}

- (void)customCreateExchangePasswordView
{
    if (_exchangePasswordView == nil) {
        _exchangePasswordView = [[SetExchangePWView alloc] init];
        [self.view addSubview:_exchangePasswordView];
        [_exchangePasswordView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        
        _exchangePasswordView.firstSecretQuestionLabel.userInteractionEnabled = YES;
        _exchangePasswordView.secondSecretQuestionLabel.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *firstQuestionGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(firstQuestionAction)];
        firstQuestionGesture.delegate = self;
        firstQuestionGesture.numberOfTapsRequired = 1;
        firstQuestionGesture.numberOfTouchesRequired = 1;
        [_exchangePasswordView.firstSecretQuestionContentView addGestureRecognizer:firstQuestionGesture];
        
        UITapGestureRecognizer *secondQuestionGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(secondQuestionAction)];
        secondQuestionGesture.delegate = self;
        secondQuestionGesture.numberOfTapsRequired = 1;
        secondQuestionGesture.numberOfTouchesRequired = 1;
        [_exchangePasswordView.secondSecretQuestionContentView addGestureRecognizer:secondQuestionGesture];
        
    }
    
    if (_questionPickerView == nil) {
        _questionPickerView = [[NormalPickerView alloc] init];
        _questionPickerView.normalPickerView.delegate = self;
        _questionPickerView.normalPickerView.dataSource = self;
        [self.view addSubview:_questionPickerView];
        [_questionPickerView makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.bottom);
            make.left.equalTo(self.view.left);
            make.right.equalTo(self.view.right);
            make.height.equalTo(@200);
        }];
        [_questionPickerView.normalPickerCancleButton addTarget:self action:@selector(normalPickerCancle) forControlEvents:UIControlEventTouchUpInside];
        [_questionPickerView.normalPickerConfirmButton addTarget:self action:@selector(normalPickerConfirm) forControlEvents:UIControlEventTouchUpInside];
        [_questionPickerView setHidden:YES];
    }
    
    UITapGestureRecognizer *tapDismissGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDismissAction)];
    tapDismissGesture.delegate = self;
    tapDismissGesture.numberOfTapsRequired = 1;
    tapDismissGesture.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tapDismissGesture];
    
}

- (void)firstQuestionAction
{
    _currentSelectLabel = _exchangePasswordView.firstSecretQuestionLabel;
    [self showingCusNormalPicker];
}

- (void)secondQuestionAction
{
    _currentSelectLabel = _exchangePasswordView.secondSecretQuestionLabel;
    [self showingCusNormalPicker];
}

- (void)normalPickerConfirm
{
    _currentSelectLabel.text = [NSString stringWithFormat:@"%@",_currentSelectQuestionModel.value];
    
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
        [_questionPickerView setHidden:YES];
        [weakSelf.view sendSubviewToBack:_questionPickerView];
        
    });
}

- (void)showingCusNormalPicker
{
    __unsafe_unretained typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.view endEditing:YES];
        [_questionPickerView setHidden:NO];
        [weakSelf.view bringSubviewToFront:_questionPickerView];
    });
}

- (void)tapDismissAction
{
    [self.view endEditing:YES];
}

/**
 导航栏设置
 */
- (void)settingNavBar
{
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"myApplication_back"] style:UIBarButtonItemStylePlain target:self action:@selector(setExchangeToActiveVC)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    
    self.navigationItem.title = @"交易密码设置";
    
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
- (void)setExchangeToActiveVC
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 监听方法
#pragma mark Responding to keyboard events
- (void)keyboardWillShow:(NSNotification *)notification {
    __weak typeof(self) weakSelf = self;
    /*
     Reduce the size of the text view so that it's not obscured by the keyboard.
     Animate the resize so that it's in sync with the appearance of the keyboard.
     */
    NSDictionary *userInfo = [notification userInfo];
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    // Get the top of the keyboard as the y coordinate of its origin in self's view's coordinate system. The bottom of the text view's frame should align with the top of the keyboard's final position.
    CGRect keyboardRect = [aValue CGRectValue];
    // Get the duration of the animation.
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    // Animate the resize of the text view's frame in sync with the keyboard's appearance.
    UIView *fatherView;
    if ([self.exchangePasswordView.passwordTextField isFirstResponder]) {
        fatherView = self.exchangePasswordView.passwordTextField;
    }
    else if ([self.exchangePasswordView.confirmPasswordTextField isFirstResponder])
    {
        fatherView = self.exchangePasswordView.confirmPasswordTextField;
    }
    else if ([self.exchangePasswordView.firstSecretQuestionTextField isFirstResponder])
    {
        fatherView = self.exchangePasswordView.firstSecretQuestionTextField;
    }
    else if ([self.exchangePasswordView.secondSecretQuestionTextField isFirstResponder])
    {
        fatherView = self.exchangePasswordView.secondSecretQuestionTextField;
    }
    
    CGFloat firstresViewHeight = fatherView.frame.origin.y + fatherView.frame.size.height + 100;
    CGFloat keyBoardTopYPosition = keyboardRect.origin.y;
    
    CGFloat moveYlength = keyBoardTopYPosition - firstresViewHeight;
    
    if (moveYlength >= 0) {
        [UIView animateWithDuration:0.4 animations:^{
            weakSelf.exchangePasswordView.transform = CGAffineTransformIdentity;
        }];
        return;
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        CGAffineTransform transform = CGAffineTransformMakeTranslation(0.0, moveYlength);
        
        weakSelf.exchangePasswordView.transform = transform;
        
    }];
    
    
}
- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary* userInfo = [notification userInfo];
    /*
     Restore the size of the text view (fill self's view).
     Animate the resize so that it's in sync with the disappearance of the keyboard.
     */
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    //    [self moveInputBarWithKeyboardHeight:0.0 withDuration:animationDuration];
    
    [UIView animateWithDuration:0.4 animations:^{
        self.view.transform = CGAffineTransformIdentity;
        
    }];
    
}

#pragma mark -UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    SecurityQuestionModel *currentRowQuestionModel = [[SecurityQuestionModel alloc] init];
    currentRowQuestionModel = (SecurityQuestionModel *)_securityQuestionsArray[row];
    return [NSString stringWithFormat:@"%@",currentRowQuestionModel.value];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _securityQuestionsArray.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _currentSelectQuestionModel = (SecurityQuestionModel *)_securityQuestionsArray[row];
    
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
