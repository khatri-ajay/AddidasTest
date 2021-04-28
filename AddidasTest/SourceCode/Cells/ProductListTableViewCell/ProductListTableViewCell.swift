//
//  ProductListTableViewCell.swift
//  AddidasTest
//
//  Created by Ajay Kumar on 27/04/2021.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {
    @IBOutlet weak var itemImage : UIImageView!
    @IBOutlet weak var Name : UILabel!
    @IBOutlet weak var Details : UILabel!
    @IBOutlet weak var price : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        itemImage.image = UIImage(named: "PlaceholderImage")
        Name.text = "n/a"
        Details.text = "n/a"
        price.text = "n/a"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func intlizer(product: ProductModel) {
        if let name = product.name{
            Name.text = name.capitalized
        }
        if let details = product.Description{
            Details.text = details
        }
        if let priceNum = product.price{
            price.text = product.currency + String(describing: priceNum)
        }
        if let url = product.imgurl{
            itemImage.af_setImage(withURL: URL(string: url)!)
        }
//        Name.text = product.name.capitalized
//        Details.text = product.Description
//        price.text = product.currency + String(describing: product.price!)
//        itemImage.af_setImage(withURL: URL(string: product.imgurl)!)
       
    }
    
}
