//
//  PizzaViewController.swift
//  pizza2
//
//  Created by admin on 24.03.2023.
//

import UIKit

class PizzaViewController: UIViewController {
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    let fetcher = ConfigFetcher()
    var config : AppConfig?{
        
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        fetchData()
        
    }

    func fetchData (){
        fetcher.fetchConfig{ [weak self] (error , config) -> Void in
            if let error = error{
                return
            }
            self?.config = config
        }
    }

}

extension PizzaViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath)
        
        guard let myCell = cell as? MyCollectionViewCell else{
            return cell
        }
        return myCell
            
        
    }
    
    
}

extension PizzaViewController : UICollectionViewDelegate{
    
}

extension PizzaViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}

extension PizzaViewController : UITableViewDelegate{
    
}
