//
//  PizzaViewController.swift
//  pizza2
//
//  Created by admin on 24.03.2023.
//

import UIKit
import Kingfisher

class PizzaViewController: UIViewController, ViewControllerContainable {
    
    var containerView: UIView {
        collectionViewContainer
    }
    
    @IBOutlet weak var collectionViewContainer: UIView!
    @IBOutlet weak var tableView: UITableView!
    //private var numberOfItemsInSection : Int = 10000
    var currentIndexCell = 2
    var timer: Timer?
    
    let fetcher = ConfigFetcher()
    
    var config : AppConfig?{
        
        didSet{
//            DispatchQueue.main.async {
//                self.collectionView.reloadData()
//                self.tableView.reloadData()
//            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        collectionView.dataSource = self
//        collectionView.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        fetchData()
        
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
        
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let vc = appDelegate.promotionViewController
            present(viewController: vc, animated: true, duration: 0.5, delay: 0.1)
        }
    }

   override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)

//        let indexPath = IndexPath(item: numberOfItemsInSection/2, section: 0)
//        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
    
    func addIntoBasket(pizza: Pizza) {
        //TODO: how to select a price by size?
        Basket.shared.add(pizza: pizza, price: 80.0)
    }
    
    @objc func slideToNext(){
        let count = config?.productList.promotionList.count ?? 0
        if currentIndexCell < count-1{
            currentIndexCell = currentIndexCell + 1
        } else{
            currentIndexCell = 2
        }
//        collectionView.scrollToItem(at: IndexPath(item: currentIndexCell, section: 0), at: .right, animated: true)
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
        return config?.productList.promotionList.count ?? 0
        //return numberOfItemsInSection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath)
        //let count = config?.productList.promotionList.count ?? 0
        
        
        if
        let myCell = cell as? MyCollectionViewCell,
        //let promotion = config?.productList.promotionList[indexPath.item  % count]{
        let promotion = config?.productList.promotionList[indexPath.item]{
            myCell.titleLabel.text = promotion.title
            let url = URL(string: promotion.imageLink)!
            myCell.imagePizza.kf.setImage(with: Source.network(url))
        }
        return cell
            
        
    }
    
    
    
    
}

extension PizzaViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        var offset = collectionView.contentOffset
        let width = collectionView.contentSize.width
        if offset.x == width/4{
            offset.x += width/2
            collectionView.setContentOffset(offset, animated: false)
        } else if offset.x > width/4 * 3 {
            offset.x -= width/2
            collectionView.setContentOffset(offset, animated: false)}
        }
    }


extension PizzaViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        config?.productList.pizzaList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PizzaTableViewCell", for: indexPath)
        
        if
            let myCell = cell as? PizzaTableViewCell,
            let pizza = config?.productList.pizzaList[indexPath.row]{
            let minCost = min(pizza.price.small ?? 9999, pizza.price.medium ?? 9999, pizza.price.large ?? 9999)
            myCell.pizzaTitleCell.text = pizza.title
            myCell.costLabel.text = "от \(minCost) р."
            let url = URL(string: pizza.imageLink)!
            myCell.pizzaImageTableCell.kf.setImage(with: Source.network(url))
            myCell.pizzaDescriptionTableCell.text = pizza.description
            
        }
        return cell
           
    }
    
    
}

extension PizzaViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pizza = config?.productList.pizzaList[indexPath.row] else {return}
        addIntoBasket(pizza: pizza)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
