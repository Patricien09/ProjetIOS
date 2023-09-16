//
//  MemeViewModel.swift
//  Projet
//
//  Created by Tom Rouillon on 9/16/23.
//

import Foundation
import Alamofire
import Combine

class MemeViewModel: ObservableObject {
    @Published var memes: [Meme] = [Meme]()
    
    init() {
        getMemes()
    }
    
    func getMemes() {
        AF.request("https://api.memegen.link/images").response { response in
            self.memes = try! JSONDecoder().decode([Meme].self, from: response.data!)
        }
    }
}
