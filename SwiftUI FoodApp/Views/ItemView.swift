//
//  ItemView.swift
//  SwiftUI FoodApp
//
//  Created by elhajjaji on 10/29/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct ItemView: View {
    var item:Item
    
    var body: some View {
       
        VStack{
            //Downloading image from web...
            WebImage(url: URL(string: item.item_image))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: UIScreen.main.bounds.width - 30,height: 250)

            HStack(spacing:8){
                Text(item.item_name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
                
                //Ratings view...
                ForEach(1...5,id:\.self){index in
                    Image(systemName: "star.fill")
                        .foregroundColor(index <= Int(item.item_ratings) ?? 0 ?Color("Orange") : .gray)
                }
                
            }
            
            HStack{
                Text(item.item_details)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .lineLimit(2)
                
                Spacer(minLength: 0)
            }
            
        }
        
    }
}

