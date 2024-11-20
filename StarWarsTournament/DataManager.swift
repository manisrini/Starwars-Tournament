//
//  DataManager.swift
//  StarWarsTournament
//
//  Created by Manikandan on 19/11/24.
//
import NetworkManager
import Foundation

class DataManager{
    
    
    var players : [PlayerResponse]?
    var matches : [Match]?
    
    func fetchPlayers(from url : String,completion : @escaping([PlayerResponse]?,String?) -> Void) {
        
        if let _players = players{
            completion(_players,nil)
        }else{
            Task{
                let (data, _) = await NetworkManager.shared.getData(urlStr: url)
                    
                guard let _data = data else{ return }

                do{
                    let decoder = JSONDecoder()
                    let players = try decoder.decode([PlayerResponse].self, from: _data)
                    self.players = players
                    completion(players,nil)
                }catch {
                    completion(nil,error.localizedDescription)
                }
            }
        }
    }
    
    func fetchMatches(from url : String,completion : @escaping([Match]?,String?) -> Void) {
        
        if let _matches = matches{
            completion(_matches, nil)
        }else{
            
            Task{
                let (data, _) = await NetworkManager.shared.getData(urlStr: url)
                    
                guard let _data = data else{ return }

                do{
                    let decoder = JSONDecoder()
                    let matches = try decoder.decode([Match].self, from: _data)
                    self.matches = matches
                    completion(matches,nil)
                }catch {
                    completion(nil,error.localizedDescription)
                }
            }
        }
    }
}
