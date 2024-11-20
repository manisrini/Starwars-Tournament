//
//  PointsTableViewCell.swift
//  StarWarsTournament
//
//  Created by Manikandan on 19/11/24.
//

import UIKit

class PointsTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var score: UILabel!
    
    static let nibName = "PlayerTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func config(for player : StarWarPlayer){
        self.name.text = player.name
        self.score.text = "\(player.points)"
        if let url =  URL(string: player.icon){
            self.avatar.load(for: url)
        }
    }
    
}


extension UIImageView {
    func load(for url: URL) {
        DispatchQueue.global().async { [weak self] in

              let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
                  if let data = data {
                      self?.image = UIImage(data: data)
                  }
              }
            dataTask.resume()
        }
    }
}
