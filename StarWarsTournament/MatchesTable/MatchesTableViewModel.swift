//
//  MatchesTableViewModel.swift
//  StarWarsTournament
//
//  Created by Manikandan on 19/11/24.
//


struct StarWarMatch{
    let match: Match
    let player1Name : String
    let player2Name : String
}

class MatchesTableViewModel{
    var matches : [Match] = []
    var starWarMatches : [StarWarMatch] = []
    var players : [PlayerResponse] = []
    var playerId : Int = 0
    
    func fetchMatches(dataManager : DataManager,completion : @escaping(Bool) -> Void){
        
        self.matches = []
        self.players = dataManager.players ?? []
        
        if let matches = dataManager.matches{
            self.createMatchesPlayed(matches)
            completion(true)
        }else{
            let url = "https://www.jsonkeeper.com/b/JNYL"
            dataManager.fetchMatches(from: url) { [weak self] matches, error in
                self?.createMatchesPlayed(matches ?? [])
                completion(true)
            }
        }
    }
    
    private func createMatchesPlayed(_ matches : [Match]){
        
        for match in matches {
            if isMatchPlayed(by: playerId,match : match){
                self.starWarMatches.append(
                    StarWarMatch(
                        match: match,
                        player1Name: getName(from: match.player1.id),
                        player2Name: getName(from: match.player2.id)
                    )
                )
                self.matches.append(match)
            }
        }
    }
    
    
    private func getName(from id : Int) -> String{
        let filteredPlayer = self.players.filter { player in
            return player.id == id
        }
        return filteredPlayer.first?.name ?? "---"
    }
    
    private func isMatchPlayed(by playerId : Int,match : Match) -> Bool{
        if match.player1.id == playerId || match.player2.id == playerId{
            return true
        }
        return false
    }
    
}
