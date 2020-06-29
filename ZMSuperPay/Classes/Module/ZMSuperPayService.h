//
//  ZMSuperPayService.h
//  Pods-ZMSuperPay_Example
//
//  Created by Lazyloading on 2020/6/29.
//

#import <Foundation/Foundation.h>
#import "ZMSuperPaymentParamProtocol.h"

typedef void(^ZMSuperPayOrderBlock)(id<ZMSuperPaymentParamProtocol> _Nonnull order);

NS_ASSUME_NONNULL_BEGIN

/**
支付服务基类
*/
@interface ZMSuperPayService : NSObject

@property(nonatomic,copy)ZMSuperPayServiceResultBlock  payBlock;


- (void)payWithOrder:(id<ZMSuperPaymentParamProtocol>)order  completion:(ZMSuperPayServiceResultBlock)completion;

- ( void)payWithOrder:(id<ZMSuperPaymentParamProtocol>)order  viewController:(UIViewController * _Nullable  )viewController completion:(ZMSuperPayServiceResultBlock)completion;

- (BOOL)handleOpenURL:(NSURL *)url;

- (BOOL)registerApp:(NSString *)appid;

@end

NS_ASSUME_NONNULL_END
