//
//  UserEntity+Extensions.swift
//  UsingObservableObject
//
//  Created by Sanny on 2025/11/21.
//

extension UserEntity {
    private static var imageCache = ImageCache.shared
    
    var viewFirstName: String {
        firstName ?? "N/A"
    }
    
    var viewLastName: String {
        lastName ?? "N/A"
    }
    
    var viewFullname: String {
        "\(firstName ?? "N/A") \(lastName ?? "N/A")"
    }
    
    var viewImageURL: String {
        imageURL ?? "https://dummyjson.com/icon/emilys/128"
    }
}

/* 不会使用异步的方法来获取
 var viewImageWithAsyncAndAwait: UIImage {

     get async {
         if let urlString = imageURL {
             do {
                 return try await fetchImageWithAsyncAndAwait(urlString)
             } catch {
                 print(error.localizedDescription)
             }
         }
         return UIImage(systemName: "photo")!
     }
 }
 
 
 /// 不知道怎么调用，等我知道了我再来写
 private func fetchImageWithAsyncAndAwait(_ urlString: String) async throws -> UIImage {
     // 检查缓存
     if let cachedImage = ImageCache.shared.getImage(forKey: urlString) {
         return cachedImage
     }
     
     // 网络获取：新图片
     do {
         // 检查链接
         guard let url = URL(string: urlString) else {
             throw URLError(.badURL)
         }
         // 获取数据 + 网络响应
         let (data, response) = try await URLSession.shared.data(from: url)
         // 检查网络响应
         guard let response = response as? HTTPURLResponse,
               response.statusCode == 200 else {
             throw URLError(.badServerResponse)
         }
         
         // data -> UIImage
         guard let uiImage = UIImage(data: data) else {
             throw URLError(.cannotDecodeContentData)
         }
         
         // 保存到缓存
         ImageCache.shared.setImage(uiImage, forKey: urlString)
         
         return uiImage
     } catch {
         throw error
     }
 }
 
 */
