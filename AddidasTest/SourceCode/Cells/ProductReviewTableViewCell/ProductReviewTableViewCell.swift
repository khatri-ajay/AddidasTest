//
//  ProductReviewTableViewCell.swift
//  AddidasTest
//
//  Created by Ajay Kumar on 28/04/2021.
//

import UIKit
import STRatingControl

class ProductReviewTableViewCell: UITableViewCell {
    @IBOutlet weak var reviewText : UILabel!
    @IBOutlet weak var reviewStar : STRatingControl!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func intlizer(object : ReviewsModel) {
        if let review = object.text{
            reviewText.text = review
        }
        if let rating = object.rating{
            reviewStar.rating = rating.intValue
        }
    }
    
}
