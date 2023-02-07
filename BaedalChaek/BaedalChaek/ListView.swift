//
//  ListView.swift
//  BaedalChaek
//
//  Created by 권은빈 on 2023/02/07.
//

import SwiftUI

// 좌우로 스크롤 가능한 리스트
struct ListView: View {
    
    @State private var isOpen: Bool
    @State private var showDetailView: Bool
    
    // 예시 이미지
    private let imageURL: URL? = {
       let string = "https://modo-phinf.pstatic.net/20191123_71/1574507078498wuw2I_JPEG/mosa5nWMK7.jpeg?type=w720"
        guard let url = URL(string: string)
        else { return nil }
        
        return url
    }()
    
    var frameSize: CGSize
    
    init(frameSize: CGSize) {
        self._isOpen = State(initialValue: false)
        self._showDetailView = State(initialValue: false)
        self.frameSize = frameSize
    }
    
    var body: some View {
        VStack {
            // 전단지 이미지
            AsyncImage(url: imageURL) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .onTapGesture {
                // 탭하면 확대/축소/이동 가능한 전체화면 이미지 보여줌
                self.showDetailView.toggle()
            }
            
            HStack {
                Button {
                    // 전화걸기 팝업
                } label: {
                    Image(systemName: "phone.fill")
                        .font(.largeTitle)
                }
                .padding()
                
                Spacer()
                
                Text(self.isOpen ? "영업중" : "준비중")
                    .font(.title3)
                    .foregroundColor(self.isOpen ? .blue : .gray)
                    .padding()
                
            }
            .overlay {
                // 리스트 페이지 인덱스
                Text("1/10")
                    .font(.title2)
            }
            .padding()
        }
        .sheet(isPresented: $showDetailView) {
            // 줌, 스크롤 가능한 Detail View
            DetailView(imageURL: self.imageURL)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(frameSize: CGSize(width: 350, height: 590))
    }
}
