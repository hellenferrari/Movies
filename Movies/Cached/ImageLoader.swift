//
// Copyright (c) Hellen Ferrari. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?
    private let url: URL

    private static var cache = NSCache<NSURL, UIImage>()

    init(url: URL) {
        self.url = url
    }

    func loadImage() {
        if let cachedImage = Self.cache.object(forKey: url as NSURL) {
            image = cachedImage
        } else {
            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .compactMap { UIImage(data: $0) }
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] loadedImage in
                    guard let self = self, let loadedImage = loadedImage else { return }
                    Self.cache.setObject(loadedImage, forKey: self.url as NSURL)
                    self.image = loadedImage
                }
        }
    }
}



