//
//  Keys.h
//  TestAlipayDemo
//
//  Created by chen on 15/5/13.
//
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//

#ifndef Alipay_Keys_h
#define Alipay_Keys_h

//合作身份者id，以2088开头的16位纯数字
#define PartnerID @""
//收款支付宝账号
#define SellerID  @""


//应用注册scheme,在AlixPayDemo-Info.plist定义URL types
#define UrlScheme_Key @""

//商户私钥，自助生成
#define PartnerPrivKey @""



//支付宝公钥 无需修改
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"

#endif
