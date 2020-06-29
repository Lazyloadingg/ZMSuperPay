//
//  ZMSuperPayment.h
//  Pods-ZMSuperPay_Example
//
//  Created by Lazyloading on 2020/6/29.
//

#import <Foundation/Foundation.h>
#import "ZMSuperPaymentParamProtocol.h"
#import "ZMSuperPayGlobal.h"
#import "ZMSuperPayService.h"


NS_ASSUME_NONNULL_BEGIN

/**
支付调用类
*/
@interface ZMSuperPayment : NSObject

/**
 支付接口

 @param orderBlock 订单：订单信息以协议形式定义，具体信息需赋值实现协议的对象
 @param completion 结果回调
 */
+(void)payWithOrder:(ZMSuperPayOrderBlock)orderBlock  completion:(ZMSuperPayServiceResultBlock)completion;

/**
  支付接口

 @param orderBlock 订单：订单信息以协议形式定义，具体信息需赋值实现协议的对象
 @param viewController 控制器（银联需要，不建议传入当前控制器，有可能导致无法释放）
 @param completion 结果回调
 */
+(void)payWithOrder:(ZMSuperPayOrderBlock)orderBlock  viewController:(UIViewController * _Nullable)viewController completion:(ZMSuperPayServiceResultBlock)completion;

/**
 当程序跳回来时候做的处理
 
 @param url url
 */
+ (BOOL)handleOpenURL:(NSURL * _Nonnull)url;


/**
 注册支付应用

 @param appid appid
 @return 注册结果
 */
+ (BOOL)registerApp:(NSString *)appid payType:(ZMSuperPaymentType)type;

@end

NS_ASSUME_NONNULL_END
