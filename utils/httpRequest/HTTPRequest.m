//
//  HTTPRequest.m
//  ackUser
//
//  Created by 爱车客研发部 on 2016/12/5.
//  Copyright © 2016年 爱车客研发部. All rights reserved.
//

#import "HTTPRequest.h"
#import "ackUserPCH.pch"
#import "CarInformationModel.h"
#import "AFNetworking.h"
#import "AFURLSessionManager.h"
#import "SVProgressHUD.h"

#define WeakSelf    __weak typeof(self) weakSelf = self

@interface HTTPRequest ()

@property (strong, nonatomic) AFHTTPSessionManager              *httpSessionManager;
@property (strong, nonatomic) AFURLSessionManager               *httpPostSessionManager;
@property (strong, nonatomic) AFNetworkReachabilityManager      *httpSessionReachabilityManager;

@end


@implementation HTTPRequest

+ (instancetype)sharedManager
{
    static HTTPRequest *httpRequestManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpRequestManager = [[HTTPRequest alloc] init];
        [httpRequestManager networkInitialization];
        
    });
    
    return httpRequestManager;
}

- (void)networkInitialization
{
    //增加这几行代码；
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    _httpSessionManager = [AFHTTPSessionManager manager];
    [_httpSessionManager setSecurityPolicy:securityPolicy];
    [self setSessionHeaderField];
    _httpSessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"text/javascript",@"application/json", nil];
    
    _httpSessionReachabilityManager = [AFNetworkReachabilityManager manager];
    [_httpSessionReachabilityManager startMonitoring];
    
    //json post manager initialization
    _httpPostSessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    AFHTTPResponseSerializer *cusResponseSerializer = [[AFHTTPResponseSerializer alloc] init];
    cusResponseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"text/javascript",@"application/json", nil];
    _httpPostSessionManager.responseSerializer = cusResponseSerializer;
    
}

/**
 设置会话headerField
 */
- (void)setSessionHeaderField
{
    [self clearSessionHeaderFieldAuthorization];
    [_httpSessionManager.requestSerializer setValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"userToken"] forHTTPHeaderField:@"Authorization"];
//    [_httpSessionManager.requestSerializer setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
}

/**
 清除认证headerField
 */
- (void)clearSessionHeaderFieldAuthorization
{
    [_httpSessionManager.requestSerializer clearAuthorizationHeader];
}

- (void)getHeaderFieldWithTask:(NSURLSessionDataTask *)task
{
    if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
        NSDictionary *headerFieldsDictionary = [r allHeaderFields];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults removeObjectForKey:@"userToken"];
        [defaults setObject:[NSString stringWithFormat:@"%@",headerFieldsDictionary[@"Authorization"]] forKey:@"userToken"];
        [defaults synchronize];
        
    }
    
}

- (NSMutableURLRequest *)customRequestMethod:(NSString *)method URLString:(NSString *)url data:(NSData *)data
{
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:method URLString:url parameters:nil error:nil];
    req.timeoutInterval= 60.0;
    [req setValue:@"application/json;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json;text/plain" forHTTPHeaderField:@"Accept"];
    NSLog(@"Token:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userToken"]);
    NSString *userToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"userToken"];
    NSArray *userTokens = [userToken componentsSeparatedByString:@","];
    
    [req setValue:userTokens[0] forHTTPHeaderField:@"Authorization"];
    [req setHTTPBody:data];
    return req;
}

////////////////////////////接口//////////////////////////////////////

/**
 获取我的所有车辆的信息

 @param finish finish 请求成功之后的返回结果
 @param reqError reqError 请求失败之后的返回结果
 */
- (void)getAllCarsListsSuccess:(completeRequest)finish failure:(completeError)reqError
{
    WeakSelf;
//    [self setHeaderFieldForm];
    NSLog(@"userToken====%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userToken"]);
    
    [_httpSessionManager GET:MyCarURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        finish(responseObject);
        [strongSelf getHeaderFieldWithTask:task];
        
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return;
        }
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        reqError(error);
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    }];
    
    
}


