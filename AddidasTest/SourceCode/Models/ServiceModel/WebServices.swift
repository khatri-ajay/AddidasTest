//
//  ProductListViewController.swift
//  AddidasTest
//
//  Created by Ajay Kumar on 27/04/2021.
//

import Foundation
import Alamofire
import UIKit
import MBProgressHUD

class WebServices : NSObject{
    
    let webHeader:HTTPHeaders = ["accept":"application/json"]
    var hudView : MBProgressHUD!
    var alertWindow : UIWindow!
    

    static let sharedInstance = WebServices()
    
    private override init() {
        self.hudView = MBProgressHUD()
        

    }
    func getHeaders()->(HTTPHeaders){
        return ["accept":"application/json",]
    }
    
    func sendRequestToServer(urlString: String,
                               methodType : HTTPMethods,
                               param :[String : AnyObject]? = nil,
                               shouldShowHud : Bool = true,
                               shouldShowMessageAlert : Bool = true,
                               completionHandler: @escaping (NSDictionary?, Bool?, Error?) -> ())
    {
        
        let serviceUrl =  urlString
        print("serviceUrl " ,serviceUrl)
        if shouldShowHud{
            showHud(message: "")
        }
        let typeMethod: HTTPMethod = HTTPMethod(rawValue: methodType.rawValue)!
        
        Alamofire.request(serviceUrl, method: typeMethod, parameters: param, encoding: JSONEncoding.default,headers:getHeaders())
            .responseJSON { response in
                
                print("Request URL : " + urlString)
                print("Param : ",param ?? "")
                print("Header : ",self.getHeaders())
                print(response)

                self.hideHud()
                switch response.result {
                case .success(let JSON):
                    let object = JSON as? NSDictionary
                    completionHandler(object, true,nil)
                case .failure(let error):
                    print(error)
                    self.showAlertController(message: error.localizedDescription)
                }
        }

    }

    func sendRequestToThirdPartyServer(urlString: String,
                             methodType : HTTPMethods,
                             param:[String : AnyObject]? = nil,
                             shouldShowHud : Bool = true,
                             completionHandler: @escaping (AnyObject?, NSDictionary?, Bool?, Error?) -> ())
    {
        
        if shouldShowHud{
            showHud(message: "")
        }
        
        let typeMethod: HTTPMethod = HTTPMethod(rawValue: methodType.rawValue)!
        Alamofire.request(urlString, method:typeMethod , parameters: param, headers:webHeader)
            .responseJSON { response in
                print("Request URL : " + urlString)
                print("Param : ",param ?? "")
                print(response)
                self.hideHud()
                switch response.result {
                case .success(let JSON):
                    let object = JSON as? AnyObject
                    completionHandler(object , nil, true,nil)
                case .failure(let error):
                    print(error)
                    self.showAlertController(message: error.localizedDescription)
                    //                    completionHandler(nil, nil, false,error)
                }
        }
    }

    
    
    
    
    
    
    func showHud(message:String){
        print("adding hud on Services")

        let window: UIView =  UIApplication.shared.keyWindow!
        hudView = MBProgressHUD.showAdded(to: window, animated: true)
    }
    
    func hideHud(){
        
        let window: UIView =  UIApplication.shared.keyWindow!
        DispatchQueue.global(qos: .background).async {
            // Go back to the main thread to update the UI
            DispatchQueue.main.async {
                print("removing hud on webservices")
                MBProgressHUD.hideAllHUDs(for: window, animated: false)
                
//                MBProgressHUD.hide(for: window, animated: true)
            }
        }
    }
    
    func showAlertController(message:String){
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action -> Void in
            alert.dismiss(animated: true, completion: nil)
            self.alertWindow=nil
        })
        alert.addAction(okAction)
        
        self.alertWindow = UIWindow.init(frame: UIScreen.main.bounds)
        self.alertWindow.rootViewController = UIViewController()
        self.alertWindow.windowLevel = UIWindow.Level.alert + 1
        self.alertWindow.makeKeyAndVisible()
        self.alertWindow.rootViewController?.present(alert, animated: false, completion: nil)
    }
    
    class func getServiceWithParam(param:[String:AnyObject] , urlValue: String) -> String {
        var urlComponents = URLComponents(string: urlValue)
        
        var queryItems = [URLQueryItem]()
        //                var url = "\(urlValue)?"
        for key in param.keys {
            queryItems.append(URLQueryItem(name: key, value: param[key] as? String ?? ""))
            //                        url += "\(key)=\(param[key]!)&"
        }
        urlComponents?.queryItems = queryItems
        
        return urlComponents?.string ?? ""
    }
}
