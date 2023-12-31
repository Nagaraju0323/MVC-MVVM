//
//  MVVM.swift
//  MVC&MVVM
//
//  Created by Nagaraju on 31/12/23.
//

import Foundation
import UIKit


class MVVMViewController:UIViewController {
    
    @IBOutlet weak var tblProducts: UITableView!
    
    let cellIdentifier = "tblCellProductDetails"
    
    var viewModel = APIServicesViewModel()
    
    var dataSource: TableViewDataSource<Product>?
   
    var delegate: TableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        loadTableView()
      
        initializeMVC()
    }
    
    func loadTableView() {
        let nib = UINib(nibName: cellIdentifier, bundle: nil)
        tblProducts.register(nib, forCellReuseIdentifier: cellIdentifier)
        
        dataSource = TableViewDataSource(data: viewModel.products, cellIdentifier: cellIdentifier, numberOfSections: 1, heightForRow: 130, configureCell: { (cell, item) in
          
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
        
        delegate = TableViewDelegate { [weak self] indexPath in
            guard let self = self else {return}
            // Handle row selection if needed
            print("Selected MMVM row at \(indexPath.row)")
        }
        
        tblProducts.dataSource = dataSource
        tblProducts.delegate = delegate
    }
    
    func initializeMVC() {
        viewModel.dataDidChange = { [weak self] in
            DispatchQueue.main.async {
                self?.dataSource?.data = self?.viewModel.products ?? []
                self?.tblProducts.reloadData()
            }
        }
        
        viewModel.errorDidChange = { [weak self] in
            guard let self = self else {return}
            // Handle error UI updates if needed
            ///Errror handling
        }
        
        viewModel.loadApidata(url: URL(string: "https://dummyjson.com/products")!)
    }
}

