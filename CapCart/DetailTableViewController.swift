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
        tableView.register(UINib(nibName: "DetailProductImageViewCell", bundle: nil), forCellReuseIdentifier: "detail_image_cell")
        tableView.register(UINib(nibName: "DetailLabelView", bundle: nil), forCellReuseIdentifier: "detail_label_cell")
        tableView.register(UINib(nibName: "DetailDescriptionView", bundle: nil), forCellReuseIdentifier: "description_cell")
        print("**")
        print(productAsList)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return UITableViewAutomaticDimension
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 6
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
            if let price = self.productAsList?[index] as? Int {
                print("*********")
                print(price)
                cell.priceLabel.text = "$\(price)"
            }
            return cell
        }  else if index == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "description_cell", for: indexPath) as! DetailDescriptionView
            if let description = self.productAsList?[index] as? String {
                print(description)
                cell.descriptionView.text = description
                cell.descriptionView.textColor = UIColor.darkGray
                cell.descriptionView.isEditable = false
                cell.selectionStyle = .none
            }
            return cell
        }  else if index == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "size_details", for: indexPath) as! SizeTableViewCell
            cell.selectionStyle = .none
            if let sizeList = self.productAsList?[index] as? [String] {
                print(sizeList)
            }
            return cell
        } else if index == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "seller_information", for: indexPath) as! SellerTableViewCell
            cell.selectionStyle = .none
            if let seller = self.productAsList?[index] as? Seller {
                if let name = seller.name {
                    cell.sellerNameLabel.text = name
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(indexPath.row)")
    }
}
