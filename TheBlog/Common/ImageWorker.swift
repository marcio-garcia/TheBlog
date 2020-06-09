//
//  ImageWorker.swift
//  TheBlog
//
//  Created by Marcio Garcia on 07/06/20.
//  Copyright (c) 2020 Oxl Tech. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import Ivorywhite

typealias RequestId = TaskId

protocol ImageWorkLogic: class {
    func download(with url: URL, completion: @escaping (UIImage?) -> Void) -> RequestId?
    func cancelDownload(requestId: RequestId)
}

class ImageWorker: ImageWorkLogic {
    
    private var service: NetworkService
    private var imageCache: NSCache = NSCache<NSString, UIImage>()
    
    // MARK: Object Lifecycle
    
    init(service: NetworkService) {
        self.service = service
    }
    
    // MARK: AuthorsListWorkLogic
    
    func cachedImage(for key: String) -> UIImage? {
        if let cachedImage = imageCache.object(forKey: key as NSString) {
            return cachedImage
        }
        return nil
    }
    
    func download(with url: URL, completion: @escaping (UIImage?) -> Void) -> RequestId? {
        if let image = cachedImage(for: url.absoluteString) {
            // Debug print not needed in production
            // It is here just to make it clear if the image is being retrived from the cache or the server
            debugPrint("Getting image from cache")
            completion(image)
            return nil
        } else {
            // Debug print not needed in production
            // It is here just to make it clear if the image is being retrived from the cache or the server
            debugPrint("Requesting image from server")
            let requestId = service.request(with: url) { [weak self] result in
                switch result {
                case .success(let response):
                    guard let data = response.value, let image = UIImage(data: data) else {
                        completion(nil)
                        return
                    }
                    self?.imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    completion(image)
                case .failure:
                    completion(nil)
                }
            }
            return requestId
        }
    }
    
    func cancelDownload(requestId: RequestId) {
        service.cancel(taskId: requestId)
    }
}
