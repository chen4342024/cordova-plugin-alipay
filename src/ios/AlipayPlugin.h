//
//  AlipayPlugin.h
//  TestAlipayDemo
//
//  Created by chen on 15/5/13.
//
//

#ifndef TestAlipayDemo_AlipayPlugin_h
#define TestAlipayDemo_AlipayPlugin_h
//
//测试商品信息封装在Product中,外部商户可以根据自己商品实际情况定义
//


@interface AlipayPlugin : CDVPlugin {
    // Member variables go here.
}

- (void)pay:(CDVInvokedUrlCommand*)command;
@end

#endif
