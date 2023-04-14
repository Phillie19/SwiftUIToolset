//
//  CacheableImageVM.swift
//  
//
//  Created by Philipp Pereverzev on 14.04.2023.
//

import Foundation
import SwiftUI

open class CacheableImageModel: ObservableObject {
    @Published public var image: UIImage?
    var imageCache = ImageCache.getImageCache()
    var url: String?
    
    public init(url: String?) {
        self.url = url
        loadImage()
    }
    
    func loadImage() {
        if loadImageFromCache() {
             return
        }
        loadImageFromUrl()
     }
    
    func loadImageFromCache() -> Bool {
        guard let urlString = url else {
            return false
        }
        guard let cacheImage = imageCache.get(forKey: urlString) else {
            return false
        }
        image = cacheImage
        return true
    }
    
    func loadImageFromUrl() {
        guard let urlString = url else {
            return
        }
        
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url, completionHandler: getImageFromResponse(data:response:error:))
        task.resume()
    }
    
    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            return
        }
        guard let data = data else {
            print("No data found")
            return
        }
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                return
            }
            self.imageCache.set(forKey: self.url!, image: loadedImage)
            self.image = loadedImage
        }
    }
}
    
internal class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
