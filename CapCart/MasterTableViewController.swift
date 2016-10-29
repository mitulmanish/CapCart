//
//  MasterTableViewController.swift
//  CapCart
//
//  Created by Mitul Manish on 28/10/2016.
//  Copyright © 2016 Mitul Manish. All rights reserved.
//

import UIKit

class MasterTableViewController: UITableViewController {
    
    var progressIndiactor: UIActivityIndicatorView?
    var productList: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureProgressIndicator()
        getDataFromService()
    }
    
    func getDataFromService() {
        HatShopService.sharedInstance.getDataFromService(endPoint: EndPoint.hat) { (data) in
            self.productList = DataFormatter.getListOfProducts(data: data)
            self.progressIndiactor?.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    func configureTableView() {
        tableView.register(UINib(nibName: "MasterTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView.estimatedRowHeight = 44.0
        tableView.separatorStyle = .none
    }
    
    func configureProgressIndicator() {
        progressIndiactor = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        progressIndiactor?.color = UIColor.blue
        progressIndiactor?.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        progressIndiactor?.center = self.view.center
        progressIndiactor?.hidesWhenStopped = true
        view.addSubview(progressIndiactor!)
        progressIndiactor?.bringSubview(toFront: view)
        progressIndiactor?.startAnimating()
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
        cell.shareButton.setImage(UIImage(named: "Forward-Arrow"), for: .normal)
        cell.shareButton.tag = indexPath.row
        cell.shareButton.addTarget(self, action: #selector(MasterTableViewController.sharingButtonTapped(_:)), for: .touchUpInside)
        
        if let title = product.title {
            cell.titleLabel.text = title
            cell.titleLabel.font = UIFont(name: "Avenir-Medium", size: 24.0)
        }
        
        if let price = product.price {
            cell.priceLabel.text = "$\(price)"
            cell.priceLabel.font = UIFont(name: "Avenir-Medium", size: 24.0)
        }
        
        if let image = product.productImage {
            cell.productImage.image = image
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    func sharingButtonTapped(_ button: UIButton) {
        let currentProduct = self.productList[button.tag]
        guard let imageToShare = currentProduct.productImage, let textToShare = currentProduct.textToShare else {
            return
        }
        let objectsToShare = [textToShare, imageToShare] as [Any]
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        
        activityVC.excludedActivityTypes = [UIActivityType.airDrop, UIActivityType.addToReadingList]
        activityVC.popoverPresentationController?.sourceView = button
        self.present(activityVC, animated: true, completion: nil)
    }
}
