//
//  MatchTableViewCell.swift
//  StarWarsTournament
//
//  Created by Manikandan on 19/11/24.
//

import UIKit

class MatchTableViewCell: UITableViewCell {

    @IBOutlet weak var playerName2: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var playerName_1: UILabel!
    
    static let nibName : String = "MatchTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(for starWarMatch : StarWarMatch,playerId : Int){
        if starWarMatch.match.player1.score == starWarMatch.match.player2.score{
            self.backgroundColor = .white
        }
        
        var wonPlayerId = 0
        
        self.playerName_1.text = "Hello"
        if starWarMatch.match.player1.score > starWarMatch.match.player2.score{
            wonPlayerId = starWarMatch.match.player1.id
        }else {
            wonPlayerId = starWarMatch.match.player2.id
        }
        
        
        if playerId == wonPlayerId{
            self.backgroundColor = .green
        }else{
            self.backgroundColor = .red
        }
        
        self.playerName_1.text = starWarMatch.player1Name
        self.playerName2.text = starWarMatch.player2Name
        self.score.text = "\(starWarMatch.match.player1.score) - \(starWarMatch.match.player2.score)"

    }
    
}
