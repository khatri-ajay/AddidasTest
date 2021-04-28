//
//  ProductListViewController.swift
//  AddidasTest
//
//  Created by Ajay Kumar on 27/04/2021.
//

import UIKit

class ProductListViewController: BaseViewController {
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var Products = [ProductModel]()
    var contentArray = [ProductModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.searchBar.placeholder = "Search"
        
        self.searchBar.setTextColor(color: .black)
        self.searchBar.setPlaceholderTextColor(color: .black)
        self.searchBar.setTextFieldColor(color: .clear)
        self.searchBar.setSearchImageColor(color: .black)
        self.searchBar.setTextFieldClearButtonColor(color: .black)
        self.searchBar.backgroundColor = .systemBlue
        setup()
        registerNibs()
        
        
        // Do any additional setup after loading the view.
    }
    func setup() {
        weak var weakSelf = self
        ProductModel.getProducts { (objectArray, action, status, error) in
            if status!{
                weakSelf?.Products = objectArray
                weakSelf?.reloadTableView()
            }
        }
    }
    func registerNibs()  {
        for cell in [ ProductListTableViewCell.nameOfClass()]{
            let cellNib = UINib(nibName: cell, bundle: nil)
            tableView.register(cellNib, forCellReuseIdentifier: cell)
        }
    }
    func reloadTableView()  {
        contentArray = Products
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.reloadData()
        tableView.layoutIfNeeded()
    }
    func searchInlist(text: String) -> [ProductModel] {
        if text == "" {
            return Products
        }
        var tempArray = Products.filter{ $0.name.containsIgnoringCase(find: text) || $0.Description.containsIgnoringCase(find: text)}
        
        return tempArray
    }

    

}
extension ProductListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let object = contentArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductListTableViewCell.nameOfClass(), for: indexPath)
        
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none
        cell.tag = indexPath.row
        
        switch cell {
        case is ProductListTableViewCell:
            let cellobj = cell as! ProductListTableViewCell
            cellobj.intlizer(product: object)
            break
       

            
        default:
            break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushViewController(controllerIdentifier: ProductDetailViewController.nameOfClass(), navigationTitle: "",conditons: contentArray[indexPath.row].id)
    }
    
    
}
extension ProductListViewController : UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //searchActive = true;
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        searchActive = false;
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        //searchActive = false;
        self.view.endEditing(true)
        contentArray = Products
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //searchActive = false;
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        contentArray = searchInlist(text: searchText)
        self.tableView.reloadData()
    }
    
}
