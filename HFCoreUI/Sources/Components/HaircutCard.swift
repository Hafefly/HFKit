//
//  HaircutCard.swift
//  Nhafeflek
//
//  Created by Samy Mehdid on 12/10/2023.
//

import SwiftUI
import HFCoreModel

struct HaircutCard: View {
    
    private let order: Order
    
    @State private var expanded: Bool = false
    
    init(order: Order) {
        self.order = order
    }
    
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 12){
                HStack{
                    Rectangle()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.primaryColor)
                        .cornerRadius(12)
                    VStack(alignment: .leading){
                        HStack{
                            Image("ic_time_circle_dark")
                            Text("14:00 - 15:00")
                                .font(.primaryColor, .medium, 18)
                            Spacer()
                            if nil != order.confirmedInterval {
                                HStack{
                                    Image("ic_check_white")
                                    if expanded {
                                        Text("confirmed")
                                            .font(.white, .regular, 12)
                                    }
                                }
                                .padding(.horizontal, 12)
                                .padding(.vertical, expanded ? 10 : 14)
                                .background(Color.green)
                                .cornerRadius(.infinity)
                            }
                        }
                        
                        HStack{
                            Image("ic_calendar_dark")
                            Text("Thursday, August 6")
                                .font(.primaryColor, .medium, 18)
                        }
                    }
                }
                
                HStack{
                    Text("James Winston")
                        .font(.black, .bold, 24)
                    Spacer()
                    if nil != order.atHome {
                        HStack{
                            Image("ic_home_white")
                                .resizable()
                                .frame(width: 16, height: 16)
                            if expanded {
                                Text("home")
                                    .font(.white, .regular, 12)
                            }
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, expanded ? 10 : 12)
                        .background(Color.hfOrange)
                        .cornerRadius(.infinity)
                    }
                }
            }
            
            if expanded {
                Separator(color: .primaryColor)
                    .padding(.vertical, 8)
                
                if let fade = order.fade {
                    haircutPriceElementBuilder("fade", price: fade)
                }
                
                if let beard = order.beard {
                    haircutPriceElementBuilder("beard", price: beard)
                }
                
                if let razor = order.razor {
                    haircutPriceElementBuilder("razor", price: razor)
                }
                
                if let scissors = order.scissors {
                    haircutPriceElementBuilder("scissors", price: scissors)
                }
                
                if let straightener = order.straightener {
                    haircutPriceElementBuilder("straightener", price: straightener)
                }
                
                if let atHome = order.atHome {
                    haircutPriceElementBuilder("home", price: atHome)
                }
                
                HStack{
                    Spacer()
                    Text(order.totalPrice.pricing)
                        .font(.white, .medium, 12)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 12)
                        .background(Color.primaryColor)
                        .cornerRadius(.infinity)
                }
            }
        }
        .padding(12)
        .background(Color.white)
        .cornerRadius(16)
        .onTapGesture {
            withAnimation {
                expanded.toggle()
            }
        }
    }
    
    @ViewBuilder
    private func haircutPriceElementBuilder(_ text: String, price: UInt) -> some View {
        HStack{
            Text(text)
                .font(.primaryColor, .medium, 12)
            Spacer()
            Text(price.pricing)
                .font(.primaryColor, .regular, 12)
        }
        .padding(8)
        .background(Color.gray.opacity(0.4))
        .cornerRadius(4)
    }
}

struct HaircutCard_Previews: PreviewProvider {
    static var previews: some View {
        let order = Order(userId: "", barberId: "", fade: 150, beard: 100, hairdryer: nil, razor: nil, scissors: 50, straightener: nil, atHome: 150, totalPrice: 450)
        VStack{
            HaircutCard(order: order)
            Spacer()
        }
    }
}
