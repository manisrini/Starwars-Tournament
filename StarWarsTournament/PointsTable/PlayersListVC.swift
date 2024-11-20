//
//  PointsTable.swift
//  StarWarsTournament
//
//  Created by Manikandan on 19/11/24.
//

import UIKit

class PlayersListVC : UIViewController {

    @IBOutlet weak var pointsTableView: UITableView!
    
    
    let viewModel = PlayersListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        self.fetchData()
    }

    private func initialSetup(){
        self.title = "Star Wars Blaster Tournament"
        self.pointsTableView.delegate = self
        self.pointsTableView.dataSource = self
        self.pointsTableView.register(UINib(nibName: PointsTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: PointsTableViewCell.nibName)
    }
    
    
    private func fetchData(){
        viewModel.fetchPlayersData { [weak self] success in
            DispatchQueue.main.async {
                self?.pointsTableView.reloadData()
            }
        }
    }

}

extension PlayersListVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let pointsCell = tableView.dequeueReusableCell(withIdentifier: PointsTableViewCell.nibName, for: indexPath) as? PointsTableViewCell{
            pointsCell.config(for: self.viewModel.playersList[indexPath.row])
            return pointsCell
        }
        
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.playersList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let matchDetailVC = MatchesTableVC.storyboardInstance() as? MatchesTableVC{
            matchDetailVC.config(for: self.viewModel.playersList[indexPath.row],dataManager: self.viewModel.dataManager)
            self.navigationController?.pushViewController(matchDetailVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Points Table"
    }
    
}
