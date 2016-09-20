//
//  MainMenuViewController.swift
//  Restaurant
//
//  Created by Suriya on 7/19/16.
//  Copyright © 2016 MST SOLUTIONS PRIVATE LIMITED. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage


class MainMenuViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
   
    // MARK: - UICollectionViewDataSource protocol
    var dataRows = NSArray()
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    
    var arr_categoryid:[String] = []
    var arr_message:[String] = []
    var arr_poid:[String] = []
    var arr_prodname:[String] = []
    var arr_qty:[String] = []
    var arr_rate:[String] = []
    var arr_status:[String] = []
    var arr_success:[String] = []
    var arr_url:[String] = []
    
    var swiftImages:[UIImage] = []
    
    var cf = CommonFunction()

    var id_index = 0
    
    
    @IBOutlet var collectionview: UICollectionView!
    
    
    @IBOutlet var progressView: ProgressView!
    
    
    
    // tell the collection view how many cells to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //print("productname = \(self.arr_categoryid.count)")
        return self.arr_prodname.count
    }
    
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MainMenuCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        
        //print("productname = \(self.itemTitle[indexPath.item])")
        cell.mylabel.text = self.arr_prodname[indexPath.item]
        //cell.myimage.image = nil
        
        let block: SDWebImageCompletionBlock! = {(image: UIImage!, error: NSError!, cacheType: SDImageCacheType, imageURL: NSURL!) -> Void in
               // print(error)
        }
        //let path = NSBundle.mainBundle().bundlePath.stringByAppendingString("/\(self.arr_url[indexPath.row])") as NSString
        
        
        //let url = NSURL.fileURLWithPath(path as String)
        
        let url = NSURL(string: self.arr_url[indexPath.row])
        print(url)
        
        cell.myimage.sd_setImageWithURL(url, placeholderImage: UIImage(named: "navheader"), completed: block)
        
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.mainScreen().scale
        
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        
        id_index=indexPath.row
        
        
    }
   
    override func viewWillLayoutSubviews() {
        //collectionview.collectionViewLayout.invalidateLayout()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MAin menu viewdid load")
        catergRequest()
        
       
        
        
        
        //segments.addAnimation(animation, forKey: "ani")
    }
    func catergRequest(){
        
        progressView.animateProgressView()
        print("Mainmenu base url "+Urls().Base_Url)
        Alamofire.request(.POST, Urls().Base_Url+Urls().PHP_FILE_Bulk_Image, parameters: ["storeid": "S0001"])
            .responseJSON { response in
                //print(response.request)  // original URL request
                ////print(response.response) // URL response
                //print(response.data)     // server data
                //print(response.result)   // result of response serialization
                
                let records = response.result.value!.objectForKey("product") as! NSArray
                self.dataRows = records
                
                for var i = 0; self.dataRows.count > i; i += 1 {
                    
                    let obj : AnyObject! =  self.dataRows.objectAtIndex(i)
                    
                    let categoryid = obj.objectForKey("categoryid") as! String
                    //let message = obj.objectForKey("message") as! String
                    //let poid = obj.objectForKey("poid") as! String
                    let prodname = obj.objectForKey("prodname") as! String
                    //let qty = obj.objectForKey("qty") as! String
                    //let rate = obj.objectForKey("rate") as! String
                    //let status = obj.objectForKey("status") as! String
                    //let success = obj.objectForKey("success") as! String
                    let url = obj.objectForKey("url") as! String
                    
                    
                    self.arr_categoryid.append(categoryid)
                    //self.arr_message.append(message)
                    //self.arr_poid.append(poid)
                    self.arr_prodname.append(prodname)
                    //self.arr_qty.append(qty)
                    //self.arr_rate.append(rate)
                    //self.arr_status.append(status)
                    //self.arr_success.append(success)
                    self.arr_url.append(url)
                    
                    
                    
                    
                }
                //if let JSON = response.result.value {
                //    print("JSON: \(JSON)")
                //}
                print(self.arr_prodname)
                //
                self.collectionview.reloadData()
                
                self.progressView.hideProgressView()
                //print(records)
        }
        
    }
    
    
}