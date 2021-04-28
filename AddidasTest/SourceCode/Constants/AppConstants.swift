//
//  ViewController.swift
//  AddidasTest
//
//  Created by Ajay Kumar on 27/04/2021.
//

import Foundation
import UIKit

struct ServiceConstants{
    static let DomainUrlReviews                        = "http://localhost:3002/"
    static let DomainUrlproduct                        = "http://localhost:3001/"
    
    
    // user services
    static let Services                         = "app/services"
    static let Products                         = "product/"
    static let addReview                         = "reviews/"
    
    
    
}


struct ApplicationConstants {
    static let NavigationControllerID                        = "NavigationController"
    static let DashboardNavigationControllerID               = "NavigationControllerDashboard"
    static let ForgotDialogOriginY: CGFloat                  =  -1000.0
    static let ForgotDialogCenterY: CGFloat                  =  0
}

struct ScreenNames{
    
    static let PhoneVerifyScreenTitle = "VERIFY PHONE"
}




struct WarningMessages{
    
    static let LogoutAlertMessage                           = "Are you sure you want to signout ?"
    static let WishListRemoveMessage                        = "Are you sure you want to remove it ?"
    static let PastDateMessage                              = "Please select past date"
    static let CameraWarning                                = "You have disallowed camera access.  Please navigate to phone settings and allow app access to the camera."
    static let LocationWarning                              = "You have disallowed location access.  Please navigate to phone settings and allow app access to the location."
    static let MicroPhoneWarning                            = "You have disallowed microphone access.  Please navigate to phone settings and allow app access to the location."

    static let ImageValidationMessageOnProfileCreation      = "Kindly select profile picture"
    static let EventMandatoryVideo                          = "Please Select Video"
    static let CreatePostWarningMessage                     = "Please Enter Text or Select any image"
    static let StudyAidWrongUrlMessage                      = "Only Youtube/vimeo links allowed."
    static let DeleteMessageStudyAid                        = "Are you sure you want to delete this item."
    static let DeleteMessageCard                        = "Are you sure you want to delete this item."
    static let DeleteMessageChildDel                        = "Are you sure you want to delete this Child."
}
struct serviceEroorMessage {
    static let ProblemOccur = "There is a problem adding review for this product please try later."
}


public enum HTTPMethods: String {
    case ptions = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}


enum ResponseAction:Int{
    case ShowMesasgeAtRunTime                = 0
    case DoNotShowMesasgeAtRunTime           = 1
    case ShowMesasgeOnAlert                  = 2
}


enum ImageType: String {
    case png
    case jpeg
}
