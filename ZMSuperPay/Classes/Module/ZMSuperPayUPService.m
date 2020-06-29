//
//  ZMSuperPayUPService.m
//  Pods-ZMSuperPay_Example
//
//  Created by Lazyloading on 2020/6/29.
//

#import "ZMSuperPayUPService.h"
#import "UPPaymentControl.h"

@interface ZMSuperPayUPService()
@property (nonatomic, strong) NSString * payMode;
@end


static NSString * const kUPPayModeDebug = @"01";
static NSString * const kUPPayModeDis = @"00";
static NSString * const K_UPPAY_SCHEME = @"uppayresult";


@implementation ZMSuperPayUPService
+ (instancetype)shared{
    static ZMSuperPayUPService * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZMSuperPayUPService alloc]init];
    });
    return instance;
}
-(void)payWithOrder:(NSString *)order scheme:(NSString *)scheme completion:(ZMSuperPayServiceResultBlock)completion{
    
    [self payWithOrder:order scheme:scheme viewController:nil completion:completion];
    
}
-(void)payWithOrder:(NSString *)order scheme:(NSString *)scheme viewController:(UIViewController *)viewController completion:(ZMSuperPayServiceResultBlock)completion{
    
    if (completion) {
        self.payBlock = completion;
    }
    if (![self isPaymentAppInstalled]) {
        NSDictionary * calllback = @{
                                     @"code" : @(-10008),
                                     @"message" : @"未安装银联App",
                                     @"data" : @{}
                                     };
        if (completion) {
            completion(calllback);
        }
        return;
    }
    [[UPPaymentControl defaultControl]startPay:order fromScheme:scheme mode:self.payMode viewController:viewController];
    
}
-(BOOL)registerApp:(NSString *)appid{
    return NO;
}
-(BOOL)isPaymentAppInstalled{
    return [[UPPaymentControl defaultControl]isPaymentAppInstalled];
}
-(BOOL)handleOpenURL:(NSURL *)url{
    if ([url.host isEqualToString:K_UPPAY_SCHEME]) {
        [[UPPaymentControl defaultControl]handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
            [self analysisResult:data code:code];
        }];
    }
    return YES;
}
-(void)analysisResult:(NSDictionary *)result code:(NSString *)code{
    NSNumber * resultCode;
    NSString * message;
    NSMutableDictionary * data = [NSMutableDictionary dictionary];
    [data setObject:result forKey:@"data"];
    if ([code isEqualToString:@"success"]) {

        resultCode = @(10000);
        message = @"支付成功";
    }else if ([code isEqualToString:@"fail"]){
        resultCode = @(-10002);
        message = @"支付失败";
    }else if ([code isEqualToString:@"cancel"]){
        resultCode = @(-10004);
        message = @"用户取消";
    }else{
        resultCode = @(-10007);
        message = @"其他错误";
    }
    [data setObject:resultCode forKey:@"code"];
    [data setObject:message forKey:@"message"];
    if (self.payBlock) {
        self.payBlock(data);
    }
}
@end
