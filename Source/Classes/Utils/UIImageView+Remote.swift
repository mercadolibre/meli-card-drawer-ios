//
//  UIImageView+Remote.swift
//  MLCardDrawer
//
//  Created by Juan sebastian Sanzone on 10/22/19.
//

import Foundation

// codebeat:disable
internal extension UIImageView {
    func getRemoteImage(imageUrl: String, success:((UIImage)->Void)? = nil) {
        guard let url = URL(string: imageUrl) else { return }
        let cache = URLCache.shared
        let request = URLRequest(url: url)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            success?(image)
            #if DEBUG
                print("Retrieve image from Cache")
            #endif
        } else {
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if let data = data, let response = response, ((response as? HTTPURLResponse)?.statusCode ?? 500) < 300, let image = UIImage(data: data) {
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    #if DEBUG
                        print("Retrieve image from Network")
                    #endif
                    success?(image)
                }
            }).resume()
        }
    }
}
