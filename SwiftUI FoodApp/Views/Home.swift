//
//  Home.swift
//  SwiftUI FoodApp
//
//  Created by elhajjaji on 10/28/20.
//

import SwiftUI

struct Home: View {
    @ObservedObject var HomeModel = HomeViewModel()
    @State var categoryIndex = 0


    
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
                    
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(Color("WG"))
                    TextField("Search", text: $HomeModel.search)
                    
                    
                }
                .padding(.horizontal)
                .padding(.top,10)
                
                Divider()
                
//                FiltreView()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(){
                        ForEach(0..<categories.count, id:\.self){data in
                            FiltreView(data: data, index: $categoryIndex)

                        }.padding()

                    }
                }

                if HomeModel.items.isEmpty{
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                else{
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(spacing:25){
                            ForEach(HomeModel.filtered){Item in
                                //Item View....
                                ZStack(alignment: Alignment(horizontal: .center, vertical: .top), content: {
                                    ItemView(item: Item)
                                    HStack{
                                        Text("FREE DELIVERY")
                                            .foregroundColor(.white)
                                            .padding(.vertical,10)
                                            .padding(.horizontal)
                                            .background(Color("Orange"))
                                        
                                        Spacer(minLength: 0)
                                        
                                        Button(action:{
                                            self.HomeModel.addToCart(item: Item)
                                        },label:{
                                            Image(systemName: Item.isAdded ? "checkmark" : "plus")
                                                .foregroundColor(.white)
                                                .padding(10)
                                                .background(Item.isAdded ? Color.green : Color("Orange"))
                                                .clipShape(Circle())
                                        })
                                    }
                                    .padding(.trailing,10)
                                    .padding(.top,10)
                                        
                                })
                                .frame(width: UIScreen.main.bounds.width - 30)
                                
                            }
                        }
                        .padding(.top,10)
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
        .onChange(of: HomeModel.search, perform: { value in
            //To avoid continues search requests....
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                if value == HomeModel.search && HomeModel.search != ""{
                    //Search data...
                    HomeModel.filterData()
                    
                }
            }
            if HomeModel.search == "" {
                //rest all data...
                withAnimation(.linear){
                    HomeModel.filtered = HomeModel.items

                }
            }
            
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
