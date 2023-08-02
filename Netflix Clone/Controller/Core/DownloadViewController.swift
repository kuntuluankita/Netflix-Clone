//
//  DownloadViewController.swift
//  Netflix Clone
//
//  Created by K Praveen Kumar on 21/07/23.
//

import UIKit

class DownloadViewController: UIViewController {
    
    private var titles: [MovieItem] = [MovieItem]()
    
    private let downloadTable: UITableView = {
        
        let table = UITableView()
        table.register(TitleTableViewCell.self , forCellReuseIdentifier:TitleTableViewCell.identifier)
        return table
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Downloads"
        view.addSubview(downloadTable)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        downloadTable.dataSource = self
        downloadTable.delegate = self
         
        fetchLocalStorageForDownload()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "Downloaded"), object: nil, queue: nil) { result in
            self.fetchLocalStorageForDownload()
        }

    }
    
    private func fetchLocalStorageForDownload() {
        DataPersistenceManager.shared.fetchMoviesFromDataBase { [weak self] result in
            switch result {
            case.success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.downloadTable.reloadData()
                }
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        downloadTable.frame = view.bounds
    }
    

}

extension DownloadViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
       
        case .delete:
        
            
            DataPersistenceManager.shared.deleteTitleWith(model:titles[indexPath.row]) { [weak self]result in
                switch result {
                case .success():
                    print("Delete")
                case.failure(let error):
                    print(error.localizedDescription)
                }
                self?.titles.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            }
  
        case .none:
            print("none")
        case .insert:
            print("insert")
        @unknown default:
            break;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
        guard let titleName = title.originalTitle ?? title.originalLanguage
        else {
            return
        }
        
        
        APICaller.shared.getMovie(with: titleName) { [weak self] result in
            switch result {
            case.success(let videoElement):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                      vc.configure(with: TitlePreviewViewModel(title: titleName, youTubeView: videoElement, titleOverView: title.overview ?? ""))
                      self?.navigationController?.pushViewController( vc, animated: true)
                }
              
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
}
