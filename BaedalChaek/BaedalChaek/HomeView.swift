//
//  HomeView.swift
//  BaedalChaek
//
//  Created by 권은빈 on 2023/02/07.
//

import SwiftUI

enum SearchType {
    case delivery
    case pickup
    case all
}

struct HomeView: View {
    
    @State private var locationText: String
    @State private var isDeliverySelected: Bool
    @State private var isPickupSelected: Bool
    
    var frameSize: CGSize
    
    init(frameSize: CGSize) {
        self._locationText = State(initialValue: "")
        self._isDeliverySelected = State(initialValue: false)
        self._isPickupSelected = State(initialValue: false)
        self.frameSize = frameSize
    }
    
    var body: some View {
        VStack {
            // 장소 작성 필드
            TextField(
                "location",
                text: $locationText
            )
            .frame(width: frameSize.width * 0.9)
            .padding()
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 15))
            
            // 배달 / 포장 버튼
            HStack {
                Button("배달") {
                    self.isDeliverySelected.toggle()
                }
                .padding()
                .foregroundColor(self.isDeliverySelected ? Color.white : Color.blue)
                .background(self.isDeliverySelected ? Color.blue : Color.white)
                .border(self.isDeliverySelected ? Color.clear : Color.blue)
                
                Button("포장") {
                    self.isPickupSelected.toggle()
                }
                .padding()
                .foregroundColor(self.isPickupSelected ? Color.white : Color.blue)
                .background(self.isPickupSelected ? Color.blue : Color.white)
                .border(self.isPickupSelected ? Color.clear : Color.blue)
            }
            .foregroundColor(.white)
            .padding()
            
            // 검색하기 버튼
            NavigationLink {
                ListView(frameSize: self.frameSize)
            } label: {
                HStack {
                    Text("검색하기")
                    Image(systemName: "magnifyingglass")
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .clipShape(Capsule())
            }
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(frameSize: CGSize(width: 280, height: 700))
    }
}
