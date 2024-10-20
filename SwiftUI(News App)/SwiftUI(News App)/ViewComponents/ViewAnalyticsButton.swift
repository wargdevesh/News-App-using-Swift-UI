//
//  ViewAnalyticsButton.swift
//  TabBar&ChartsSwiftUi
//
//  Created by Devesh Pandey on 01/05/24.
//

import SwiftUI

struct ViewAnalyticsButton: View {
    var body: some View {
        
        HStack(spacing: 20.0){
            Image(systemName: "chart.line.uptrend.xyaxis").resizable().frame(width: 32,height: 32).padding(10)
            Spacer()
            Text("View Analytics").padding([.trailing],20)
        } .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray, lineWidth: 2)).padding(20)
        //.clipShape(.rect(cornerRadii: .init(topLeading: 12.0,bottomLeading: 12.0,bottomTrailing: 12.0,topTrailing: 12.0), style: .continuous), style: FillStyle()).border(.black)
    }
}

#Preview {
    ViewAnalyticsButton()
}
