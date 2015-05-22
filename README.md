# cordova-plugin-alipay
cordova-plugin-alipay


添加插件 cordova plugin add 插件目录路径


配置ios端：

	1.启动IDE（如Xcode），plugin下 libs的库，并导入到项目工程中。
	  AlipaySDK.bundle
	  AlipaySDK.framework
	  libcrypto.a
	  libssl.a

	2.将alipayUtil 文件夹放到plugin目录下，并在xcode中添加，记得选中group。即在xcode中显示为黄色文件夹

	3.点击项目名称，点击“Build Settings”选项卡，在搜索框中，以关键字“search”搜索，
	  对“Header Search Paths”增加头文件路径：$(SRCROOT)/项目名称，后面选择recursive 。
	  如果头文件信息已增加，可不必再增加。 （如果不添加，会报头文件找不到错误）

	4.点击项目名称，点击“Build Phases”选项卡，在“Link Binary with    Librarles”选项中，新增“AlipaySDK.framework”，“SystemConfiguration.framework”，    security.framework 系统库文件。
	  如果项目中已有这几个库文件，可不必再增加。(如果不添加，会报link arm64 等错误)

	5.配置url Scheme（点击项目名称，点击“Info”选项卡，在“URL Types”选项中，点击“+”，在“URL  Schemes”中输入“XXXXXX”。“XXXXXX”来自于文件Keys.h） （用于支付结束后的回调），需于代码中的Keys.h 中 urlSceheme一样
		
	6.appdelegate中添加 
		if ([url.host isEqualToString:@"safepay"]) {
			
			[[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
				NSLog(@"result = %@",resultDic);
			}];
		}
		
	7.修改程序中
		PARTNER（合作身份者id）、
		SELLER（收款支付宝账号）、  
		RSA_PRIVATE（商户私钥）**如何生成商户私钥请自行查看支付宝官方文档。**
		
配置Android端：

	添加插件 cordova plugin add 插件目录路径
	修改Keys 中的PARTNER  SELLER  RSA_PRIVATE
	
	
最后：
	调用方法请参看插件目录下www/index.js 中的testAlipay方法
	
	
如果想删除插件，Android端的只需要运行cordova命令就可以了，ios端的除了运行cordova命令，还需要按照安装时的步奏，手动删除库、文件以及代码
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	


 


