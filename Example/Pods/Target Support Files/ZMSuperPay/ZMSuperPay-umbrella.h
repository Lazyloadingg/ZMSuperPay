#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "ZMSuperPayGlobal.h"
#import "UPPaymentControl.h"
#import "ZMSuperPayAliService.h"
#import "ZMSuperPayment.h"
#import "ZMSuperPayParam.h"
#import "ZMSuperPayService.h"
#import "ZMSuperPayUPService.h"
#import "ZMSuperPayWXService.h"
#import "ZMSuperPaymentParamProtocol.h"
#import "ZMSuperPay.h"

FOUNDATION_EXPORT double ZMSuperPayVersionNumber;
FOUNDATION_EXPORT const unsigned char ZMSuperPayVersionString[];

