//
//  NetWorkHelp.swift
//  SZWeather
//
//  Created by admin on 16/5/20.

//

import Foundation
import Just

enum NetworkHelper {
    case weeklyWeather(cityid: String)
    
 static   var param = [
    
        "app" : "weather.future",
        "appkey" : "10003",
        "sign" : "b59bc3ef6191eb9f747dd4e83c99f2a4",
        "format" : "json"
      //  "weaid" : "weather.future",
       // "jsoncallback" : "weather.future"
      
        ]
    //例: http://api.k780.com:88/?app=weather.future&weaid=1&&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4&format=json
    
   private static let baseUrl = "http://api.k780.com:88/"
    
    func getWeather(completion:([Result]?,String?) -> Void ){
        
        //定义错误变量
        
        var error: String?
        
        
        //定义变量保存我们数据的结果
        var results: [Result]?
        
        switch self {
        case .weeklyWeather(cityid: let weaid):
            //往枚举中加入参数
            NetworkHelper.param["weaid"] = weaid
            //用just对对于数据请求
            Just.get(NetworkHelper.baseUrl, params: NetworkHelper.param, asyncCompletionHandler: { (r) in
                if r.ok {
                    
                    //判断返回数据是否为josn
                    guard let jsonDict = r.json as? NSDictionary else {
                        error = "返回的不是json数据"
                    
                        return
                    }
                    //确保字典中的值success的值为1
                    guard let success = jsonDict["success"] where success as? String == "1" else {
                    
                    error = "返回数据格式错误,或者授权错误"
                        return
                    }
                    
                    let weather = Weather(fromDictionary: jsonDict)
                    results = weather.result
                    
                
                }else {
                    
                    
                    error = "服务器出错"
                
                }
                 completion(results, error)
            })
            
        
        }
    }
}