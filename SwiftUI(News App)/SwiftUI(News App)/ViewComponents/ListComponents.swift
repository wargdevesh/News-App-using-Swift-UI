//
//  ListComponents.swift
//  TabBar&ChartsSwiftUi
//
//  Created by Devesh Pandey on 01/05/24.
//

import SwiftUI

struct ListComponents: View {
    
    var body: some View {
        ZStack{
            Color(.white)
            VStack{
                HStack(){
                    Image(systemName: "car.rear.fill").scaledToFill().frame(width: 50,height: 50).padding([.leading],20)
                    VStack{
                        HStack(){
                            Text("www.devesh.com").padding([.leading],10)
                            Spacer()
                            Text("2193").padding([.trailing],30)
                        }
                        HStack(){
                            Text("www.devesh.com").font(.system(size: 15)).padding([.leading],10)
                            Spacer()
                            Text("2193").font(.system(size: 15)).padding([.trailing],30)
                        }
                    }
                }.padding([.top],20)
                HStack{
                    Text("http//:www.devesh.com").padding([.leading],30)
                    Spacer()
                    Image(systemName: "doc.on.doc").padding([.trailing],30)
                }.background(Color(red: 0/255, green: 0/255, blue: 255/0,opacity: 0.3)).padding([.leading,.trailing,.bottom],30)
            }.overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.gray, lineWidth: 2)).padding([])
        }
    }
}

#Preview {
    ListComponents()
}
