//
//  HomeTableTableViewController.swift
//  Twitter
//
//  Created by Mahmuda Akter on 2/25/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class HomeTableTableViewController: UITableViewController {
    
    var tweetArray = [NSDictionary]()
    var numofTweet: Int!
    let myRefresControl = UIRefreshControl()
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweet()
        myRefresControl.addTarget(self, action: #selector(loadTweet), for: .valueChanged)
        tableView.refreshControl = myRefresControl

        
    }
    
    
    @objc func loadTweet() {
        
        let myurl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParams = ["count": 10]
        
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myurl, parameters: myParams , success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            self.myRefresControl.endRefreshing()
            
        }, failure: { (Error) in
            print("Could not retrieve the tweet!")
            
        })
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCellTableViewCell
        
        
        let user = tweetArray[indexPath.row] ["user"] as! NSDictionary
        
        let url = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: url!)
        
        cell.name.text = user["name"] as? String
        cell.tweetContent.text = tweetArray[indexPath.row] ["text"] as? String
        if let imagedata = data {
            cell.posterImageView.image = UIImage(data: imagedata)
        }
        
        return cell
        
    }

    @IBAction func onLogout(_ sender: Any) {
        
        TwitterAPICaller.client?.logout()
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
        self.dismiss(animated: true, completion: nil)
        
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0;
    }

    
}
