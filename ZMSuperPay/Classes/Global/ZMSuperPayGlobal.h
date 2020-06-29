//
//  ZMSuperPayGlobal.h
//  Pods-ZMSuperPay_Example
//
//  Created by Lazyloading on 2020/6/29.
//

#ifndef ZMSuperPayGlobal_h
#define ZMSuperPayGlobal_h

/** 支付类型 */
typedef NS_ENUM(NSUInteger, ZMSuperPaymentType) {

    /** 支付宝 */
    ZMSuperPaymentTypeAliPay,
    /** 微信 */
    ZMSuperPaymentTypeWXPay,
    /** 银联 */
    ZMSuperPaymentTypeUNPay
    
};

/**
  10000 成功,
 -10001 处理中,
 -10002 订单支付失败,
 -10003 重复请求,
 -10004 用户取消,
 -10005 网络连接出错,
 -10006 支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态,
 -10007 其他错误,
 -10008 应用未安装,
 -10009 参数错误
 */
/**
 回调信息

 @param info @{code : code,data : data,message : message , orderNumber : orderNumber}
 */
typedef void(^ZMSuperPayServiceResultBlock)(NSDictionary * _Nonnull info);


#endif /* ZMSuperPayGlobal_h */
