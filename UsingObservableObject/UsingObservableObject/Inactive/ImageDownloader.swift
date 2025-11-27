//
//  ImageDownloader.swift
//  UsingObservableObject
//
//  Created by Sanny on 2025/11/21.
//

import Foundation
import UIKit
import Combine

class ImageDownloader {
//    let urlString: String
//    
//    init(urlString: String) {
//        self.urlString = urlString
//    }
    
    func fetchImageWithCombine(_ urlString: String) -> AnyPublisher<UIImage?, Error> {
        // 检查链接
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap(handleResponse)
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
    
    /// Data数据转换为 UIImage，并检查 网络响应 response
    private func handleResponse(data: Data?, response: URLResponse?) throws -> UIImage? {
        // 检查网络响应
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        // data -> UIImage
        guard let data,
              let uiImage = UIImage(data: data) else {
            throw URLError(.cannotDecodeContentData)
        }
        
        // 保存到缓存
//        ImageCache.shared.setImage(uiImage, forKey: urlString)
        
        return uiImage
    }
}
