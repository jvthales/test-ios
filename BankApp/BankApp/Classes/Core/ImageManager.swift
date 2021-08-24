//
//  ImageManager.swift
//  Alamofire
//
//  Created by Vinicius Teixeira on 8/24/21.
//

public class ImageManager {
    
    public class func get(_ name: String) -> UIImage {
        let frameworkBundle = Bundle(for: self)
        guard let bundleURL = frameworkBundle.url(forResource: "BankApp", withExtension: "bundle"),
            let bundle = Bundle(url: bundleURL),
            let image = UIImage(named: name, in: bundle, compatibleWith: nil) else {
            fatalError("Failed to load image with name \(name)")
        }
        
        return image
    }
}
