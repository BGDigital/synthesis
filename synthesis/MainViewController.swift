//
//  MainViewController.swift
//  synthesis
//
//  Created by XingfuQiu on 15/11/18.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MainCell"

class MainViewController: UICollectionViewController {

    var selectIdx: Int!
    lazy var titleItems = ["基础材料", "食物配方", "酿造配方", "建筑配方", "工具配方", "武器配方", "材料配方", "杂项配方", "装饰配方"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "nav_bg"), forBarMetrics: .Default)
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont.systemFontOfSize(20)]

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        //为什么注册新的就会没有效果或报错,没有搞懂!!!
        // Register cell classes
//        self.collectionView!.registerClass(MainCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        //注册一个headView
//        self.collectionView!.registerClass(CollectionReusableView.self, forSupplementaryViewOfKind:UICollectionElementKindSectionHeader, withReuseIdentifier: "headView")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return titleItems.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! MainCell
    
        // Configure the cell
        if indexPath.row == 0 {
            cell.img.backgroundColor = UIColor(hexString: "#F2DAA8")
        } else {
            cell.img.backgroundColor = UIColor.whiteColor()
        }
//        cell.backgroundColor = UIColor.redColor()
        let itemWidth = (self.collectionView!.bounds.size.width - 30) / 3
        cell.img.layer.cornerRadius = itemWidth / 2
        cell.img.layer.borderColor = UIColor.whiteColor().CGColor
        cell.img.layer.borderWidth = 2
        cell.img.layer.masksToBounds = true
        cell.img.image = UIImage(named: titleItems[indexPath.row])
        cell.title.text = titleItems[indexPath.row]
    
        return cell
    }
        
    //返回自定义HeadView或者FootView，我这里以headview为例
//    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView{
//        var v = CollectionReusableView()
//        if kind == UICollectionElementKindSectionHeader{
//            
//            v = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "headView", forIndexPath: indexPath) as! CollectionReusableView
//        }
//        return v
//    }
    
    //设置每个Item的大小
    func collectionView(collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        let itemWidth = (self.collectionView!.bounds.size.width - 30) / 3
        let itemHeight = (self.collectionView!.bounds.size.height - 30) / 3
        return CGSizeMake(itemWidth , itemHeight)
    }
    
    //返回cell 上下左右的间距
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        return UIEdgeInsetsMake(5, 5, 5, 5)
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.selectIdx = indexPath.row
        self.performSegueWithIdentifier("showList", sender: self)
    }
    
    //跳转Segue传值
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showList" {
            let receive = segue.destinationViewController as! ListViewController
            receive.kinds = self.titleItems[self.selectIdx]
        }
    }
    

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
