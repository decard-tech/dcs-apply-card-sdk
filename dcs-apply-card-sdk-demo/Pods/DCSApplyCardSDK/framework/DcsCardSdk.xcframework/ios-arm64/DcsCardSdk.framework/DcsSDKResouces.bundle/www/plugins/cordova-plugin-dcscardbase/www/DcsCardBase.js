cordova.define("cordova-plugin-dcscardbase.DcsCardBase", function(require, exports, module) {
var exec = require('cordova/exec');

// 获取授权信息
exports.getAuthInfo = function (arg0, success, error) {
    exec(success, error, 'DcsCardBase', 'getAuthInfo', [arg0]);
};

//cordova返回给原生信息
exports.retResponse = function (arg0, success, error) {
    exec(success, error, 'DcsCardBase', 'retResponse', [arg0]);
};

exports.encryptRequest = function (arg0, success, error) {
    exec(success, error, 'DcsCardBase', 'encryptRequest', [arg0]);
};

exports.decryptResponse = function (arg0, success, error) {
    exec(success, error, 'DcsCardBase', 'decryptResponse', [arg0]);
};

exports.getMyinfoCallBack = function (arg0, success, error) {
    exec(success, error, 'DcsCardBase', 'getMyinfoCallBack', [arg0]);
};

});
