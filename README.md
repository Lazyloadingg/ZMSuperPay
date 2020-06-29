# ZMSuperPay


[![CI Status](https://img.shields.io/travis/lazyloading@163.com/ZMSuperPay.svg?style=flat)](https://travis-ci.org/lazyloading@163.com/ZMSuperPay)
[![Version](https://img.shields.io/cocoapods/v/ZMSuperPay.svg?style=flat)](https://cocoapods.org/pods/ZMSuperPay)
[![License](https://img.shields.io/cocoapods/l/ZMSuperPay.svg?style=flat)](https://cocoapods.org/pods/ZMSuperPay)
[![Platform](https://img.shields.io/cocoapods/p/ZMSuperPay.svg?style=flat)](https://cocoapods.org/pods/ZMSuperPay)


## Description
整合支付
## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

支付接口使用示例：
```objectivec

    [ZMSuperPayment payWithOrder:^(id<ZMSuperPaymentParamProtocol>  _Nonnull order) {
        order.payType = ZMSuperPaymentTypeAliPay;
        order.aliPayOrder = @"订单号";
    } completion:^(NSDictionary * _Nonnull info) {
        NSLog(@"回调");
    }];

```

AppDelegate回调：
```objectivec
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
    return [ZMSuperPayment handleOpenURL:url];
}

```

## Requirements

## Installation

ZMSuperPay is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ZMSuperPay'
```

## Author

lazyloading@163.com, lazyloading@163.com

## License

ZMSuperPay is available under the MIT license. See the LICENSE file for more info.



