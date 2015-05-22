var exec = require('cordova/exec');


var Alipay = function() {};

Alipay.prototype.alipay = function(out_trade_no, subject, bodtxt, total_fee, successCallback, errorCallback, callbackUrl) {
    if (errorCallback == null) {
        errorCallback = function() {}
    }

    if (typeof errorCallback != "function") {
        console.log("errorCallback failure: failure parameter not a function");
        return;
    }

    if (typeof successCallback != "function") {
        console.log("psuccessCallback failure: success callback parameter must be a function");
        return;
    }

    if (!callbackUrl) {
        errorCallback('参数错误！');
        return;
    }
    //{"out_trade_no":out_trade_no, "subject": subject,"bodtxt":bodtxt, "total_fee": total_fee, "callbackUrl": callbackUrl}
    exec(successCallback, errorCallback, 'AlipayPlugin', 'pay', [out_trade_no, subject, bodtxt, total_fee, callbackUrl]);
};

var alipay = new Alipay();
module.exports = alipay;



/***************************使用demo****************************/
//cordova.plugins.AlipayPlugin.alipay();

function testAlipay() {
    var subject = "测试的商品";
    var body = "该测试商品的详细描述";
    var price = "0.01";
    var out_trade_no = getOutTradeNo();
    var callbackUrl = "http://host:port/path/Alipay/notify_url.aspx";
    var successCallback = function(msg) {
        console.log("successCallback");
        if(typeof msg == "object"){
            console.log("success--->" + msg.memo);
            console.log("success--->" + msg.result);
            console.log("success--->" + msg.resultStatus);
            alert("success--->" + msg.resultStatus + " : "+msg.result + " : " + msg.memo);
        }else{
            alert("success--->" + msg);
            
        }
        
    };


    /**
     * 错误代码：
     * 9000  订单支付成功
     * 8000  正在处理中
     * 4000  订单支付失败
     * 6001  用户中途取消
     * 6002  网络连接出错
     */
    var errorCallback = function(msg) {
        console.log("errorCallback");
        alert("error--->" + msg);
    };
    cordova.plugins.AlipayPlugin.alipay(out_trade_no, subject, body, price, successCallback, errorCallback, callbackUrl);
}


function getOutTradeNo() {
    return "082215222612710";
}