//
//  ProductDetailViewController.swift
//  AddidasTest
//
//  Created by Ajay Kumar on 28/04/2021.
//

import UIKit

class ProductDetailViewController: BaseViewController {
    @IBOutlet weak var productImage : UIImageView!
    @IBOutlet weak var productNameLabel : UILabel!
    @IBOutlet weak var productPriceLabel : UILabel!
    @IBOutlet weak var productDescLabel : UILabel!
    @IBOutlet weak var tableview : UITableView!
    @IBOutlet weak var addReviewButton  : UIButton!
    var Product = ProductModel()
    var productID = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        registerNibs()
        getProduct()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    func registerNibs()  {
        for cell in [ ProductReviewTableViewCell.nameOfClass()]{
            let cellNib = UINib(nibName: cell, bundle: nil)
            tableview.register(cellNib, forCellReuseIdentifier: cell)
        }
    }
    func reloadTableView()  {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.reloadData()
        tableview.layoutIfNeeded()
    }
    func setup() {
        reloadTableView()
        if let image = Product.imgurl{
            productImage.af_setImage(withURL: URL(string: image)!)
        }
        if let name = Product.name {
            productNameLabel.text = name
        }
        if let disc = Product.Description {
            productDescLabel.text = disc
        }
        if let price = Product.price {
            productPriceLabel.text = Product.currency + price.stringValue
        }
        addReviewButton.layer.cornerRadius = 5
        
        
    }
    func getProduct() {
        weak var weakSelf = self
        ProductModel.getProduct(productID: productID) { (object, action, status, error) in
            if status!{
                weakSelf?.Product = object
                weakSelf?.setup()
            }
        }
    }
    func getReview() {
        
    }
    @IBAction  func addReviewTapped(_ sender: UIButton)  {
        presentAlertOnModalViewController(controllerIdentifier: AddRatingViewController.nameOfClass(),object: Product.id) { (object) in
            
        }
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Product.reviewsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = Product.reviewsArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductReviewTableViewCell.nameOfClass(), for: indexPath)
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        cell.tag = indexPath.row
        
        switch cell {
        case is ProductReviewTableViewCell:
            let cellobject = cell as! ProductReviewTableViewCell
            cellobject.intlizer(object: object)
            break
        
            
        default:
            break
        }
        return cell
    }
    
    
}
