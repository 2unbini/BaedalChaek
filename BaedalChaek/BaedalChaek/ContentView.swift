//
//  ContentView.swift
//  BaedalChaek
//
//  Created by 권은빈 on 2023/02/07.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GeometryReader { proxy in
            NavigationSplitView {
                HomeView(frameSize: proxy.size)
            } detail: {
                Text("Detail")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
