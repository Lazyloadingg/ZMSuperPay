//
//  DYSuperAliPayService.h
//  Pods-ZMSuperPay_Example
//
//  Created by Lazyloading on 2020/6/29.
//

#import <Foundation/Foundation.h>

#import "ZMSuperPayService.h"

NS_ASSUME_NONNULL_BEGIN

/**
支付宝支付
*/
@interface ZMSuperPayAliService : ZMSuperPayService
+ (instancetype)shared;
@end

NS_ASSUME_NONNULL_END
