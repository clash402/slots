//
//  ContentView.swift
//  slots
//
//  Created by Josh Courtney on 5/15/21.
//

import SwiftUI

struct ContentView: View {
    @State private var symbols = ["apple", "star", "cherry"]
    @State private var numbers = Array(repeating: 0, count: 9)
    @State private var backgroundColors = Array(repeating: Color.white, count: 9)
    @State private var credits = 1000
    
    private var betAmount = 5
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(red: 200/255, green: 143/255, blue: 32/255))
                .edgesIgnoringSafeArea(.all)
            Rectangle()
                .foregroundColor(Color(red: 228/255, green: 195/255, blue: 76/255))
                .rotationEffect(Angle(degrees: 45))
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                    Text("SwiftUI Slots")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                }.scaleEffect(2)
                Spacer()
                Text("Credits: \(credits)")
                    .padding(.all, 12)
                    .foregroundColor(.black)
                    .background(Color.white.opacity(0.5))
                    .cornerRadius(12)
                Spacer()
                VStack {
                    HStack {
                        Spacer()
                        CardView(symbol: $symbols[numbers[0]], backgroundColor: $backgroundColors[0])
                        CardView(symbol: $symbols[numbers[1]], backgroundColor: $backgroundColors[1])
                        CardView(symbol: $symbols[numbers[2]], backgroundColor: $backgroundColors[2])
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        CardView(symbol: $symbols[numbers[3]], backgroundColor: $backgroundColors[3])
                        CardView(symbol: $symbols[numbers[4]], backgroundColor: $backgroundColors[4])
                        CardView(symbol: $symbols[numbers[5]], backgroundColor: $backgroundColors[5])
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        CardView(symbol: $symbols[numbers[6]], backgroundColor: $backgroundColors[6])
                        CardView(symbol: $symbols[numbers[7]], backgroundColor: $backgroundColors[7])
                        CardView(symbol: $symbols[numbers[8]], backgroundColor: $backgroundColors[8])
                        Spacer()
                    }
                }
                Spacer()
                HStack (spacing: 16) {
                    VStack {
                        Button(action: {
                            self.resetBackgrounds()
                            self.randomizeSymbols()
                            self.checkForMatches()
                        }) {
                            Text("Spin")
                                .fontWeight(.bold)
                                .padding(.all, 12)
                                .padding([.leading, .trailing], 32)
                                .foregroundColor(.white)
                                .background(Color.pink)
                                .cornerRadius(24)
                        }
                        Text("\(betAmount) credits").font(.footnote)
                    }
                    VStack {
                        Button(action: {
                            self.resetBackgrounds()
                            self.randomizeSymbols(true)
                            self.checkForMatches(true)
                        }) {
                            Text("Max Spin")
                                .fontWeight(.bold)
                                .padding(.all, 12)
                                .padding([.leading, .trailing], 32)
                                .foregroundColor(.white)
                                .background(Color.pink)
                                .cornerRadius(24)
                        }
                        Text("\(betAmount * 5) credits").font(.footnote)
                    }
                }
                Spacer()
            }
        }
    }
    
    func resetBackgrounds() {
        self.backgroundColors = self.backgroundColors.map { _ in
            Color.white
        }
    }
    
    func randomizeSymbols(_ isMaxSpin: Bool = false) {
        if isMaxSpin {
            self.numbers = self.numbers.map { _ in
                Int.random(in: 0...2)
            }
        } else {
            self.numbers[3] = Int.random(in: 0...2)
            self.numbers[4] = Int.random(in: 0...2)
            self.numbers[5] = Int.random(in: 0...2)
        }
    }
    
    func checkForMatches(_ isMaxSpin: Bool = false) {
        var matches = 0
        
        if isMaxSpin {
            // Vertical
            // if isMatch(0, 3, 6) { matches += 1 }
            // if isMatch(1, 4, 7) { matches += 1 }
            // if isMatch(2, 5, 8) { matches += 1 }
            
            // Horizontal
            if isMatch(0, 1, 2) { matches += 1 }
            if isMatch(3, 4, 5) { matches += 1 }
            if isMatch(6, 7, 8) { matches += 1 }
            
            // Diagonal
            if isMatch(0, 4, 8) { matches += 1 }
            if isMatch(2, 4, 6) { matches += 1 }
        } else {
            if isMatch(3, 4, 5) { matches += 1 }
        }
        
        if matches > 0 {
            credits += matches * betAmount * 2
        } else if isMaxSpin {
            credits -= betAmount * 5
        } else {
            credits -= betAmount
        }
    }
    
    func isMatch(_ index1: Int, _ index2: Int, _ index3: Int) -> Bool {
        if numbers[index1] == numbers[index2] && numbers[index2] == numbers[index3] {
            backgroundColors[index1] = Color.green
            backgroundColors[index2] = Color.green
            backgroundColors[index3] = Color.green
            
            return true
        } else {
            return false
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
