//
//  ZMSuperPayWXService.m
//  Pods-ZMSuperPay_Example
//
//  Created by Lazyloading on 2020/6/29.
//

#import "ZMSuperPayWXService.h"
#import <WechatOpenSDK/WXApi.h>

@interface ZMSuperPayWXService()
<
WXApiDelegate
>
@end

static NSString * const K_WXPAY_SCHEME = @"wx";

@implementation ZMSuperPayWXService

+ (instancetype)shared{
    static ZMSuperPayWXService * instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZMSuperPayWXService alloc]init];
    });
    return instance;
}
-(void)payWithOrder:(id<ZMSuperPaymentParamProtocol>)order completion:(ZMSuperPayServiceResultBlock)completion{
    
    [self payWithOrder:order viewController:nil completion:completion];
    
}
-(void)payWithOrder:(id<ZMSuperPaymentParamProtocol>)order viewController:(UIViewController *)viewController completion:(ZMSuperPayServiceResultBlock)completion{
    if (completion) {
        self.payBlock = completion;
    }
    if (![self isWXAppInstalled]) {
        NSDictionary * calllback = @{
                                     @"code" : @(-10008),
                                     @"message" : @"应用未安装",
                                     @"data" : @{}
                                     };
        
        if (completion) {
            completion(calllback);
        }
        
        return;
    }else if (![self isWXAppSupportApi]){
        NSDictionary * calllback = @{
                                     @"code" : @(-10008),
                                     @"message" : @"当前版本微信不支持支付",
                                     @"data" : @{}
                                     };
        NSLog(@"微信未安装");
        if (completion) {
            completion(calllback);
        }
        return;
    }
    NSLog(@"partnerId : %@\n prepayId : %@\n nonceStr : %@\n package : %@\n sign : %@",order.partnerId,order.prepayId, order.nonceStr, order.package, order.sign);
    NSAssert(order.partnerId.length || order.prepayId.length || order.nonceStr.length || order.package.length || order.sign.length, @"参数不能为空");
    
    PayReq * req = [[PayReq alloc]init];
    req.partnerId = order.partnerId;
    req.prepayId = order.prepayId;
    req.nonceStr = order.nonceStr;
    req.timeStamp = order.timeStamp;
    req.package = order.package?:@"Sign=WXPay";
    req.sign = order.sign;
   BOOL sendResult = [WXApi sendReq:req];
    if (!sendResult) {
        NSDictionary * calllback = @{
                                     @"code" : @(-10002),
                                     @"message" : @"发送失败",
                                     @"data" : @{}
                                     };
        NSLog(@"发送失败");
        if (completion) {
            completion(calllback);
        }
    }
    
}
-(BOOL)registerApp:(NSString *)appid{
   return [WXApi registerApp:appid];
}
-(BOOL)isWXAppInstalled{
    return [WXApi isWXAppInstalled];
}
-(BOOL)isWXAppSupportApi{
    return [WXApi isWXAppSupportApi];
}
//回调处理
- (BOOL)handleOpenURL:(NSURL *)url {
    if ([url.scheme hasPrefix:K_WXPAY_SCHEME]) {
        return [WXApi handleOpenURL:url delegate:self];
    }
    return YES;
}
#pragma mark --> 🐷 WXApiDelegate 🐷
-(void)onResp:(BaseResp*)resp{
    
    NSNumber * code;
    NSString * message;
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp * response = (PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                code = @(10000);
                message = @"成功（服务器端查询支付通知或查询API返回的结果再提示成功）";
                break;
                
                case WXErrCodeCommon:
                code = @(-10002);
                message = @"支付失败，可能的原因：签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等。";
                break;
                
                case WXErrCodeUserCancel:
                code = @(-10004);
                message = @"用户取消";
                break;
                
                case WXErrCodeSentFail:
                code = @(-10002);
                message = @"发送失败";
                break;
                
                case WXErrCodeAuthDeny:
                code = @(-10002);
                message = @"授权失败";
                break;
                
                case WXErrCodeUnsupport:
                code = @(-10008);
                message =  @"当前版本微信不支持支付";
                break;
                
                
            default:
                code = @(-10007);
                message = @"其他错误";
                break;
        }
    }

    NSMutableDictionary * callback = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      message,@"message",
                                      code,@"code",
                                      resp.errStr?:@"",@"data",
                                      nil];
    
    if (self.payBlock) {
        self.payBlock(callback);
    }
}

@end
