//
//  ProductModel.swift
//  AddidasTest
//
//  Created by Ajay Kumar on 27/04/2021.
//

import Foundation
class ProductModel: NSObject {
    @objc var id  :   String!
    @objc var name  :   String!
    @objc var Description  :   String!
    @objc var currency  :   String!
    @objc var price  :  NSNumber!
    @objc var imgurl  :   String!
    var reviewsArray : [ReviewsModel] = []
    
    class func dummyModels() -> [ProductModel] {
        var objct = ProductModel()
        objct.id = "5"
        objct.name = "asdasd"
        objct.Description = "aasdasdasdasdasdasdasdasdasdasdasdasdasdasdasdadasdasdasdasd"
        objct.currency = "$"
        objct.price = 1
        objct.imgurl = "https://assets.adidas.com/images/w_320,h_320,f_auto,q_auto:sensitive,fl_lossy/6634cf36274b4ea5ac46ac4e00b2021e_9366/Superstar_Shoes_Black_FY0071_01_standard.jpg"
        return [objct]
        
    }
    class func getProducts(completionHandler: @escaping ([ProductModel], ResponseAction?, Bool?, Error?) -> ()) {
        WebServices.sharedInstance.sendRequestToThirdPartyServer(urlString: ServiceConstants.DomainUrlproduct + ServiceConstants.Products, methodType: .get) { (object, response, status, message) in
            if status!{
                var productsArray = [ProductModel]()
                let dictObject = object as! [[String:Any]]
                for (_,value) in dictObject.enumerated() {
                    productsArray.append(ProductModel.parseProductObject(object: value))
                }
                print(productsArray)
                completionHandler(productsArray,ResponseAction.DoNotShowMesasgeAtRunTime,status,message)
            }
        }
    }
   class func getProduct(productID: String,completionHandler: @escaping (ProductModel, ResponseAction?, Bool?, Error?) -> ()) {
        WebServices.sharedInstance.sendRequestToThirdPartyServer(urlString: ServiceConstants.DomainUrlproduct + ServiceConstants.Products + productID, methodType: .get) { (object, response, status, error) in
            if status!{
                let product = parseProductObject(object: object as! [String: Any])
                completionHandler(product,ResponseAction.ShowMesasgeOnAlert,status,error)
                
                
            }
        }
    }
   class func parseProductObject(object : [String:Any]) -> ProductModel {
        let obj = DynamicParser.setValuesOnClass(object: object, classObj: ProductModel()) as! ProductModel
        let reviewArray = object["reviews"] as! [[String:Any]]
        for (_,value) in reviewArray.enumerated() {
        obj.reviewsArray.append(ReviewsModel.parseReviewsObject(object: value))
        }
        return obj
    }
    
    
}
