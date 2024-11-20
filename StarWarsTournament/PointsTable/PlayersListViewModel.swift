//
//  PlayersListViewModel.swift
//  StarWarsTournament
//
//  Created by Manikandan on 19/11/24.
//

import NetworkManager
import Foundation

struct StarWarPlayer{
    let id : Int
    let name : String
    let points : Int
    let icon : String
}


class PlayersListViewModel{
    
    var playersList : [StarWarPlayer] = []
    let dispatchGroup = DispatchGroup()
    let dataManager = DataManager()
    
    var playersResponse : [PlayerResponse]?
    var matchesResponse : [Match]?
    
    func fetchPlayersData(completion : @escaping(Bool) -> Void){
        
        self.fetchPlayers()
        self.fetchMatches()
        
        dispatchGroup.notify(queue: .main) {
            completion(true)
            if let _players = self.playersResponse, let _matches = self.matchesResponse{
                self.createStarWarPlayers(players: _players, matches: _matches)
            }
            completion(true)
        }
    }
    
    private func fetchPlayers(){
        
        let url = "https://www.jsonkeeper.com/b/IKQQ"

        dispatchGroup.enter()
        dataManager.fetchPlayers(from: url) { players, error in
            self.playersResponse = players
            self.dispatchGroup.leave()
        }
    }
    
    private func fetchMatches(){
       
        let url = "https://www.jsonkeeper.com/b/JNYL"
        
        dispatchGroup.enter()
        dataManager.fetchMatches(from: url) { matches, error in
            self.matchesResponse = matches
            self.dispatchGroup.leave()
        }
        
    }
    
    private func createStarWarPlayers(players : [PlayerResponse],matches : [Match]){
        
        self.playersList = []
        
        for player in players {
            
            var playerScore = 0
            for match in matches {
                if isMatchPlayed(by: player.id, match: match){
                    playerScore += calculateScore(for: player.id, match: match)
                }
            }
            
            self.playersList.append(
                StarWarPlayer(
                    id: player.id,
                    name: player.name,
                    points: playerScore,
                    icon: player.icon
                )
            )
        }
        
        self.playersList.sort { player1, player2 in
            player1.points > player2.points
        }
    }
    
    private func isMatchPlayed(by playerId : Int,match : Match) -> Bool{
        if playerId == match.player1.id || playerId == match.player2.id{
            return true
        }
        return false
    }
    
    private func calculateScore(for playerId : Int,match : Match) -> Int{
        
        var wonPlayerId : Int = 0
        
        if match.player1.score == match.player2.score{
            return 1
        }
        
        if match.player1.score > match.player2.score{
            wonPlayerId = match.player1.id
        }else{
            wonPlayerId = match.player2.id
        }
        
        if wonPlayerId == playerId{
            return 3
        }
        
        return 0
    }
}
