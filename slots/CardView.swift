//
//  CardView.swift
//  slots
//
//  Created by Josh Courtney on 5/15/21.
//

import SwiftUI

struct CardView: View {
    @Binding var symbol: String
    @Binding var backgroundColor: Color
    
    var body: some View {
        Image(symbol)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .background(backgroundColor.opacity(0.5))
            .cornerRadius(16)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(symbol: Binding.constant("apple"), backgroundColor: Binding.constant(Color.white))
            .padding()
            .background(Color.gray)
    }
}
