//
//  ImageCache.swift
//  Cocktails
//
//  Created by Johan Forsell on 2022-07-12.
//

import Foundation
import UIKit

final class ImageCache {
    private let cachedImages = NSCache<NSURL, UIImage>()
    private let loader: ImageLoader
    
    init(loader: ImageLoader = ImageLoader()) {
        self.loader = loader
    }
    
    private func image(url: NSURL) -> UIImage? {
        cachedImages.object(forKey: url)
    }
    
    func load(url: NSURL) async throws -> UIImage {
        if let cachedImage = image(url: url) {
            return cachedImage
        }
        
        let image = try await loader.fetch(url as URL)
        
        cachedImages.setObject(image, forKey: url)
        
        return image
    }
}