/**
 添加车辆信息到服务器
 
 @param parameter parameter 上传的车辆信息参数
 @param finish finish 请求成功之后的返回
 @param reqError reqError 请求失败返回结果
 */
- (void)upLoadNewCarInformationWithParemeter:(NSDictionary *)parameter complete:(completeRequest)finish error:(completeError)reqError
{
    NSLog(@"提交...");
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameter
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:nil];
    
    [[_httpPostSessionManager dataTaskWithRequest:[self customRequestMethod:@"POST" URLString:MyCarURL data:jsonData    ] completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            NSDictionary *resultDictionary = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"result:%@",resultDictionary);
            finish(resultDictionary);
            if ([resultDictionary[@"code"] integerValue] == TokenExpired) {
                if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                    NSHTTPURLResponse *r = (NSHTTPURLResponse *)response;
                    NSDictionary *headerFieldsDictionary = [r allHeaderFields];
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults removeObjectForKey:@"userToken"];
                    [defaults setObject:[NSString stringWithFormat:@"%@",headerFieldsDictionary[@"Authorization"]] forKey:@"userToken"];
                    [defaults synchronize];
                    
                }
            }
            if ([resultDictionary[@"code"] integerValue] == RequestSuccess) {
                [SVProgressHUD showSuccessWithStatus:@"提交成功！工作人员将在48小时内对您的车辆登记信息进行审核，请保持关注"];
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
            }
            
            
            if ([resultDictionary[@"code"] integerValue] == RequestFail) {
                [SVProgressHUD showErrorWithStatus:resultDictionary[@"message"]];
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                return;
            }
            
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *r = (NSHTTPURLResponse *)response;
                NSDictionary *headerFieldsDictionary = [r allHeaderFields];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults removeObjectForKey:@"userToken"];
                [defaults setObject:[NSString stringWithFormat:@"%@",headerFieldsDictionary[@"Authorization"]] forKey:@"userToken"];
                [defaults synchronize];
                
            }
            
            reqError(error);
            
            [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            
            
        }
    }] resume];
    
}

/**
 删除车辆信息

 @param carId carId 删除参数
 @param finish finish 删除成功的返回块
 @param reqError reqError 服务器请求失败的返回块
 */
- (void)deleteCarInformationWithParameter:(NSString *)carId complete:(completeRequest)finish failure:(completeError)reqError
{
    NSString *deleteCarInfoURL = [NSString stringWithFormat:@"%@%@",MyCarURL,carId];
    [_httpSessionManager DELETE:deleteCarInfoURL parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
            NSDictionary *headerFieldsDictionary = [r allHeaderFields];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults removeObjectForKey:@"userToken"];
            [defaults setObject:[NSString stringWithFormat:@"%@",headerFieldsDictionary[@"Authorization"]] forKey:@"userToken"];
            [defaults synchronize];
            
        }
        
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        
    }];
    
}

/**
 上传图片并将相应的返回值通过块的方式返回

 @param uploadImage uploadImage 需要上传的图片
 @param index index 图片索引，0:行驶证  1:车身照片
 @param finish finish 请求成功之后的返回值
 @param reqError reqError 请求失败之后的返回块
 */
- (void)uploadImageToServerWithImage:(UIImage *)uploadImage andIndex:(NSInteger)index complete:(completeRequest)finish error:(completeError)reqError
{
    NSLog(@"userToken====%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"userToken"]);
    NSDictionary *imageUploadParameter = @{@"key":[NSString stringWithFormat:@"image_%ld",index]};
    [_httpSessionManager POST:UploadFileURL parameters:imageUploadParameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImageJPEGRepresentation(uploadImage, 0.3);
        
        NSString *name = [NSString stringWithFormat:@"image_ios_%ld.jpeg",index];//@"image_ios.jpeg";
        
        NSString *formKey = [NSString stringWithFormat:@"image_%ld",index];//@"image";
        
        NSString *type = @"image/jpeg";
        
        [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSString *completeString = [NSString stringWithFormat:@"%.1f",((CGFloat)uploadProgress.completedUnitCount / (CGFloat)uploadProgress.totalUnitCount) * 100];
        NSLog(@"totalUnitCount:%lld  completedUnitCount:%lld",uploadProgress.totalUnitCount,uploadProgress.completedUnitCount);
        completeString = [completeString stringByAppendingString:@"%"];
        [SVProgressHUD showWithStatus:completeString];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        [SVProgressHUD dismiss];
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return;
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error.localizedDescription);
        reqError(error);
        [SVProgressHUD dismiss];
        
    }];
    
}

