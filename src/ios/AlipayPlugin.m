/********* AlipayPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "AlipayPlugin.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Order.h"
#import "DataSigner.h"
#import "Keys.h"


@implementation AlipayPlugin

- (void)pay:(CDVInvokedUrlCommand*)command
{
    
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = UrlScheme_Key;

    
    
    NSString   *marketid = [command.arguments objectAtIndex:0];
    NSString   *subject  = [command.arguments objectAtIndex:1];
    NSString   *body     = [command.arguments objectAtIndex:2];
    NSString   *price    = [command.arguments objectAtIndex:3];
    
    NSString* orderInfo = [self getOrderInfo:price:subject:body:marketid];
    
    NSString* signedStr = [self doRsa:orderInfo];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    
    if (signedStr != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderInfo, signedStr, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            CDVPluginResult* pluginResult = nil;
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:resultDic];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
        
    }
    

}




-(NSString*)getOrderInfo:(NSString *)price:(NSString *)subject:(NSString *)body:(NSString *)marketid
{
    
   
    /*=======================需要填写商户app申请的===================================*/
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    NSString *partner = PartnerID;
    NSString *seller = SellerID;
    
    /*============================================================================*/
    
    /*
     *生成订单信息及签名
     */
    Order *order = [[Order alloc] init];
    order.partner = partner;
    order.seller = seller;
    order.tradeNO =marketid; //订单ID（由商家自行制定）
    
    order.productName = subject; //商品标题
    order.productDescription = body; //商品描述
    
    
    float pri=[price floatValue];
    order.amount = [NSString stringWithFormat:@"%.2f",pri]; //商品价格
   
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);

    return orderSpec;
}

    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
-(NSString*)doRsa:(NSString*)orderInfo
{
    NSString *privateKey = PartnerPrivKey;
    id<DataSigner> signer;
    signer = CreateRSADataSigner(privateKey);
    NSLog(@"签名的之后的字符串是：%@",signer);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}



@end
