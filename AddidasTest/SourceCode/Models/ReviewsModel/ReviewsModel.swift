//
//  ReviewsModel.swift
//  AddidasTest
//
//  Created by Ajay Kumar on 27/04/2021.
//

import Foundation
class ReviewsModel: NSObject {
    @objc var productId  :   String!
    @objc var locale  :   String!
    @objc var rating  :   NSNumber!
    @objc var text  :   String!
    
    
    class func parseReviewsObject(object : [String:Any]) -> ReviewsModel {
         let obj = DynamicParser.setValuesOnClass(object: object, classObj: ReviewsModel()) as! ReviewsModel
         return obj
     }
   class func AddReview(id:String,param:[String:Any],completionHandler: @escaping (AnyObject, ResponseAction?, Bool?, Error?) -> ()) {
        WebServices.sharedInstance.sendRequestToThirdPartyServer(urlString: ServiceConstants.DomainUrlReviews + ServiceConstants.addReview + id, methodType: .post, param: (param as [String:AnyObject]), shouldShowHud: true) { (object , action, status, message) in
            if status!{
                completionHandler(object as! AnyObject , ResponseAction.ShowMesasgeOnAlert, status, message)
                
            }
            
        }
    }
    
}
