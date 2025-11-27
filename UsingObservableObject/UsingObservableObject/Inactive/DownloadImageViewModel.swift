//
//  DownloadImageViewModel.swift
//  UsingObservableObject
//
//  Created by Sanny on 2025/11/25.
//
import Foundation
import UIKit
import Combine

class DownloadImageViewModel: ObservableObject {
    @Published var uiImage: UIImage?
    @Published var error: Error?
    var downloader: ImageDownloader = ImageDownloader()
    private var cancellableSet = Set<AnyCancellable>()
    
    func fetchImageWithCombine(from urlString: String) {
        downloader.fetchImageWithCombine(urlString)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self?.error = error
                }
            } receiveValue: { [weak self] image in
                self?.uiImage = image
            }
            .store(in: &cancellableSet)

    }
}
