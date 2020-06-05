//
//  ContentView.swift
//  Cate Sports App
//
//  Created by Ian Mabon on 4/19/20.
//  Copyright © 2020 Ian Mabon. All rights reserved.
//

import SwiftUI

var pickerData: [String] = [String]()

struct ContentView: View {
    
    @ObservedObject var sportInfo = SportManager()
    
    //picker teams
    //try to get sports teams on server!
    let sportsTeams = ["Baseball", "Boy's Lacrosse", "Girl's Lacrosse", "Boy's Tennis", "Girl's Tennis", "Boy's Volleyball", "Girl's Volleyball", "Swimming", "Track and Field", "Boy's Waterpolo", "Girl's Waterpolo", "Football", "Cross Country", "Boy's Basketball", "Girl's Basketball", "Boy's Soccer", "Girl's Soccer", "Squash", "Ultimate Frisbee"]
    
    @State private var selection = ""
    
    var body: some View {
        ZStack {
            VStack {
                //background
                Image("girlz").resizable().edgesIgnoringSafeArea(.all)
                Image("football").resizable().edgesIgnoringSafeArea(.all)
                Image("dunk").resizable().edgesIgnoringSafeArea(.all)
                       }
        VStack {
            ZStack {
               //title
                RoundedRectangle(cornerRadius: 10).frame(width: 300, height: 50, alignment: .center).colorInvert()
                    .opacity(0.85)
                Text("Cate Sports App")
                    .padding(.all)
                    .font(.system(size: 30))
                    
            }
            Spacer()
            ZStack {
                
                Rectangle().frame(width: 370, height: 270, alignment: .center).colorInvert().opacity(0.85)
                
                //live map
                MapView().frame(width: 350, height: 250, alignment: .center)
//                Image("Map").resizable()
//                    .frame(width: 300, height: 200, alignment: .center)
            }
            Spacer()
        
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                        .frame(width: 310, height: 125, alignment: .leading)
                            .foregroundColor(.white).opacity(0.85)
                    
                        Picker(selection: $selection, label:
                Text("Sport")) {
                    
                    ForEach(0 ..< sportsTeams.count) { index in
                        
                        Text(self.sportsTeams[index]).tag(index)
                        self
                    }
                    
                }
                    }
                    Button(action: {
                        self.sportInfo.fetchData(sportSearched: self.selection)
                    }) {
                       Image(systemName: "magnifyingglass.circle.fill")
                       .resizable()
                       .foregroundColor(.white)
                       .frame(width: 50, height: 50, alignment: .center)
                       .padding(.all)
                    }
                    
                }
            
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 10).frame(width: 300, height: 200, alignment: .center).colorInvert().opacity(0.85)
                VStack{
                    Text("Sport Team:\(self.sportInfo.sportName)")
                    Text("Location:\(self.sportInfo.location)")
                    Text("Time:\(self.sportInfo.time)")
                    Text("Notes\(self.sportInfo.notes)")
                }

            }
            Spacer()
            
        }
           
        }
//        .background(Image("hands").resizable()
//        .aspectRatio(contentMode: .fill)
//        .edgesIgnoringSafeArea(.all)
//        )
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

