//
//  ZMSuperPayment.m
//  Pods-ZMSuperPay_Example
//
//  Created by Lazyloading on 2020/6/29.
//

#import "ZMSuperPayment.h"
#import "ZMSuperPayWXService.h"
#import "ZMSuperPayAliService.h"
#import "ZMSuperPayUPService.h"
#import "ZMSuperPayParam.h"

@implementation ZMSuperPayment

+(void)payWithOrder:(ZMSuperPayOrderBlock)orderBlock completion:(ZMSuperPayServiceResultBlock)completion{
    [self payWithOrder:orderBlock viewController:nil completion:completion];
}

+(void)payWithOrder:(ZMSuperPayOrderBlock)orderBlock  viewController:(UIViewController *)viewController completion:(ZMSuperPayServiceResultBlock)completion{
    ZMSuperPayParam * order = [[ZMSuperPayParam alloc]init];
    if (orderBlock) {
        orderBlock(order);
    }
    ZMSuperPayService * service;
    switch (order.payType) {
        case ZMSuperPaymentTypeUNPay:
            service = [ZMSuperPayUPService shared];
            break;
            
        case ZMSuperPaymentTypeAliPay:
            service = [ZMSuperPayAliService shared];
            break;
            
        case ZMSuperPaymentTypeWXPay:
            service = [ZMSuperPayWXService shared];
            break;

            
        default:
            service = [ZMSuperPayAliService shared];
            break;
    }
    
    [service payWithOrder:order viewController:viewController completion:completion];
}
+ (BOOL)registerApp:(NSString *)appid payType:(ZMSuperPaymentType)type{
    ZMSuperPayService * service;
    switch (type) {
        case ZMSuperPaymentTypeUNPay:
            service = [ZMSuperPayUPService shared];
            break;
            
        case ZMSuperPaymentTypeAliPay:
            service = [ZMSuperPayAliService shared];
            break;
            
        case ZMSuperPaymentTypeWXPay:
            service = [ZMSuperPayWXService shared];
            break;

            
        default:
            service = [ZMSuperPayAliService shared];
            break;
    }
    
    return [service registerApp:appid];
}
+(BOOL)handleOpenURL:(NSURL *)url{
    if([url.scheme hasPrefix:@"wx"]){
        //微信
        return [[ZMSuperPayWXService shared] handleOpenURL:url];
    }else if([url.host isEqualToString:@"uppayresult"]){
        //银联
        return [[ZMSuperPayUPService shared] handleOpenURL:url];
    }else if([url.host isEqualToString:@"safepay"]){
        //支付宝
        return [[ZMSuperPayAliService shared] handleOpenURL:url];
    }
    return NO;
}

@end
