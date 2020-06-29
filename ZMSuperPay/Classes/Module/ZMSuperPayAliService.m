//
//  DYSuperAliPayService.m
//  Pods-ZMSuperPay_Example
//
//  Created by Lazyloading on 2020/6/29.
//

#import "ZMSuperPayAliService.h"
#import <AlipaySDK/AlipaySDK.h>

static NSString * const K_ALIPAY_HOST = @"safepay";

@implementation ZMSuperPayAliService


+ (instancetype)shared{
    static ZMSuperPayAliService * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZMSuperPayAliService alloc]init];
    });
    return instance;
}

-(void)payWithOrder:(id<ZMSuperPaymentParamProtocol>)order completion:(ZMSuperPayServiceResultBlock)completion{
    [self payWithOrder:order viewController:nil completion:completion];
}
-(void)payWithOrder:(id<ZMSuperPaymentParamProtocol>)order viewController:(UIViewController *)viewController completion:(ZMSuperPayServiceResultBlock)completion{
    
    if (order.aliPayOrder.length == 0) {
        NSLog(@"订单信息不能为空");
        NSDictionary * calllback = @{
                                     @"code" : @(-10009),
                                     @"message" : @"订单信息不能为空",
                                     @"data" : @{}
                                     };
        
        if (completion) {
            completion(calllback);
        }
        return;
    }
    if (order.scheme.length == 0) {
        NSDictionary * calllback = @{
                                     @"code" : @(-10009),
                                     @"message" : @"订单信息不能为空",
                                     @"data" : @{}
                                     };
        
        if (completion) {
            completion(calllback);
        }
        NSLog(@"订单信息不能为空");
        return;
    }
    if (completion) {
        self.payBlock = completion;
    }
    
    [[AlipaySDK defaultService]payOrder:order.aliPayOrder fromScheme:order.scheme callback:^(NSDictionary *resultDic) {
        [self analysisResult:resultDic];
    }];
}
-(BOOL)registerApp:(NSString *)appid{
    return NO;
}
- (BOOL)handleOpenURL:(NSURL *)url {
    if ([url.host isEqualToString:K_ALIPAY_HOST]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [self analysisResult:resultDic];
        }];
    }
    return YES;
    
}
-(void)analysisResult:(NSDictionary *)result{
    NSNumber * resultStatus = result[@"resultStatus"];
    
    NSInteger status = resultStatus.integerValue;
    NSString * message;
    NSNumber * code;

    if (status == 9000) {
        message = @"成功";
        code = @(10000);
    }else if (status == 8000){
        message = @"处理中";
        code = @(-10001);
    }else if (status == 4000){
        message = @"订单支付失败";
        code = @(-10002);
    }else if (status == 5000){
        message = @"重复请求";
        code = @(-10003);
    }else if (status == 6001){
        message = @"用户取消";
        code = @(-10004);
    }else if (status == 6002){
        message = @"网络连接出错";
        code = @(-10005);
    }else if (status == 6004){
        code = @(-10006);
        message = @"支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态";
    }else{
        code = @(-10007);
        message = @"其它支付错误";
    }
    
    NSDictionary * data = result[@"result"];
    NSMutableDictionary * callback = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      message,@"message",
                                      code,@"code",
                                      data?:@"",@"data",
                                      nil];
    
    if (self.payBlock) {
        self.payBlock(callback);
    }
 
}
@end
