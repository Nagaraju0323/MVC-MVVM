//
//  tblCellProductDetails.swift
//  MVC&MVVM
//
//  Created by Nagaraju on 31/12/23.
//

import UIKit

class tblCellProductDetails: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lbldescription: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var imgThumbline: UIImageView? {
        didSet {
            
            if let imageView = imgThumbline {
                imageView.layer.cornerRadius = imageView.frame.size.width / 2
                imageView.clipsToBounds = true
            }
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
