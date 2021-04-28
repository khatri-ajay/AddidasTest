//
//  ProductListViewController.swift
//  AddidasTest
//
//  Created by Ajay Kumar on 27/04/2021.
//

import Foundation
import UIKit

class DynamicParser{
   
    class func setValuesOnClass(object:[String:Any] ,classObj:NSObject)->NSObject{
        
        for (key,value) in object {
            if !(value is NSNull){
    
                let selector: Selector = NSSelectorFromString(getSelectorString(key: key))
               //print(getSelectorString(key: key))
               //print(value)
                if classObj.responds(to: selector){
                    classObj.perform(selector, with: value)
                }
            }
        }
        return classObj
    }
    
    class func getSelectorString(key:String)->String{
        
        var upperCaseKeyString: String = (key as NSString).substring(to: 1)
        upperCaseKeyString = upperCaseKeyString.uppercased()
        var lowerCaseKeyString = (key as NSString).substring(from: 1)
        lowerCaseKeyString = lowerCaseKeyString.lowercased()
        
        let selectorString = "set" + upperCaseKeyString + lowerCaseKeyString + ":"
        return selectorString
    }
}

