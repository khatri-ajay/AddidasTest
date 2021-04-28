//
//  AddRatingViewController.swift
//  AddidasTest
//
//  Created by Ajay Kumar on 28/04/2021.
//

import UIKit
import STRatingControl

class AddRatingViewController: ModalAlertBaseViewController {
    @IBOutlet weak var saveBUtton : UIButton!
    @IBOutlet weak var ratingView : STRatingControl!
    @IBOutlet weak var messageTextView : UITextView!
    var prodcutID = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextView.delegate = self
        messageTextView.text = "Enter text"
        messageTextView.textColor = UIColor.lightGray
        messageTextView.layer.cornerRadius = 5
        saveBUtton.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    @IBAction func leftButtonClicked(_ sender: Any) {
        saveRating()
    }
   @IBAction func closeTapped(_ sender: UIButton) {
        self.close()
    }
    func saveRating() {
        if messageTextView.textColor == UIColor.lightGray {
            messageTextView.text = ""
        }
        let param: [String:Any] = [
            "productId":prodcutID,
            "locale":"en",
            "rating":ratingView.rating,
            "text":messageTextView.text ,
        ]
        ReviewsModel.AddReview(id: prodcutID, param: param) { (object , action, status, error) in
            if status!{
                utility.showAlertwithOkButton(message: "Review Has Been added", controller: self)
            }else{
                utility.showAlertwithOkButton(message: serviceEroorMessage.ProblemOccur, controller: self)
            }
        }
        
    }
    
    override func alertOkButtonHandler() {
        self.close()
    }

}
extension AddRatingViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            messageTextView.text = "Enter text"
            messageTextView.textColor = UIColor.lightGray
        }
    }
}
