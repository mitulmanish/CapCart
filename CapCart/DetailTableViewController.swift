//
//  DetailTableViewController.swift
//  CapCart
//
//  Created by Mitul Manish on 28/10/2016.
//  Copyright © 2016 Mitul Manish. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    var productAsList: [AnyObject?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 44.0
        registerTableViewCells()
    }
    
    private func registerTableViewCells() {
        tableView.register(UINib(nibName: "DetailProductImageViewCell", bundle: nil), forCellReuseIdentifier: "detail_image_cell")
        tableView.register(UINib(nibName: "DetailLabelView", bundle: nil), forCellReuseIdentifier: "detail_label_cell")
        tableView.register(UINib(nibName: "DetailDescriptionView", bundle: nil), forCellReuseIdentifier: "description_cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableViewAutomaticDimension
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productAsList?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        if index == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detail_image_cell", for: indexPath) as! DetailImageTableViewCell
            cell.selectionStyle = .none
            if let image = self.productAsList?.first as? UIImage {
                cell.detailImageView.image = image
            }
            return cell
        } else if index == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detail_label_cell", for: indexPath) as! DetailLabelTableViewCell
            cell.selectionStyle = .none
            if let title = self.productAsList?[index] as? String {
                cell.detailLabel.text = title
                self.navigationItem.title = title
            }
            return cell
        } else if index == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "price_cell", for: indexPath) as! PriceTableViewCell
            cell.selectionStyle = .none
            if let price = self.productAsList?[index] as? String {
                cell.priceLabel.text = "$\(price)"
            }
            return cell
        }  else if index == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "description_cell", for: indexPath) as! DetailDescriptionView
            if let description = self.productAsList?[index] as? String {
                cell.descriptionView.scrollRangeToVisible(NSMakeRange(0, 0))
                cell.descriptionView.text = description
                cell.descriptionView.textColor = UIColor.darkGray
                cell.descriptionView.isEditable = false
                cell.selectionStyle = .none
            }
            return cell
        }  else if index == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "size_details", for: indexPath) as! SizeTableViewCell
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "seller_information", for: indexPath) as! SellerTableViewCell
            cell.selectionStyle = .none
            if let seller = self.productAsList?[index] as? Seller {
                if let name = seller.name {
                    cell.sellerNameLabel.text = name
                }
            }
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentSizeInformation(index: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        presentSizeInformation(index: indexPath.row)
    }
    
    func presentSizeInformation(index: Int) {
        if index == 4 {
            if let sizeInformation = self.productAsList?[index] as? [String] {
                let alertController = prepareAlertController(sizeInfo: sizeInformation)
                present(alertController, animated: true, completion: nil)
            }
        }
    }
    func prepareAlertController(sizeInfo: [String]) -> UIAlertController {
        let alertController = UIAlertController(title: "Size Information", message: "Available Sizes:", preferredStyle: .alert)
        
        for size in sizeInfo {
            let alertAction = UIAlertAction(title: size, style: .default, handler: nil)
            alertController.addAction(alertAction)
        }
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alertController
    }
}
