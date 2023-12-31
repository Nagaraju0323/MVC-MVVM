//
//  ImageDownload.swift
//  MVC&MVVM
//
//  Created by Nagaraju on 31/12/23.
//

import Foundation
import UIKit


import UIKit

class ImageDownloader {
    
    static func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error downloading image: \(error)")
                completion(nil)
                return
            }

            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}
