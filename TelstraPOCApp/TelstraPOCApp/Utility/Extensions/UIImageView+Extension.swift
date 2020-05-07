//
//  UIImageView+Extension.swift
//  TelstraPOCApp
//
//  Created by Nikhil Wagh on 06/05/20.
//  Copyright © 2020 Tech Mahindra. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    /// This method download and cache images from URL
    /// - Parameters:
    ///   - URLString: url to download image
    ///   - placeHolder: placeholder image
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage?) {
        
        let imageCache = NSCache<NSString, UIImage>()
        
        self.image = #imageLiteral(resourceName: "placeholder")
        let imageServerUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let cachedImage = imageCache.object(forKey: NSString(string: imageServerUrl)) {
            self.image = cachedImage
            return
        }
        
        if let url = URL(string: imageServerUrl) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: imageServerUrl))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
