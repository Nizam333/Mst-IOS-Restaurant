//
//  MainMenuViewController.swift
//  Restaurant
//
//  Created by Suriya on 7/19/16.
//  Copyright © 2016 MST SOLUTIONS PRIVATE LIMITED. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    let items=[
        "Chicken",
        "Mutton",
        "Veg","Beverage",
        "Chowder",
        "Grill","Roast",
        "Jamal",
        "Macroni","Almtluth",
        "Meat",
        "sweets"
    ]
    
    
    @IBOutlet var collectionview: UICollectionView!
    // MARK: - UICollectionViewDataSource protocol
    
    
    
    // tell the collection view how many cells to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MainMenuCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.mylabel.text = self.items[indexPath.item]
       // cell.backgroundColor = UIColor.cyanColor()// make cell more visible in our example project
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    override func viewWillLayoutSubviews() {
        //collectionview.collectionViewLayout.invalidateLayout()
    }
}