/**
 登录接口

 @param parameters parameters 登录参数
 @param finish finish 登录成功之后的返回
 @param reqError reqError 请求服务器失败的返回结果
 */
- (void)userSignInWithParameter:(NSDictionary *)parameters  complete:(completeRequest)finish error:(completeError)reqError
{
    __weak typeof(self) weakSelf = self;
    NSLog(@"登录／发送验证码....");
    [self clearSessionHeaderFieldAuthorization];
    
    [_httpSessionManager POST:LogInURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress){
            
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"response:%@",responseObject);
        if ([responseObject[@"code"] integerValue] == TokenExpired) {
            finish(responseObject);
            
            return ;
        }
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *resultDictionary = responseObject[@"entity"];
        if ([responseObject[@"code"] integerValue] == RequestSuccess) {
            [defaults setObject:@"1" forKey:@"signInTag"];
            [defaults synchronize];
            [defaults setObject:resultDictionary[@"id"] forKey:@"signInID"];
            [defaults synchronize];
            finish(responseObject);
            
        }
        
        if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
                NSDictionary *headerFieldsDictionary = [r allHeaderFields];
                [defaults removeObjectForKey:@"userToken"];
                NSLog(@"userToken====%@",[defaults objectForKey:@"userToken"]);
                [defaults synchronize];
                [defaults setObject:[NSString stringWithFormat:@"%@",headerFieldsDictionary[@"Authorization"]] forKey:@"userToken"];
                NSLog(@"userToken====%@",[defaults objectForKey:@"userToken"]);
                [defaults synchronize];
                [strongSelf setSessionHeaderField];
            }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error.localizedDescription);
        reqError(error);
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        }];
    
}

- (void)dynamicCodeSignInWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError
{
    __weak typeof(self) weakSelf = self;
    
    [self clearSessionHeaderFieldAuthorization];
    [_httpSessionManager POST:DynamicCodeLogInURL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"response:%@",responseObject);
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *resultDictionary = responseObject[@"entity"];
        if ([responseObject[@"code"] integerValue] == RequestSuccess) {
            [defaults setObject:@"1" forKey:@"signInTag"];
            [defaults synchronize];
            [defaults setObject:resultDictionary[@"id"] forKey:@"signInID"];
            [defaults synchronize];
            finish(responseObject);
            
        }
        
        if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
            NSDictionary *headerFieldsDictionary = [r allHeaderFields];
            [defaults removeObjectForKey:@"userToken"];
            NSLog(@"userToken====%@",[defaults objectForKey:@"userToken"]);
            [defaults synchronize];
            [defaults setObject:[NSString stringWithFormat:@"%@",headerFieldsDictionary[@"Authorization"]] forKey:@"userToken"];
            NSLog(@"userToken====%@",[defaults objectForKey:@"userToken"]);
            [defaults synchronize];
            [strongSelf setSessionHeaderField];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error.localizedDescription);
        reqError(error);
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    }];
}

/**
 第三方登录

 @param parameter parameter type:(第三方登陆 类型：{1：微信，2：QQ，3：微博})  code:openID
 @param finish finish 请求成功的返回块
 @param reqError reqError 请求失败的返回块
 */
