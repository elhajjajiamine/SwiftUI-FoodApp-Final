//
//  Home.swift
//  SwiftUI FoodApp
//
//  Created by elhajjaji on 10/28/20.
//

import SwiftUI

struct Home: View {
    @ObservedObject var HomeModel = HomeViewModel()

    
    var body: some View {
        ZStack{
            
            VStack(spacing: 10){
                
                HStack(spacing:15){
                    Button(action: {
                        withAnimation(.easeIn){HomeModel.showMenu.toggle()
                            
                        }
                    }, label: {
                        Image(systemName: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(Color("Orange"))
                        
                    })
                    
                    Text(HomeModel.userAddress == nil ? "Locating..." : "Deliver To")
                        .foregroundColor(.black)
                    Text(HomeModel.userAddress)
                        .font(.caption)
                        .fontWeight(.heavy)
                        .foregroundColor(Color("Orange"))
                    
                    Spacer(minLength: 0)
                }
                .padding([.horizontal,.top])
                
                Divider()
                
                HStack(spacing:15){
                    TextField("Search", text: $HomeModel.search)
                    
                    if HomeModel.search != "" {
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "magnifyingglass")
                                .font(.title2)
                                .foregroundColor(Color("DarkGrey"))
                        })
                        .animation(.easeIn)
                    }
                }
                .padding(.horizontal)
                .padding(.top,10)
                
                Divider()

                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing:25){
                        ForEach(HomeModel.items){Item in
                            //Item View....
                            Text(Item.item_name)
                    
                        }
                    }
                }
                
            }
            //Side Menu.....
            
            HStack{
                Menu(homeData: HomeModel)
                //Move Effect from left
                    .offset(x : HomeModel.showMenu ? 0 : -UIScreen.main.bounds.width / 1.6)
                Spacer(minLength: 0)
            }
            .background(Color.black.opacity(HomeModel.showMenu ? 0.3 : 0).ignoresSafeArea()
            //Closing when taps on outside...
                            .onTapGesture (perform: {
                                withAnimation(.easeIn){HomeModel.showMenu.toggle()}

                            })
            )
            // Non Closable Alert if Permission Denied ...
            if HomeModel.noLocation{
                Text("Please enable location access in settings to further move on !!")
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width - 100, height: 120)
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.3).ignoresSafeArea())
            }

        }
        .onAppear(perform:  {
            // calling location delegate...
            HomeModel.locationManager.delegate = HomeModel
              
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
