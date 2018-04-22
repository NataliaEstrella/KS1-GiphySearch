//
//  GiphyCollectionViewController.swift
//  ProjectKS1
//
//  Created by Estrella, Natalia [GCB-OT] on 4/16/18.
//  Copyright © 2018 Estrella, Natalia [GCB-OT]. All rights reserved.
//

import UIKit

private let REUSE_IDENTIFIER = "KSCollectionViewCell"

class KSCollectionViewController: UICollectionViewController, UISearchBarDelegate {
    
    var client: KSClient?
    var gifs: [GifModel] = []
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.client = KSClient(delegate: self)
        self.collectionView?.register(UINib(nibName:"KSCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: REUSE_IDENTIFIER)
        //First Search
        client?.searchImage(searchTerm: "hearts")
        self.collectionView?.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: -  UICollectionViewDataSource
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifs.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: REUSE_IDENTIFIER, for: indexPath) as! KSCollectionViewCell
        
        let model = gifs[indexPath.row]
        var url: URL? = nil
        if let urlString = model.url {
            url = URL(string: urlString)
        }
        cell.gifImageView.sd_setImage(with: url)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if (kind == UICollectionElementKindSectionHeader) {
            let headerView:UICollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "KSSearchCollectionReusableView", for: indexPath)
            
            return headerView
        }
        return UICollectionReusableView()
        
    }
    
    
    
    //MARK: - SEARCH
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchTerm = searchBar.text {
            client?.searchImage(searchTerm: searchTerm)
            self.collectionView?.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchText.isEmpty){
            //reload your data source if necessary
            self.collectionView?.reloadData()
        }
    }
    
}

//MARK: - KSClientDelegate
extension KSCollectionViewController : KSClientDelegate {
    func foundGif(gifModels: [GifModel]) {
        self.gifs = gifModels
        self.collectionView?.reloadData()
    }

}
