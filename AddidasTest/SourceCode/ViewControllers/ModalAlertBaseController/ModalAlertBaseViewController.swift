//
//  ModalAlertBaseViewController.swift
//  SeatUs
//
//  Created by Qazi Naveed Ullah on 10/24/17.
//  Copyright © 2017 Qazi Naveed. All rights reserved.
//

import UIKit

class ModalAlertBaseViewController: UIViewController {

    @IBOutlet weak var yAxisConstrint: NSLayoutConstraint!
    var selectedData:[String:AnyObject]! = [:]
    var cancelButtonTapped: (([String:AnyObject])->())?
    var okButtonTapped: (([String:AnyObject])->())?

    
    var viewControllerObject : UIViewController!
    var serviceStatus :Bool! = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        if (yAxisConstrint) != nil{
            yAxisConstrint.constant = ApplicationConstants.ForgotDialogOriginY
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (yAxisConstrint) != nil{
            performAnimation(axis: ApplicationConstants.ForgotDialogCenterY)
        }
    }

    
    static func createAlertController(storyboardId:String)->ModalAlertBaseViewController {
        
        let alertController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: storyboardId) as! ModalAlertBaseViewController
        return alertController
    }

    @objc func performAnimation(axis:CGFloat){
        self.yAxisConstrint.constant=axis
        
        UIView.animate(withDuration: 1, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: UIView.AnimationOptions.curveEaseInOut, animations: ({
            self.view.layoutIfNeeded()
            
        }), completion: { _ in
        })
    }

  
    func show(controller:UIViewController) {

        viewControllerObject = controller
        controller.addChild(self)
        controller.view.addSubview(self.view)
        controller.didMove(toParent: self)

    }
    @objc func close() {
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func closeByAlertMessage() {
        
        dismiss(animated: true, completion: nil)
        if serviceStatus {
            okButtonTapped?(selectedData)
        }
        else{
            cancelButtonTapped?(selectedData)
        }
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func alertOkButtonHandler(){
    
    }
    @objc func alertYesNoButtonHandler(){
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
