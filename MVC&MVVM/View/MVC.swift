//
//  ViewController.swift
//  MVC&MVVM
//
//  Created by Nagaraju on 31/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tblProduct:UITableView!
    
    let apiService =  APIServices()
    
    var product = [Product]()
    
    let cellIdentifier = "tblCellProductDetails"
    
    var dataSource: TableViewDataSource<Product>?
  
    var delegate: TableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadTblData()
        IntilizationMVC()
        
    }
    
    //MARK: - LoadDataTableView
    func LoadTblData() {

        ///Register Method
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        tblProduct.register(nib, forCellReuseIdentifier: cellIdentifier)
        
        ///Data source method calling
        dataSource = TableViewDataSource(data: product, cellIdentifier: cellIdentifier, numberOfSections: 2, heightForRow: 130, configureCell: { (cell, item) in
            if let customCell = cell as? tblCellProductDetails {
                customCell.lblTitle.text = item.title
                customCell.lbldescription.text = item.description
                customCell.lblprice.text = String(item.price)
                customCell.selectionStyle = .none
                
                if let imageURL = URL(string: item.thumbnail) {
                    ImageDownloader.downloadImage(from: imageURL) { [weak self] image in
                        guard let self = self else {return}
                        DispatchQueue.main.async {
                            customCell.imgThumbline?.image = image
                        }
                    }
                }
            }
        })
       
        ///Deleage Did Selecte
        delegate = TableViewDelegate { [weak self] indexPath in
            guard let self = self else {return}
            // Handle row selection if needed
            print("Selected row at \(indexPath.row)")
        }
        
        tblProduct.dataSource = dataSource
        tblProduct.delegate = delegate
        
    }
    
    //MARK: - apiService
    
    func IntilizationMVC() {
        ///apiservice Response to update tableview
        apiService.loadApidata(url: URL(string: "https://dummyjson.com/products")!,completion: { [weak self] resposne in
            DispatchQueue.main.async{
                switch(resposne){
                case .failure(let error):
                    print("error asing\(error)")
                case .success(let data):
                    self?.product = data
                    self?.dataSource?.data = data
                }
                self?.tblProduct.reloadData()
            }
            
        })
    }
}
