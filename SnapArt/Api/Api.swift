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
    private let AUTHORIZATION:String = "Basic c25hcGFydEBhZG1pbi5jb206YWRtaW4xMjM0"
    private let KEY_STATUS = "status"
    private let KEY_MESSAGE = "message"
    private let KEY_DATA = "results"
    private var WAITING:Bool = false
    private var parentView: UIView = UIView()
    
    public func execute(method: ApiMethod, url: String, parameters: [String:AnyObject], resulf:(Bool,String, AnyObject!) -> () ){
        let token = ""
        let headers = [
            "Authorization" : AUTHORIZATION,
            "token" : DataManager.sharedInstance.user.accessToken
        ]
        if(WAITING == true){
            GMDCircleLoader.setOnView(parentView, withTitle:MESSAGES.COMMON.LOADING, animated: true)
        }
        if(method == .GET){
            Alamofire.request(.GET, url, parameters: parameters, headers: headers).responseJSON { response in
                self.closeWaiting()
            }
        }else if(method == .POST){
            Alamofire.request(.POST, url, parameters: parameters, headers: headers).responseJSON { response in
                self.closeWaiting()
                if(self.WAITING == true){
                    GMDCircleLoader.removeTranparent(self.parentView)
                    self.WAITING = false
                }
                
            }
        }
    }
    
    public func closeWaiting(){
        if(self.WAITING == true){
            GMDCircleLoader.removeTranparent(self.parentView)
            self.WAITING = false
        }
    }

    public func execute2(method: ApiMethod, url: String, parameters: [String:String], resulf:(Bool,String, AnyObject!) -> () ){
        let authorizationData: NSData = AUTHORIZATION.dataUsingEncoding(NSUTF8StringEncoding)!
        let authorizationBase64 = authorizationData.base64EncodedStringWithOptions([])
        // create the request
        var request = NSMutableURLRequest()
        
        switch method{
        case .GET:
            var urlGet = url
            if(parameters.count > 0){
                urlGet = url + "?" + self.getParam(parameters)
            }
            let url = NSURL(string: urlGet)
            request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "GET"
        case .POST:
            let url = NSURL(string: url)
            request = NSMutableURLRequest(URL: url!)
            request.HTTPMethod = "POST"
            request.HTTPBody = self.getParam(parameters).dataUsingEncoding(NSUTF8StringEncoding)
        default:
            request.HTTPMethod = "POST"
        }
        request.setValue("Basic \(authorizationBase64)", forHTTPHeaderField: "Authorization")
        request.setValue(DataManager.sharedInstance.user.accessToken, forHTTPHeaderField: APIKEY.ACCESS_TOKEN)
        if(WAITING == true){
            GMDCircleLoader.setOnView(parentView, withTitle:MESSAGES.COMMON.LOADING, animated: true)
        }
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void in
            let parseError: NSError?
            if(self.WAITING == true){
                GMDCircleLoader.removeTranparent(self.parentView)
                self.WAITING = false
            }
            if data != nil  {
                let parsedObject: AnyObject?
                do {
                    parsedObject = try NSJSONSerialization.JSONObjectWithData(data!,
                                        options: NSJSONReadingOptions.AllowFragments)
                } catch let error as NSError {
                    parseError = error
                    parsedObject = nil
                } catch {
                    fatalError()
                }
                
                if let dic = parsedObject as? NSDictionary {
                    
                    if let code = dic.valueForKey(self.KEY_STATUS) as? String {
                        var message = ""
                        if (dic.valueForKey(self.KEY_MESSAGE) as? String != nil) {
                            message = dic.valueForKey(self.KEY_MESSAGE) as! String
                        }
                        var dataObject:AnyObject!
                        if  (dic.valueForKey(self.KEY_DATA) != nil){
                            dataObject = dic.valueForKey(self.KEY_DATA)
                        }
                        
                        switch code {
                        case "success" :
                            resulf(true, message, dataObject)
                        case "failure" :
                            resulf(false, message, dataObject)
                        default:
                            print("cannot get data", terminator: "")
                        }
                    }
                }
                else{
                    resulf(false, MESSAGES.COMMON.NOT_INTERNET, nil)
                }
                
            }
            else {
                resulf(false, MESSAGES.COMMON.NOT_INTERNET,nil)
            }
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
    
    public func initWaiting(parentView:UIView){
        self.parentView = parentView
        WAITING = true
    }

}

public enum ApiMethod: Int{
    case GET = 1, POST
}