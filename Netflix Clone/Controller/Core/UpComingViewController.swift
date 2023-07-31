//
//  UpComingViewController.swift
//  Netflix Clone
//
//  Created by K Praveen Kumar on 21/07/23.
//

import UIKit

class UpComingViewController: UIViewController {
    
    private var titles: [Movie] = [Movie]()
    
    private let upcomingTable: UITableView = {
        
        let table = UITableView()
        table.register(TitleTableViewCell.self , forCellReuseIdentifier:TitleTableViewCell.identifier)
        return table
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        
        fetchUpcoming()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
    
    private func fetchUpcoming() {
        APICaller.shared.getUpcomingMovie {[weak self] result in
            switch result {
            case.success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
        
}

extension UpComingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell
        else {
            return UITableViewCell()
        }
        
        let title = titles[indexPath.row]
        cell.configure(with: TitleViewModel(titleName: title.originalTitle ?? "", posterURL: title.posterPath ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    
    
    
    
}
