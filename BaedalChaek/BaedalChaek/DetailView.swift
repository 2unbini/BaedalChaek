//
//  DetailView.swift
//  BaedalChaek
//
//  Created by 권은빈 on 2023/02/07.
//

import SwiftUI

// MARK: - ScrollView안의 contentView의 프레임 사이즈가 변경되지 않는 문제!! 뭘까..
// AsyncImage의 문제인지 확인해보기
// 제스처/탭에 따라 contentSize를 정상적으로 변경할 수 있도록 해보기!!

struct DetailView: View {
    
    let imageURL: URL?
    
    var body: some View {
        GeometryReader { proxy in
            Rectangle()
                .foregroundColor(.black)
                .overlay {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                }
                .modifier(ZoomableModifier(contentSize: proxy.size))
        }
    }
}

struct ZoomableModifier: ViewModifier {
    
    @GestureState private var magnifyBy: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    
    private let min: CGFloat = 1.0
    private let max: CGFloat = 2.0
    
    private var contentSize: CGSize
    private var frameScale: CGFloat {
        return self.lastScale * self.magnifyBy
    }
    
    private var zoomGesture: some Gesture {
        return MagnificationGesture()
            .updating($magnifyBy) { newValue, scale, _ in
                scale = newValue
            }
            .onEnded { value in
                var newScale = self.lastScale * value
                if newScale <= self.min { newScale = self.min }
                if newScale >= self.max { newScale = self.max }
                self.lastScale = newScale
            }
    }
    
    private var tapGesture: some Gesture {
        return TapGesture(count: 2)
            .onEnded { value in
                if frameScale <= min { lastScale = max }
                else if frameScale >= max { lastScale = min }
                else { lastScale = (max - min) / 2 + min < frameScale ? max : min }
            }
    }
    
    init(contentSize: CGSize) {
        self.contentSize = contentSize
    }
    
    func body(content: Content) -> some View {
        ScrollView([.horizontal, .vertical]) {
            content
                .scaleEffect(self.frameScale)
                .frame(
                    width: contentSize.width * frameScale,
                    height: contentSize.height * frameScale
                )
                .onChange(of: self.frameScale) { newValue in
                    print("contentSize: \(contentSize), frameScale: \(newValue)")
                }
        }
        .gesture(ExclusiveGesture(zoomGesture, tapGesture))
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
