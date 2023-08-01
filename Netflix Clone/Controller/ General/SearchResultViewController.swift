//
//  SearchResultViewController.swift
//  Netflix Clone
//
//  Created by K Praveen Kumar on 31/07/23.
//

import UIKit

protocol SearchResultViewControllerDelegate: AnyObject {
    func SearchResultViewControllerDidTapItem(viewModel: TitlePreviewViewModel)
}

class SearchResultViewController: UIViewController {
    
    public  var titles:[Movie] =  [Movie]()
    
    weak var delegate: SearchResultViewControllerDelegate?
    
    public var searchResultCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self , forCellWithReuseIdentifier: TitleCollectionViewCell.identifier)
        return collectionView
   
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(searchResultCollectionView)
        
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        searchResultCollectionView.frame = view.bounds
    }
  

}

extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifier, for: indexPath)as? TitleCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let title = titles[indexPath.row]
        cell.configure(with: title.posterPath ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let title = titles[indexPath.row]
        
        let titleName = title.originalTitle ?? ""
        
        APICaller.shared.getMovie(with: titleName) { [weak self] result in
            switch result {
            case.success(let videoElement):
                self?.delegate?.SearchResultViewControllerDidTapItem(viewModel: TitlePreviewViewModel(title: title.originalTitle ?? "", youTubeView: videoElement, titleOverView: title.overview ?? ""))
              
                
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        
        
    }
    
    
    
}
