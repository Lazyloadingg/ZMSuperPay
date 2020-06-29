//
//  DYSuperPaymentParamProtocol.h
//  Pods-ZMSuperPay_Example
//
//  Created by Lazyloading on 2020/6/29.
//

#import <Foundation/Foundation.h>
#import "ZMSuperPayGlobal.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZMSuperPaymentParamProtocol <NSObject>

/** 支付方式 */
@property (nonatomic, assign) ZMSuperPaymentType  payType;

/** 应用scheme */
@property (nonatomic, strong) NSString * scheme;

#pragma mark -
#pragma mark -  🐷 支付宝支付 🐷

/** 订单信息 */
@property (nonatomic, strong) NSString * aliPayOrder;

#pragma mark -
#pragma mark -  🐷 微信支付 🐷

/** 商家向财付通申请的商家id */
@property (nonatomic, strong) NSString *partnerId;
/** 预支付订单 */
@property (nonatomic, strong) NSString *prepayId;
/** 随机串，防重发 */
@property (nonatomic, strong) NSString *nonceStr;
/** 时间戳，防重发 */
@property (nonatomic, assign) UInt32 timeStamp;
/** 商家根据财付通文档填写的数据和签名 */
@property (nonatomic, strong) NSString *package;
/** 商家根据微信开放平台文档对数据做的签名 */
@property (nonatomic, strong) NSString *sign;

#pragma mark -
#pragma mark -  🐷 银联支付 🐷

/** 订单信息 */
@property (nonatomic, strong) NSString * upPayOrder;

@end

NS_ASSUME_NONNULL_END
