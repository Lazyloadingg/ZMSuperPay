//
//  ZMSuperPayWXService.h
//  Pods-ZMSuperPay_Example
//
//  Created by Lazyloading on 2020/6/29.
//

#import <Foundation/Foundation.h>
#import "ZMSuperPayService.h"

NS_ASSUME_NONNULL_BEGIN

/**
微信支付
*/

@interface ZMSuperPayWXService : ZMSuperPayService
+ (instancetype)shared;
@end

NS_ASSUME_NONNULL_END
