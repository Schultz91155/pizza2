//
//  BasketViewController.swift
//  pizza2
//
//  Created by admin on 29.03.2023.
//

import UIKit
import Kingfisher
import MessageUI

class BasketViewController: UIViewController {
    
    @IBOutlet weak var sendOrderContainerVeiw: UIView!
    @IBOutlet weak var sendOrderButton: UIButton!
    
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
        
        let buttonAction = UIAction { [weak self] action in
            // open mail view controller
            self?.sendEmail()
        }
        sendOrderButton.addAction(buttonAction, for: .touchUpInside)
        styleOrderButton()
    }
    
    func styleOrderButton() {
        sendOrderContainerVeiw.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
     
        sendOrderContainerVeiw.insertSubview(blurView, at: 0)
        
        NSLayoutConstraint.activate([
            blurView.leadingAnchor.constraint(equalTo: sendOrderContainerVeiw.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: sendOrderContainerVeiw.trailingAnchor),
            blurView.topAnchor.constraint(equalTo: sendOrderContainerVeiw.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: sendOrderContainerVeiw.bottomAnchor)
        ])
    }
    
    func update() {
        items = Basket.shared.items
        tableView.reloadData()
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["pizzamailserver@mail.ru"])
            //TODO: how to map array of basket items to mail text body
            let itemsText = items.map { basketItem -> String in
                """
                <p>
                Продукт: \(basketItem.title)
                Описание: \(basketItem.description)
                Цена: \(basketItem.price)
                </p>
                """
            }.joined(separator: "\n")
            
            let titleBody = "<p>Ваш заказ</p>"
            let messageBody = [titleBody, itemsText].joined(separator: "\n")
            mail.setMessageBody(messageBody, isHTML: true)
            mail.setSubject("Новый заказ")
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

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
extension BasketViewController: MFMailComposeViewControllerDelegate {
    
}
