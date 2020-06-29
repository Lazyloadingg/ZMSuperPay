//
//  ZMViewController.m
//  ZMSuperPay
//
//  Created by lazyloading@163.com on 06/29/2020.
//  Copyright (c) 2020 lazyloading@163.com. All rights reserved.
//

#import "ZMViewController.h"
#import <ZMSuperPay/ZMSuperPay.h>

@interface ZMViewController ()

@end

@implementation ZMViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultsSetting];
    [self initSubViews];
}

#pragma mark >_<! 👉🏻 🐷 Life cycle 🐷
#pragma mark >_<! 👉🏻 🐷 Delegate 🐷
#pragma mark >_<! 👉🏻 🐷 Event  Response 🐷
#pragma mark >_<! 👉🏻 🐷 Private Methods 🐷

-(void)payAction{
    [ZMSuperPayment payWithOrder:^(id<ZMSuperPaymentParamProtocol>  _Nonnull order) {
        order.payType = ZMSuperPaymentTypeAliPay;
        order.aliPayOrder = @"订单号";
    } completion:^(NSDictionary * _Nonnull info) {
        NSLog(@"回调");
    }];
}
#pragma mark >_<! 👉🏻 🐷 Setter && Getter 🐷
#pragma mark >_<! 👉🏻 🐷 Default Config🐷

-(void)loadDefaultsSetting{
    
}
-(void)initSubViews{
    
}
-(void)layout{
    
}

@end
