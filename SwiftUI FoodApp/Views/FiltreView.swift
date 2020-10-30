//
//  FiltreView.swift
//  SwiftUI FoodApp
//
//  Created by elhajjaji on 10/29/20.
//


import SwiftUI

struct FiltreView: View {
    var data : Int
    @Binding var index : Int
    
    var body: some View {
        HStack(spacing:20){
            
            
                ZStack{
                    Circle()
                        .frame(width: 60, alignment: .top)
                        .foregroundColor(.white)
                    Image(categories[data])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40)

                }
                .frame(width: 65, height: 100)
                .background(Color(index == data ? ("Orange") : ("WG")))
                .cornerRadius(50)
         
            .onTapGesture {
                withAnimation{
                    index = data
                }
            }
        }
    }
}






var categories = ["all","burger", "pizza", "chicken", "dessert"]

