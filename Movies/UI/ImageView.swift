//
// Copyright (c) Hellen Ferrari. All rights reserved.
//

import SwiftUI
import Combine

struct ImageView: View {
    @StateObject private var imageLoader: ImageLoader

    init(url: URL) {
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }

    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
        } else {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                .onAppear {
                    imageLoader.loadImage()
                }
        }
    }
}
