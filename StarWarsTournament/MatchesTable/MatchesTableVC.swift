//
//  MatchesTableVC.swift
//  StarWarsTournament
//
//  Created by Manikandan on 19/11/24.
//

import UIKit

class MatchesTableVC: UIViewController {

    @IBOutlet weak var matchesTableView: UITableView!
    
    weak var dataManager : DataManager?
    var viewModel = MatchesTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }

    private func initialSetup(){
        self.matchesTableView.delegate = self
        self.matchesTableView.dataSource = self
        self.matchesTableView.register(UINib(nibName: MatchTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: MatchTableViewCell.nibName)
    }
    
    func config(for player : StarWarPlayer,dataManager : DataManager){
        self.title = player.name
        self.viewModel.playerId = player.id
        self.viewModel.fetchMatches(dataManager: dataManager,completion: { success in
            DispatchQueue.main.async {
                self.matchesTableView.reloadData()
            }
        })
    }

}


extension MatchesTableVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let matchCell = tableView.dequeueReusableCell(withIdentifier: MatchTableViewCell.nibName, for: indexPath) as? MatchTableViewCell{
            matchCell.config(for: self.viewModel.starWarMatches[indexPath.row], playerId: self.viewModel.playerId)
            return matchCell
        }
        
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Matches"
    }
    
}
