//
//  SwiftUIView.swift
//  CountrysList
//
//  Created by Emmanuel Anaya on 21/05/20.
//  Copyright © 2020 Emmanuel Anaya. All rights reserved.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI
import SDWebImageSVGCoder

struct SwiftUIView: View {
    @State var countries: [Country] = []
    let url = URL(string: "https://s5.gifyu.com/images/ubrellagif.gif")!

    var body: some View {

                List(countries) { country in
                    AnimatedImage(url: URL(string:country.flag))
                    .indicator(SDWebImageActivityIndicator.medium)
                    /**
                    .placeholder(UIImage(systemName: "photo"))
                    */
                    .transition(.fade)
                    .resizable()
                    .scaledToFit()
                    .frame(width: CGFloat(60), height: CGFloat(60), alignment: .center)
                    Text(country.name)
                
        
                }
                .onAppear(){
                    Api().getCountry{ (countries) in
                        self.countries = countries
                    }
                }
        }

    }


struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
