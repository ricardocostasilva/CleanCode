//
//  ImageView.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import Combine
import SwiftUI

struct ImageView: View {

    @ObservedObject var imageLoader: ImageDownloader

    init(withURL url: String) {
        imageLoader = ImageDownloader(urlString: url)
    }

    var body: some View {
        ZStack {
            Image(uiImage: imageLoader.image ?? UIImage() )
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

