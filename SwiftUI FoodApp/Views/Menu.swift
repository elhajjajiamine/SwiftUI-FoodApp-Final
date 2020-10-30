//
//  Menu.swift
//  SwiftUI FoodApp
//
//  Created by elhajjaji on 10/28/20.
//

import SwiftUI

struct Menu: View {
    @ObservedObject var homeData : HomeViewModel
    
    var body: some View {
        
        VStack{
            
            NavigationLink(destination: CartView(homeData: homeData)){
                HStack(spacing : 15){
                    Image(systemName: "cart")
                        .font(.title)
                        .foregroundColor(Color("Orange"))
                    Text("Cart")
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                }.padding()

            }
            
            Spacer()
            
            HStack{
                
                Spacer()
                
                Text("Version 0.1")
                    .fontWeight(.bold)
                    .foregroundColor(Color("Orange"))
            }
            .padding(10)
            
        }
        .padding([.top,.trailing])
        .frame(width: UIScreen.main.bounds.width / 1.6)
        .background(Color.white.ignoresSafeArea())
    }
}