- (void)thirdPartLogInWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError
{
    __weak typeof(self) weakSelf = self;
    
    [self clearSessionHeaderFieldAuthorization];
    [_httpSessionManager POST:ThirdLogInURL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSLog(@"response:%@",responseObject);
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDictionary *resultDictionary = responseObject[@"entity"];
        if ([responseObject[@"code"] integerValue] == RequestSuccess) {
            [defaults setObject:@"1" forKey:@"signInTag"];
            [defaults synchronize];
            [defaults setObject:resultDictionary[@"id"] forKey:@"signInID"];
            [defaults synchronize];
            finish(responseObject);
            
        }
        
        if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *r = (NSHTTPURLResponse *)task.response;
            NSDictionary *headerFieldsDictionary = [r allHeaderFields];
            [defaults removeObjectForKey:@"userToken"];
            NSLog(@"userToken====%@",[defaults objectForKey:@"userToken"]);
            [defaults synchronize];
            [defaults setObject:[NSString stringWithFormat:@"%@",headerFieldsDictionary[@"Authorization"]] forKey:@"userToken"];
            NSLog(@"userToken====%@",[defaults objectForKey:@"userToken"]);
            [defaults synchronize];
            [strongSelf setSessionHeaderField];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error.localizedDescription);
        reqError(error);
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    }];
    
}

/**
 修改头像

 @param avatarURL avatarURL 上传的头像的地址
 @param finish finish 请求成功之后的返回结果
 @param reqError reqError 请求失败之后的返回结果
 */
- (void)changeAvatarWithAvatarURL:(NSString *)avatarURL complete:(completeRequest)finish error:(completeError)reqError
{
    NSDictionary *changeAvatarParameter = @{@"headUrl":avatarURL};
    [_httpSessionManager PUT:ChangeHeadImageURL parameters:changeAvatarParameter success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        
    }];
    
    
}

/**
 获取个人中心的数据

 @param finish finish 请求成功的返回块
 @param reqError reqError 请求失败的返回块
 */
- (void)getPersonalCenterInformationComplete:(completeRequest)finish failure:(completeError)reqError
{
    [_httpSessionManager GET:PersonalCenterURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        
    }];
    
}

/**
 个人资料初始化

 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)UserDetailInitialDataRequestSuccess:(completeRequest)finish failure:(completeError)reqError
{
    [SVProgressHUD show];
    [self setSessionHeaderField];
    [_httpSessionManager GET:UserDetailURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        
    }];
    
}

/**
 个人资料完善，获取基础数据，无需参数
 
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)getUserDetailDictionarySuccess:(completeRequest)finish failure:(completeError)reqError
{
    [self clearSessionHeaderFieldAuthorization];
    [_httpSessionManager GET:BaseDictionariesURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }];
    
}

/**
 个人资料完善，获取地区数据，无需参数
 
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)getAreasSuccess:(completeRequest)finish failure:(completeError)reqError
{
    [self clearSessionHeaderFieldAuthorization];
    [_httpSessionManager GET:AreasURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    }];
}

/**
 根据行业ID获取该行业中的工作角色
 
 @param parameter parameter 获取验证码参数 industryCdId
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)getJobRoleWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError
{
    [self clearSessionHeaderFieldAuthorization];
    [_httpSessionManager POST:JobRoleURL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }];
    
    
}

/**
 个人资料更换验证旧手机号

 @param parameter parameter :phone password
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)checkOldPhoneNumWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError
{
    [_httpSessionManager POST:CheckOldTelURL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    }];
    
    
}

/**
 保存新的手机号，替换旧的手机号

 @param parameter parameter valiCode
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)exchangePhoneNumberToNewPhoneWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError
{
    [self setSessionHeaderField];
    [_httpSessionManager POST:SaveNewTelURL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        
    }];
    
}

/**
 获取验证码

 @param parameter parameter 获取验证码参数
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)getCheckCodeWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError
{
    [self clearSessionHeaderFieldAuthorization];
    [_httpSessionManager POST:SendURL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    }];
}

/**
 短信验证码验证接口

 @param parameter parameter 验证短信参数
 @param finish finish 请求成功的参数
 @param reqError reqError 请求失败的参数
 */
