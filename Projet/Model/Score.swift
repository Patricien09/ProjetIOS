//
//  Score.swift
//  Projet
//
//  Created by Tom Rouillon on 9/16/23.
//

struct Score: Codable, Identifiable {
    let id: String
    let score: Float
    let name: String
    let createdAt: Int
}
