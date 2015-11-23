//
//  Api.swift
//  SnapArt
//
//  Created by Khanh Duong on 10/13/15.
//  Copyright (c) 2015 Duc Ngo Hoai. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public class Api{
    //account to authorize
    let headers = [
        "Authorization" : "Basic c25hcGFydEBhZG1pbi5jb206YWRtaW4xMjM0",
        "token" : MemoryStoreData().getString(APIKEY.ACCESS_TOKEN)
    ]
    static let KEY_STATUS = "status"
    static let KEY_MESSAGE = "message"
    static let KEY_DATA = "results"
    static let PAGING = "pagination"
    static let PAGE = "page"
    static let ROW_PER_PAGE = "row_per_page"
    static let TOTAL_PAGE = "total_page"
    private var WAITING:Bool = false
    private var parentView: UIView = UIView()
    var alamoFireManager : Alamofire.Manager?
    
    init(){
        
    }
    
    public func execute(method: ApiMethod, url: String, parameters: [String:AnyObject] = [String : AnyObject](), isGetFullData:Bool = false, resulf:(Bool,String, JSON!) -> () ){
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.timeoutIntervalForRequest = 15 // seconds
        self.alamoFireManager = Alamofire.Manager(configuration: configuration)
        
        if(self.WAITING == true){
            GMDCircleLoader.setOnView(parentView, withTitle:MESSAGES.COMMON.LOADING, animated: true)
        }
        if(method == .GET){
            self.alamoFireManager!.request(.GET, url, parameters: parameters, headers: headers).responseJSON { response in
                self.closeWaiting()
                print("api data GET: \(response)")
                if(response.result.value == nil){
                    resulf(false, MESSAGES.COMMON.API_EXCEPTION, JSON(""))
                    return
                }
                let json: JSON = JSON(response.result.value!)
                var data:JSON = JSON("")
                if(isGetFullData){
                    data = json
                }else{
                    data = json[Api.KEY_DATA]
                }
                if json[Api.KEY_STATUS].numberValue == 200 || json[Api.KEY_STATUS].stringValue == "success" {
                    resulf(true, json[Api.KEY_MESSAGE].stringValue, data)
                }
                if json[Api.KEY_STATUS].numberValue == 500 {
                    resulf(false, json[Api.KEY_MESSAGE].stringValue, data)
                }
            }
        }else if(method == .POST){
            self.alamoFireManager!.request(.POST, url, parameters: parameters, headers: headers).responseJSON { response in
                self.closeWaiting()

                print("api data POST: \(response)")
                if(response.result.value == nil){
                    resulf(false, MESSAGES.COMMON.NOT_INTERNET, JSON(""))
                    return
                }
                let json: JSON = JSON(response.result.value!)
                var data:JSON = JSON("")
                if(isGetFullData){
                    data = json
                }else{
                    data = json[Api.KEY_DATA]
                }
                if json[Api.KEY_STATUS].numberValue == 200 || json[Api.KEY_STATUS].stringValue == "success" {
                    resulf(true, json[Api.KEY_MESSAGE].stringValue, data)
                }
                if json[Api.KEY_STATUS].numberValue == 500 {
                    resulf(false, json[Api.KEY_MESSAGE].stringValue, data)
                }
            }
        }
        
        
    }
    
    func uploadFile(image:UIImage!,ratio:Float, resulf:(Bool,String!, String!) -> ()){
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        SRWebClient.POST(ApiUrl.crop_image_url)//
            .headers(headers)
            .data(imageData!, fieldName:"avatar", data:["ratio":"\(ratio)"])
            .send({(response:AnyObject!, status:Int) -> Void in
                print(response)
                let json = Json(string: (response as? String)!)
                print("\(response as? String)")

                if json["status"].asInt == 200 {
                    resulf(true, json[Api.KEY_MESSAGE].asString, json[Api.KEY_DATA].asString)
                }
                if json[Api.KEY_STATUS].asInt == 500 {
                    resulf(false, json[Api.KEY_MESSAGE].asString, json[Api.KEY_DATA].asString)
                }

                },failure:{(error:NSError!) -> Void in
                    print(error)
                    resulf(false, MESSAGES.COMMON.NOT_INTERNET, nil)
            })
    }
    
    public func getParam(parameters: [String:String]) -> String {
        var url = ""
        if(parameters.count > 0){
            var i = 1
            for(key, value) in parameters{
                url = url + key + "=" + value
                if(i != parameters.count){
                    url = url + "&"
                }
                i++
            }
        }
        return url
    }
    
    
    public func closeWaiting(){
        if(self.WAITING == true){
            GMDCircleLoader.removeTranparent(self.parentView)
            self.WAITING = false
        }
    }
    
    public func initWaiting(parentView:UIView){
        self.parentView = parentView
        self.WAITING = true
    }
    
}

public enum ApiMethod: Int{
    case GET = 1, POST
}