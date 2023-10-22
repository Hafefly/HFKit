//
//  ViewLayout.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 12/10/2023.
//

import SwiftUI

public struct ViewLayout<Header: View, Content: View>: View {
    private var header: Header
    private let content: (EdgeInsets) -> Content
    
    public init(@ViewBuilder header: () -> Header, @ViewBuilder content: @escaping (EdgeInsets) -> Content) {
        self.header = header()
        self.content = content
    }
    
    public var body: some View {
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

public struct HeaderView: View {
    static private let headerHeight: CGFloat = 50
    
    private let title: String
    
    public init(title: String) {
        self.title = title
    }
    
    public var body: some View {
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
