//
//  HomeVC.swift
//
//  Created by han.li on 2020/3/9.
//  Copyright © 2020 jordanlake. All rights reserved.
//
//  MIT License

import Foundation
import UIKit
import YoutubePlayer_in_WKWebView

class HomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate  {
    
    //MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    var videos = [Video]()
    var lastContentOffset: CGFloat = 0.0
    
    // set infinity scroll; total video cells
    let totalEntries = 7
    
    //MARK: Methods
//    func customization() {
//        //The custom distance that the content view is inset from the safe area or scroll view edges.
//        self.tableView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 30, right: 0)
//
//        //The distance the scroll indicators are inset from the edge of the scroll view.
//        self.tableView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 30, right: 0)
//
//        //set up the view container height, you can try with different numbers,
//        self.tableView.rowHeight = UITableView.automaticDimension
//        self.tableView.estimatedRowHeight = 300
//    }
    
    func fetchData() {
        Video.fetchVideos { [weak self] response in
            guard let weakSelf = self else {
                return
            }
            weakSelf.videos = response
            weakSelf.videos.myShuffle()
            
            // it looks the following line doesn;t matter for loading more tables
            //            weakSelf.tableView.reloadData()
        }
    }
    
    //MARK: Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Returns the number of rows (table cells) in a specified section.
        //        print("there are \(self.videos.count) videos in the section")
        return self.videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Asks the data source for a cell to insert in a particular location of the table view.
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
        cell.set(video: self.videos[indexPath.row])
        // no need to set the cell text. in this case, the video will cover the entire area
        //        cell.textLabel?.text = "RWOWWW\(videos[indexPath.row])"
        return cell
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        NotificationCenter.default.post(name: NSNotification.Name("open"), object: nil)
//    }
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if (self.lastContentOffset > scrollView.contentOffset.y) {
//            NotificationCenter.default.post(name: NSNotification.Name("hide"), object: false)
//        } else {
//            NotificationCenter.default.post(name: NSNotification.Name("hide"), object: true)
//        }
//    }
//
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        self.lastContentOffset = scrollView.contentOffset.y;
//    }
    
    
    //Tells the delegate the table view is about to draw a cell for a particular row.
    // this is where infinity scroll is implemented
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == videos.count - 1 {
            // we are at last cell
            if videos.count < totalEntries {
                // we need to bring more records from server as there are some pending  records aviable
                videos.append(Video.init(title: "12345678"))
            }
            self.perform(#selector(loadTable), with: nil, afterDelay: 1.0)
        }
    }
    
    @objc func loadTable() {
        self.tableView.reloadData()
    }
    
    
    //MARK: -  ViewController Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        // view load, set up the customization container
//        self.customization()
        // fetch data, particluarl video data
        self.fetchData()
    }
}
//TableView Custom Classes
class VideoCell: UITableViewCell {
    
    @IBOutlet weak var purePlay: WKYTPlayerView!
    @IBOutlet weak var videoThumbnail: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var channelPic: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoDescription: UILabel!
    
    func customization()  {
        self.channelPic.layer.cornerRadius = 24
        self.channelPic.clipsToBounds  = true
        self.durationLabel.layer.borderWidth = 0.5
        self.durationLabel.layer.borderColor = UIColor.white.cgColor
        self.durationLabel.sizeToFit()
    }
    
    func set(video: Video)  {
        //        self.videoThumbnail.image = video.thumbnail
        //        self.durationLabel.text = " \(video.duration.secondsToFormattedString()) "
        //        self.durationLabel.layer.borderColor = UIColor.blue.cgColor
        //        self.durationLabel.layer.borderWidth = 5.0
        //        self.channelPic.image = video.channel.image
        self.videoTitle.text = video.title
        //        self.videoDescription.text = "\(video.channel.name)\(video.views)"
        
        let titles = ["8JwCrgEZK8k", "fLiozP7GVeA", " 76Rx2HjNYwc", "wQWmRIHavC8", "8IYm8OFbzOE", "B_bbBglPGHA", "PPmvRCO4VWo", "1UKIaTQ-V8M", "ue1NT3QhuVU", "VSceuiPBpxY", "tDQBCJAC5lQ", "AhdtowFDKT0" ]
        print("Total titles are \(titles.count)")
        var myVideo:[String] = Array()
//        for _ in 0...2 {
            let number = Int.random(in: 0 ..< titles.count)
            myVideo.append("\(titles[number])")
            print("it picks video \(number)")
//        }
        DispatchQueue.main.async {
//            self.purePlay.load(withVideoId: "\(myVideo[0])")
            self.purePlay.load(withVideoId: "\(titles[number])")

        }
    } // end of set function
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        self.customization()
    } //  end of awake
    
} // end of video cell
