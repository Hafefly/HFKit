//
//  ViewLayout.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 12/10/2023.
//

import SwiftUI

struct ViewLayout<Header: View, Content: View>: View {
    private var header: Header
    private let content: (EdgeInsets) -> Content
    
    init(@ViewBuilder header: () -> Header, @ViewBuilder content: @escaping (EdgeInsets) -> Content) {
        self.header = header()
        self.content = content
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack(alignment: .center, spacing: 0) {
                header
                content(
                    EdgeInsets(
                        top: proxy.safeAreaInsets.top,
                        leading: proxy.safeAreaInsets.leading,
                        bottom: proxy.safeAreaInsets.bottom,
                        trailing: proxy.safeAreaInsets.trailing))
                .padding(.horizontal, 16)
                .background(Color.primaryColor)
            }
        }
    }
}

struct HeaderView: View {
    static let headerHeight: CGFloat = 50
    
    let title: String
    
    var body: some View {
        HStack{
            Spacer()
            Text(title)
                .title()
                .padding(.leading, 10)
                .lineLimit(2)
                .padding(EdgeInsets())
            Spacer()
        }
        .frame(height: HeaderView.headerHeight)
        .background(
            Color.hfOrange
                .ignoresSafeArea()
                .titlePattern()
        )
    }
    
}

struct ViewLayout_Previews: PreviewProvider {
    static var previews: some View {
        ViewLayout {
            HeaderView(title: "content")
        } content: { edges in
            VStack{
                Spacer()
                HStack{
                    Spacer()
                }
            }
        }
    }
}
