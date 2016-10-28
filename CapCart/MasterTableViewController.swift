//
//  MasterTableViewController.swift
//  CapCart
//
//  Created by Mitul Manish on 28/10/2016.
//  Copyright © 2016 Mitul Manish. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController {
    
    var productList: [Product] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MasterTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 44.0
        tableView.separatorStyle = .none
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        HatShopService.sharedInstance.getDataFromService(endPoint: EndPoint.hat) { (data) in
            self.productList = DataFormatter.getListOfProducts(data: data)
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return productList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MasterTableViewCell
        
        let product = self.productList[indexPath.row]
            
        let borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
        cell.selectionStyle = .none
        cell.masterCellView.layer.cornerRadius = 8.0
        cell.masterCellView.clipsToBounds = true
        cell.masterCellView.layer.borderColor =  borderColor
        cell.masterCellView.layer.borderWidth = 4
        cell.shareButton.tag = indexPath.row
        cell.shareButton.addTarget(self, action: #selector(MasterTableViewController.ratingButtonTapped(_:)), for: .touchUpInside)
        
        if let title = product.title {
            cell.titleLabel.text = title
        }
        
        if let price = product.price {
            cell.priceLabel.text = "$\(price)"
        }
        
        if let image = product.productImage {
            cell.productImage.image = image
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        performSegue(withIdentifier: "detail_segue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail_segue" {
            if let destinationViewController =  segue.destination as? DetailTableViewController {
                if let selectedIndex = tableView.indexPathForSelectedRow {
                    destinationViewController.productAsList = self.productList[selectedIndex.row].productAsList
                }
            }
        }
    }
    
    func ratingButtonTapped(_ button: UIButton) {
        print(button.tag)
        print("Button pressed 👍")
    }

    
    //then make a action method :
    
    func action(sender: UIButton) {
        print("Button Clicked")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
  
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
