//
//  DetailView.swift
//  BaedalChaek
//
//  Created by 권은빈 on 2023/02/07.
//

import SwiftUI

struct DetailView: View {
    
    let imageURL: URL?
    
    var body: some View {
        AsyncImage(url: imageURL) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(
            imageURL: URL(
                string: "https://modo-phinf.pstatic.net/20191123_71/1574507078498wuw2I_JPEG/mosa5nWMK7.jpeg?type=w720"
            )
        )
    }
}
