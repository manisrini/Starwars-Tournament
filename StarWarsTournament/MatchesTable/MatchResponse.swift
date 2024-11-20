//
//  MatchResponse.swift
//  StarWarsTournament
//
//  Created by Manikandan on 19/11/24.
//
struct Player: Codable {
    let id: Int
    let score: Int
}

struct Match: Codable {
    let match: Int
    let player1: Player
    let player2: Player
}
