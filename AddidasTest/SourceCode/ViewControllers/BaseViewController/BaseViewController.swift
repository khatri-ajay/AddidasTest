//
//  ProductListViewController.swift
//  AddidasTest
//
//  Created by Ajay Kumar on 27/04/2021.
//

import UIKit
import AlamofireImage
import AVKit
import AVFoundation


class BaseViewController: UIViewController {
    
    // MARK: - BaseViewController helper methods
    
    var visionImageView : UIImageView!
    var serviceStatus: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setLeftBarButtons()
        
        //addLeftSwipeGesture()
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
//    override var prefersStatusBarHidden: Bool {
//        return false
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        
        setLeftBarButtons()
                
    }
   
   @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
    switch gesture.direction {
    case .right:
        
        if self.navigationController != nil{
            if self.navigationController!.viewControllers.count > 1 {
                backButtonClicked(sender: UIButton())
            }
        }
    default:
        break
    }
    }
    
    
    
    
   
    
    // push controller to Navigation Stack
    func pushViewController(controllerIdentifier:String, navigationTitle: String, conditons: Any = ""){
        
        let  controller = self.storyboard?.instantiateViewController(withIdentifier: controllerIdentifier)
        controller?.navigationItem.title = navigationTitle
        
        switch (controller){
        case is ProductDetailViewController:
            let controllerObj = controller as! ProductDetailViewController
            controllerObj.productID = conditons as! String
            break
        
        default:
            break
        }
        
        navigationController?.pushViewController(controller!, animated: true)
    }

    func presentAlertOnModalViewController(controllerIdentifier:String, navigationTitle: String = "" ,object: Any = "",compilationBlock: @escaping ((_ object: [String:Any]?)->())){
        
        let cont = ModalAlertBaseViewController.createAlertController(storyboardId: controllerIdentifier)
        cont.modalPresentationStyle = .overCurrentContext
        self.navigationController?.modalPresentationStyle = .currentContext;
        
        
        switch(cont){
        case is AddRatingViewController:
            let controllObj = cont as! AddRatingViewController
            controllObj.prodcutID = object as! String
            break

            
        default:
            break
        }
        
        navigationController?.present(cont, animated: false, completion: {
        })
        
        cont.cancelButtonTapped = { selectedData in
            print("cancelButtonTapped")
            compilationBlock(nil)
        }
        
        cont.okButtonTapped = { selectedData in
            print("selectButtonTapped")
            compilationBlock(selectedData)
        }
    }
  
    

    
    func setLeftBarButtons(){
        
        if self.navigationController != nil{
            let leftBarButton: UIButton!
            if self.navigationController!.viewControllers.count > 1 {
                leftBarButton = getBackButton()
            }
            else{
                leftBarButton = UIButton()
            }
            let barButton = UIBarButtonItem.init(customView: leftBarButton)
            self.navigationItem.leftBarButtonItem = barButton
        }
    }
    
    
    func getBackButton()->UIButton{
        
        let backButton = UIButton.init(type: .custom)
        backButton.setImage(UIImage.init(named: "BackButtonIcon"), for: UIControl.State.normal)
        backButton.addTarget(self, action:#selector(backButtonClicked(sender:)), for: UIControl.Event.touchUpInside)
        backButton.frame = CGRect.init(x: 0, y: 0, width: 30, height: 30)
        return backButton
    }
    
    @objc func backButtonClicked(sender: UIButton){
        navigationController?.popViewController(animated: true)
    }

    
    
    
    
   
    
  
  
    
    @objc func enableWithDelay(){
        self.navigationItem.leftBarButtonItem?.isEnabled = true
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getController(controllerId:String)->(UIViewController){
        return (self.storyboard?.instantiateViewController(withIdentifier:controllerId))!
    }
    
    // MARK: - Ok Button PopUp handler
    @objc func alertOkButtonHandler(){
        print("calling alertOkButtonHandler from BaseViewController")
    }
    @objc func alertYesNoButtonHandler(){
        print("calling alertYesNoButtonHandler from BaseViewController")
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Navigation Bar Helper Methods
    // make Navigation bar transparent and added image on background of window
    
    
    func addImageViewToWindow(){
        
        // adding imageview to window to achieve desired design
        let window = UIApplication.shared.keyWindow!
        
        // check if image is already added
        let viewTemp = window.viewWithTag(110)
        
        if viewTemp == nil {
            
            let bgImageView = UIImageView(frame: CGRect(x: window.frame.origin.x, y: window.frame.origin.y, width: window.frame.width, height: window.frame.height))
            bgImageView.tag = 110
//            bgImageView.image = UIImage(named: AssetsName.BackGroundImage)
           
            window.addSubview(bgImageView)
            
            // sending window image on back
            window.sendSubviewToBack(bgImageView)
        }
    }
    
    func removeImageViewFromWindow(){
        
        let window = UIApplication.shared.keyWindow!
        for (_,view) in window.subviews.enumerated(){
            
            if view.tag == 110 {
                view.removeFromSuperview()
            }
        }
    }
    
    func addVisionImageView(){
        
        let window = UIApplication.shared.keyWindow!
        
        visionImageView = UIImageView(frame: CGRect(x: window.frame.origin.x, y: window.frame.origin.y, width: window.frame.width, height: window.frame.height))
//        visionImageView.image = UIImage(named: AssetsName.BackGroundImage)
//        visionImageView.backgroundColor = AppColors.DarkGrayViewBorder
        
        view.addSubview(visionImageView)
        view.sendSubviewToBack(visionImageView)
    }
    
    func removeVisionImageView(){
        if visionImageView != nil {
            visionImageView.removeFromSuperview()
        }
    }
    
    func setViewColorToClear(){
        view.backgroundColor = UIColor.clear
    }
}

// usually i put in seprate files in ext folder but for now i m add these here
extension NSObject {
    static func nameOfClass() -> String {
        return NSStringFromClass(self as AnyClass).components(separatedBy: ".").last!
    }
}
extension String {
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}
extension UISearchBar {
    
    private func getViewElement<T>(type: T.Type) -> T? {
        
        let svs = subviews.flatMap { $0.subviews }
        guard let element = (svs.filter { $0 is T }).first as? T else { return nil }
        return element
    }
    
    func getSearchBarTextField() -> UITextField? {
        
        return getViewElement(type: UITextField.self)
    }
    
    func setTextColor(color: UIColor) {
        
        if let textField = getSearchBarTextField() {
            textField.textColor = color
        }
    }
    
    func setTextFieldColor(color: UIColor) {
        
        if let textField = getViewElement(type: UITextField.self) {
            switch searchBarStyle {
            case .minimal:
                textField.layer.backgroundColor = color.cgColor
                textField.layer.cornerRadius = 6
                
            case .prominent, .default:
                textField.backgroundColor = color
            }
        }
    }
    
    func setPlaceholderTextColor(color: UIColor) {
        
        if let textField = getSearchBarTextField() {
            textField.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder! : "", attributes: [NSAttributedString.Key.foregroundColor: color])
        }
    }
    
    func setTextFieldClearButtonColor(color: UIColor) {
        
        if let textField = getSearchBarTextField() {
            
            let button = textField.value(forKey: "clearButton") as! UIButton
            if let image = button.imageView?.image {
                button.setImage(image.transform(withNewColor: color), for: .normal)
            }
        }
    }
    
    func setSearchImageColor(color: UIColor) {
        
        if let imageView = getSearchBarTextField()?.leftView as? UIImageView {
            imageView.image = imageView.image?.transform(withNewColor: color)
        }
    }
}
extension UIImage {
    
    func transform(withNewColor color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(.normal)
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: rect, mask: cgImage!)
        
        color.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}

