//
//  WeatherTableViewController.swift
//  SZWeather
//
//  Created by admin on 16/5/21.
//  Copyright © 2016年 saltchen. All rights reserved.
//封装weather网络请求

import UIKit

class WeatherTableViewController: UITableViewController {
    
    //定义每个区块的名字
    var sectionTitle = ["天气","一周天气预报","天气简报","其他数据"]
    
    //定义两个数据，用于存储数据
    var results: [Result] = []
    var result: [Result] = []
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //如果cell为xib文件，要加载到程序中需要加一下这些代码
        let cellnib = UINib(nibName: "HeaderCell", bundle: nil)
        tableView.registerNib(cellnib, forCellReuseIdentifier: "headerCell")
        
        let weeknib = UINib(nibName: "WeekCell", bundle: nil)
        tableView.registerNib(weeknib, forCellReuseIdentifier: "weekCell")
        
        
        let briefnib = UINib(nibName: "BriefCell", bundle: nil)
        tableView.registerNib(briefnib, forCellReuseIdentifier: "briefCell")
        
        let attachnib = UINib(nibName: "AttachCell", bundle: nil)
        tableView.registerNib(attachnib, forCellReuseIdentifier: "attachCell")
        /*
        //下拉刷新操作实现
        refreshControl = UIRefreshControl()
        refreshControl?.backgroundColor = UIColor.whiteColor()
        refreshControl?.tintColor = UIColor.grayColor()
        refreshControl?.addTarget(self, action: nil, forControlEvents: .ValueChanged)
 */
        
        //下拉刷新操作停止小菊花
        
        self.refreshControl?.endRefreshing()
        
        //北京的天气周报，请求北京的天气周报
        let weeklyWeatherSZ = NetworkHelper.weeklyWeather(cityid: "169")
        
        //设置网络的按钮为活动（ 小菊花在闪闪）
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        weeklyWeatherSZ.getWeather { (results, error) in
            if let results = results {
                self.results = results
                self.result.append(results.first!)
                
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    self.tableView.reloadData()
                })
                
            } else {
                NSOperationQueue.mainQueue().addOperationWithBlock({
                    let alertVC = UIAlertController(title: "网络错误", message: error!, preferredStyle: .Alert)
                    let action = UIAlertAction(title: "好", style: .Default, handler: nil)
                    alertVC.addAction(action)
                    self.presentViewController(alertVC, animated: true, completion: nil)
                })
            }
            
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
           
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //tableView中有多少个区块

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       
        return 4
    
    }
    
    //区块的行数

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        switch section  {
        case 1:
        return     results.count
            
        default:
          return    result.count
        }
       
    }
    //每个区块的行高
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 150
        case 3:
            return 88
        default:
            return 44
        }
    }
    
    //设置每个区块的title
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitle[section]
    }

    
    //每个区块的行的内容
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cellID = ""
        let weather = result[0]
        
        switch indexPath.section {
        case 0:
            cellID = "headerCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! HeaderCell
            cell.labelCity.text = weather.citynm
            cell.labelTemp.text = weather.tempHigh + "°"
            cell.labelWeather.text = weather.weather
            
            return cell
        case 1:
            cellID = "weekCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! WeekCell
            let  result = results[indexPath.row]
            
            if indexPath.row == 0 {
                cell.labelToday.text = "今天"
            } else {
                cell.labelToday.text = "  "
            }
            
            cell.labelWeek.text = result.week
            
            let data = NSData(contentsOfURL: NSURL(string: result.weatherIcon)!)!
            cell.imageViewIcon.image = UIImage(data: data)
            
            cell.labelHighTemp.text = result.tempHigh
            cell.labelLowTemp.text = result.tempLow
            
            return cell
        case 2:
            cellID = "briefCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! BriefCell
            cell.labelBrief.text = "\(weather.weather)。最高温：\(weather.tempHigh)，最低温\(weather.tempLow)。"
            
            return cell
        case 3:
            cellID = "attachCell"
            let cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as! AttachCell
            cell.labelWind.text = weather.wind
            cell.labelHumid.text = weather.humidity
            
            return cell
            
        default:
            return UITableViewCell(frame: CGRectZero)
        }
    }
    
    
    /*
    //延时加载操作
    func deleay(){
        let time: NSTimeInterval = 2.0
        let delay = dispatch_time(DISPATCH_TIME_NOW,
                                  Int64(time * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue()) {
           self.tableView.reloadData()
    }
 
    
    }*/
    
}
