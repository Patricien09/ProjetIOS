//
//  ContentView.swift
//  Projet
//
//  Created by Tom Rouillon on 9/8/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MinesweeperCellView()
        }
        .padding()
    }
    
    func cellTouched() {
        print("Bonsoir")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct MinesweeperCellView: View {
    @State private var cellWidth = CGFloat(25)
    
    var body: some View {
        Button(action: cellTouched) {
            Text("").padding()
        }
        .frame(width: cellWidth, height: cellWidth)
        .background(Color.black)
    }
    
    func cellTouched() {
        print("Bonsoir")
    }
}
