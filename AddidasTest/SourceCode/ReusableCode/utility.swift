//
//  utility.swift
//  AddidasTest
//
//  Created by Ajay Kumar on 28/04/2021.
//

import UIKit

class utility {
    class func showAlertwithOkButton(message: String , controller: AnyObject){
        
        
        var genericController = controller
        
        
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action -> Void in
            //Just dismiss the action sheet
            let selector: Selector = NSSelectorFromString("alertOkButtonHandler")
            if genericController.responds(to: selector){
                _ = genericController.perform(selector)
            }
        })
        alert.addAction(okAction)
        controller.present(alert, animated: false, completion: nil)
    }

}