- (void)messageValidateWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError
{
    [self clearSessionHeaderFieldAuthorization];
    [_httpSessionManager POST:MessageValidateURL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    }];
}

/**
 检查当前用户是否存在

 @param parameter parameter 查询的参数
 @param finish finish 请求成功的返回块
 @param reqError reqError 请求失败的返回块
 */
- (void)userExistedWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError
{
    [self clearSessionHeaderFieldAuthorization];
    [_httpSessionManager GET:UserExistedURL parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    }];
}

/**
 注册时的设置密码

 @param parameters parameters 注册时的参数
 @param finish finish 请求成功的返回块
 @param reqError reqError 请求失败的返回块
 */
- (void)registerSetPasswordWithParameter:(NSDictionary *)parameters success:(completeRequest)finish failure:(completeError)reqError
{
    [self clearSessionHeaderFieldAuthorization];
    [_httpSessionManager POST:RegisterURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        
    }];
    
}

/**
 完善用户个人资料

 @param parameter parameter 待保存的参数都存key
 @param finish finish 请求成功的返回块
 @param reqError reqError 请求失败的返回块
 */
- (void)saveUserDetailInformationWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameter
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:nil];
    
    [[_httpPostSessionManager dataTaskWithRequest:[self customRequestMethod:@"POST" URLString:SaveUserDetailURL data:jsonData] completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            NSDictionary *resultDictionary = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"result:%@",resultDictionary);
            finish(resultDictionary);
            if ([resultDictionary[@"code"] integerValue] == TokenExpired) {
                if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                    NSHTTPURLResponse *r = (NSHTTPURLResponse *)response;
                    NSDictionary *headerFieldsDictionary = [r allHeaderFields];
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults removeObjectForKey:@"userToken"];
                    [defaults setObject:[NSString stringWithFormat:@"%@",headerFieldsDictionary[@"Authorization"]] forKey:@"userToken"];
                    [defaults synchronize];
                    
                }
            }
            
            
            if ([resultDictionary[@"code"] integerValue] == RequestFail) {
                [SVProgressHUD showErrorWithStatus:resultDictionary[@"message"]];
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                return;
            }
            
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *r = (NSHTTPURLResponse *)response;
                NSDictionary *headerFieldsDictionary = [r allHeaderFields];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults removeObjectForKey:@"userToken"];
                [defaults setObject:[NSString stringWithFormat:@"%@",headerFieldsDictionary[@"Authorization"]] forKey:@"userToken"];
                [defaults synchronize];
                
            }
            
            reqError(error);
            
            [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            
            
        }
    }] resume];
    
    
}

/**
 修改资料

 @param parameter parameter body
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)changeUserDetailWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameter
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:nil];
    
    [[_httpPostSessionManager dataTaskWithRequest:[self customRequestMethod:@"PUT" URLString:SaveUserDetailURL data:jsonData] completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            NSDictionary *resultDictionary = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"result:%@",resultDictionary);
            finish(resultDictionary);
            if ([resultDictionary[@"code"] integerValue] == TokenExpired) {
                if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                    NSHTTPURLResponse *r = (NSHTTPURLResponse *)response;
                    NSDictionary *headerFieldsDictionary = [r allHeaderFields];
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults removeObjectForKey:@"userToken"];
                    [defaults setObject:[NSString stringWithFormat:@"%@",headerFieldsDictionary[@"Authorization"]] forKey:@"userToken"];
                    [defaults synchronize];
                    
                }
            }
            
            
            if ([resultDictionary[@"code"] integerValue] == RequestFail) {
                [SVProgressHUD showErrorWithStatus:resultDictionary[@"message"]];
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                return;
            }
            
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *r = (NSHTTPURLResponse *)response;
                NSDictionary *headerFieldsDictionary = [r allHeaderFields];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults removeObjectForKey:@"userToken"];
                [defaults setObject:[NSString stringWithFormat:@"%@",headerFieldsDictionary[@"Authorization"]] forKey:@"userToken"];
                [defaults synchronize];
                
            }
            
            reqError(error);
            
            [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            
            
        }
    }] resume];
    
}

/**
 获取我的任务列表数据

 @param parameters parameters status=?&pageSize=?
 @param finish finish 访问成功之后的返回块
 @param reqError reqError 访问失败的返回块
 */
