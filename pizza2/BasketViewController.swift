//
//  BasketViewController.swift
//  pizza2
//
//  Created by admin on 29.03.2023.
//

import UIKit
import Kingfisher

class BasketViewController: UIViewController {
    
    var items = [BasketItem]()
    
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        update()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func update() {
        items = Basket.shared.items
        tableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension BasketViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketCell", for: indexPath)
        guard let basketCell = cell as? BasketTableViewCell else {return cell}
        
        let basketItem = items[indexPath.row]
        if let url = URL(string: basketItem.imageLink) {
            basketCell.imageTableCell.kf.setImage(with: .network(url))
        }
        basketCell.titleLabel.text = basketItem.title
        return basketCell
    }
    
    
}
extension BasketViewController : UITableViewDelegate {
    
}
