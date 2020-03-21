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
    var limit = 5
    let totalEntries = 16
    
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
//            weakSelf.videos.myShuffle()
//            weakSelf.tableView.reloadData()
        }
    }
    
    //MARK: Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Returns the number of rows (table cells) in a specified section.
        print("Prepare tabview, and the view will be called \(videos.count)times")
        return self.videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Asks the data source for a cell to insert in a particular location of the table view.
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
        print("index row is now at \(indexPath.row)")
        cell.set(video: self.videos[indexPath.row])
        cell.playVideo()
        return cell
    }
    
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
        print("at this point, index path row is \(indexPath.row)")
        print("at this point, video counts is \(videos.count)")
        if indexPath.row == videos.count - 1 {
            // we are at last cell
            if videos.count < totalEntries {
// we need to bring more records from server as there are some pending  records aviable
                videos.append(Video.init(title: ""))
                var index = videos.count
                let tempLimit = index + limit
                while index < tempLimit
                {
                    print("when comparing, index is\(index)")
                    print("when compparing, templimit is \(tempLimit)")
                    videos.append(Video.init(title: ""))
                    index = index + 1
                    print("after plusone index equals \(index)")
                }
                print("video count still smaller then entry")
            } else
            {
                print("video counts is now larger than total entry")
            } // end of if totla entry
// load more data to do infinity scroll
//            self.perform(#selector(loadTable), with: nil, afterDelay: 1)
            print("after load data video count is \(videos.count)")
        }
    }

//     load more data to do infinity scroll
//        @objc func loadTable() {
//            self.tableView.reloadData()
//        }
    
    
    //MARK: -  ViewController Lifecylce
    override func viewDidLoad() {
        super.viewDidLoad()
        // view load, set up the customization container
        //        self.customization()
        // fetch data, particluarl video data
        self.fetchData()
        print("\(videos.count) video container after view did load")
    }
} //  end HomeVC



//TableView Custom Classes
class VideoCell: UITableViewCell {
    
    @IBOutlet weak var purePlay: WKYTPlayerView!
    @IBOutlet weak var videoThumbnail: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var channelPic: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoDescription: UILabel!
    
    // get a group of video IDs
    let titles = ["1UKIaTQ-V8M", "jtAyhXBt6pA", "dOet1dDe4Dg", "UlPls4dic5I", "AhdtowFDKT0"]
    
    var myVideo:[String] = Array()
    
    func playVideo() {
        let number = Int.random(in: 0 ..< titles.count)
        myVideo.append("\(titles[number])")
        //        print("hello i have \(titles.count) videos")
        purePlay.load(withVideoId: "\(self.myVideo[0])")
    }
    
    // customization and set videos
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
        
    } // end of set function
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //        self.customization()
    } //  end of awake
    
} // end of video cell
