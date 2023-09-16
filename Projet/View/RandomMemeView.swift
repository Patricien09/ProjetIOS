//
//  RandomMemeView.swift
//  Projet
//
//  Created by Tom Rouillon on 9/16/23.
//

import SwiftUI

struct RandomMemeView: View {
    @ObservedObject private var memesViewModel = MemeViewModel()
    
    var body: some View {
        VStack {
            AsyncImage(
                url: URL(string: getRandomMeme()?.url ?? "https://api.memegen.link/images/gone/we'll_just_invest_that_money/...aaaand_it's_gone.png"),
                scale: 3
            )
        }
            
    }
    
    func getRandomMeme() -> Meme? {
        if (memesViewModel.memes.isEmpty) {
            return nil
        } else {
            let index = Int.random(in: 0..<(memesViewModel.memes.count - 1))
            return memesViewModel.memes[index]
        }
    }
}
