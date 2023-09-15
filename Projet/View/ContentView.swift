//
//  ContentView.swift
//  Projet
//
//  Created by Tom Rouillon on 9/15/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var grid = MinesweeperGrid(mineRate: 0.12, width: 10, height: 16)
    
    var body: some View {
        VStack {
            MinesweeperGridView()
                .environmentObject(self.grid)
            
            Button(action: grid.reset) {
                Text("Recommencer")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