- (void)getMyTasksWithURLWithParameter:(NSDictionary *)parameters Success:(completeRequest)finish failure:(completeError)reqError
{
    [_httpSessionManager POST:MyTasksURL parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        
    }];
    
}

/**
 申请终止任务

 @param parameter parameter 终止任务参数
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)requestStopTaskWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError
{
    [_httpSessionManager POST:RequestStopTaskURL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        
    }];
    
    
}





/**
 首页任务领取，获取广告任务列表的广告任务

 @param parameter parameter “pagesize pageNo”这两个参数
 @param finish finish 请求成功的返回块
 @param reqError reqError 请求失败的返回块
 */
- (void)getHomeAdvTaskListsWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError
{
    [_httpSessionManager POST:AdvTasksURL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        
    }];
    
}

/**
 找回密码

 @param parameter parameter 找回密码参数
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)findPasswordWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError
{
    [self clearSessionHeaderFieldAuthorization];
    [_httpSessionManager POST:FindPwdURL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
        
    }];
    
}

//////////爱车币账户/////////////
/**
 爱车币账户

 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)getAckCoinAccountSuccess:(completeRequest)finish failure:(completeError)reqError
{
    [self setSessionHeaderField];
    [_httpSessionManager GET:AckCoinAccountURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    }];
}


/////////油卡///////

/**
 获取油卡列表，无需参数

 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)getOilCardListsSuccess:(completeRequest)finish failure:(completeError)reqError
{
    [self setSessionHeaderField];
    [_httpSessionManager GET:OilCardListsURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    }];
    
}

/**
 油卡激活

 @param parameter parameter 激活油卡参数 cardid:油卡ID   cardnumber:油卡卡号
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)activeOilCardWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError
{
    [self setSessionHeaderField];
    [_httpSessionManager POST:OilCardActiveURL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }];
    
}

/**
 拉取密保问题

 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)getSecurityQuestionSuccess:(completeRequest)finish failure:(completeError)reqError
{
    [self setSessionHeaderField];
    [_httpSessionManager GET:OilCardSecurityQuestionURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    }];
    
}

/**
 油卡挂失

 @param parameter parameter cardid 传油卡ID
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)reportCardLossWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError
{
    [self setSessionHeaderField];
    [_httpSessionManager POST:OilCardReportLossURL parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    }];
}

/**
 设置密保问题

 @param parameter parameter 密保问题参数 密码，问题，答案 json 放在body里边
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)setSecurityQuetionWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError
{
    NSLog(@"提交...");
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameter
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:nil];
    
    [[_httpPostSessionManager dataTaskWithRequest:[self customRequestMethod:@"POST" URLString:SetSecurityQuestionURL data:jsonData] completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) {
            NSDictionary *resultDictionary = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
            NSLog(@"result:%@",resultDictionary);
            finish(resultDictionary);
            
            if ([resultDictionary[@"code"] integerValue] == RequestFail) {
                [SVProgressHUD showErrorWithStatus:resultDictionary[@"message"]];
                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                });
                return;
            }
            
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            reqError(error);
            
            [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            
            
        }
    }] resume];
}

/**
 油卡充值

 @param parameter parameter money充值金额数 tradpwd交易密码
 @param finish finish 请求成功返回块
 @param reqError reqError 请求失败返回块
 */
- (void)chargeOilCardWithParameter:(NSDictionary *)parameter success:(completeRequest)finish failure:(completeError)reqError
{
    [self setSessionHeaderField];
    [_httpSessionManager GET:ChargeOilCardURL parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        finish(responseObject);
        if ([responseObject[@"code"] integerValue] == RequestFail) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
            return ;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        reqError(error);
        
        [SVProgressHUD showErrorWithStatus:@"网络请求失败"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
        
    }];
}




@end
