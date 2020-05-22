//
//  ImageLoader.swift
//  CountrysList
//
//  Created by Emmanuel Anaya on 21/05/20.
//  Copyright © 2020 Emmanuel Anaya. All rights reserved.
//

import SwiftUI
import Combine

struct ImageView: View {
    @ObservedObject var imageLoader : ImageLoader
    @State var image:UIImage = UIImage()

    var width : CGFloat
    var height : CGFloat
    var type : Int

    init(withURL url:String, width: CGFloat, height: CGFloat, type: Int) {
        imageLoader = ImageLoader(urlString:url)
        self.width = width
        self.height = height
        self.type = type
    }

    func imageFromData(_ data:Data) -> UIImage {
        UIImage(data: data) ?? UIImage()
    }

    var body: some View {
        VStack {
            if type == 1 {
                Image(uiImage: imageLoader.dataIsValid ? imageFromData(imageLoader.data!) : UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:self.width, height:self.height)
            }
            else{
                Image(uiImage: imageLoader.dataIsValid ? imageFromData(imageLoader.data!) : UIImage())
                    .resizable()
                    .clipShape(Circle())
                    .aspectRatio(contentMode: .fill)
                    .frame(width:self.width, height:self.height)
                    .overlay(Circle().stroke(Color.gray, lineWidth: 4))
                    .shadow(radius: 10)
            }
        }.onReceive(imageLoader.didChange) { data in
            self.image = UIImage(data: data) ?? UIImage()
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var dataIsValid = false
    var data:Data?
    var didChange = PassthroughSubject<Data, Never>()

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.dataIsValid = true
                self.data = data
            }
        }
        task.resume()
}

    func imageFromData(_ data:Data) -> UIImage {
        UIImage(data: data) ?? UIImage()
    }

}
