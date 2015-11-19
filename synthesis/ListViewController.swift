//
//  ListViewController.swift
//  synthesis
//
//  Created by XingfuQiu on 15/11/18.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON

class ListViewController: UITableViewController {
    
    var loading:Bool = false
    var kinds: String!
    var page: PageInfo!
    var json: JSON! {
        didSet {
            page = PageInfo(j: self.json["dataObject"])
            if "ok" == self.json["state"].stringValue {
                guard let d = self.json["dataObject", "data"].array else {
                    return
                }
                if page.currentPage == 1 {
//                                            print("刷新数据")
                    self.datasource = d
                } else {
//                                            print("加载更多")
                    self.datasource = self.datasource + d
                }
            }
        }
    }
    var datasource: Array<JSON>! = Array() {
        didSet {
//            if self.datasource.count < page.allCount {
//                self.tableView.footer.hidden = self.datasource.count < page.pageSize
////                print("没有达到最大值 \(self.tableView.footer.hidden)")
//            } else {
////                print("最大值了,noMoreData")
//                self.tableView.footer.endRefreshingWithNoMoreData()
//            }


            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.separatorStyle = .None
        loadNewData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadNewData(){
        if self.loading {
            return
        }
        self.pleaseWait()
        self.loading = true
        let param = ["act": "composed", "page":"1", "kinds":kinds]
        Alamofire.request(.GET, URL_MC, parameters: param).responseJSON { (dataObject) -> Void in
            self.loading = false
            self.json = JSON(dataObject.result.value!)
            self.clearAllNotice()
        }
    }
    
    func loadMoreData(){
        if self.loading {
            return
        }
        if self.datasource.count >= page.allCount {
            return
        }
        self.loading = true
        let param = ["act": "composed", "page":"\(page.currentPage+1)", "kinds":kinds]
        Alamofire.request(.GET, URL_MC, parameters: param).responseJSON { (dataObject) -> Void in
            self.loading = false
            self.json = JSON(dataObject.result.value!)
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (datasource.count == 0) && (self.json != nil) {
            //没有数据时显示
            let emptyText = UILabel(frame: self.tableView.bounds)
            emptyText.text = "哇哦,没有合成配方"
            emptyText.textColor = UIColor(hexString: "#4F5051")
            emptyText.textAlignment = .Center
            emptyText.font = UIFont.systemFontOfSize(15)
            self.tableView.backgroundView = emptyText
        }
        return datasource.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath) as! ListCell
        
        let item = self.datasource[indexPath.row]
        cell.imgView?.kf_setImageWithURL(NSURL(string: item["imgPath"].stringValue)!, placeholderImage: UIImage(named: "loading"))
        cell.title?.text = item["viewName"].stringValue
        cell.titleDetail?.text = "简介:"+item["shortDesc"].stringValue

        // Configure the cell...
        //自动加载下一页
        if indexPath.row == datasource.count - 3 {
            loadMoreData()
        }
        return cell
    }
    
    //跳转Segue传值
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            let idxPath = self.tableView.indexPathForSelectedRow
            let receive = segue.destinationViewController as! WebViewController
            receive.webUrl = self.datasource[(idxPath?.row)!]["id"].stringValue
            receive.tt = self.datasource[(idxPath?.row)!]["viewName"].stringValue
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
