//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Mahmuda Akter on 2/25/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var fabButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var favorited:Bool = false
    var tweetId: Int = -1
    
    @IBAction func favorite(_ sender: Any) {
        let toBefavorite = !favorited
        if(toBefavorite) {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setfavorite(true)
            }, failure: { (Error) in
                print("Favorite did not succeed \(Error)")
                
            })
        } else {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setfavorite(false)
            }, failure: { (Error) in
                print("Unfavorite did not succeed \(Error)")
                
            })
        }
        
    }
    @IBAction func retweet(_ sender: Any) {
        
        TwitterAPICaller.client?.reTweet(tweetId: tweetId, success: {
            self.setRetweeted(true)
        }, failure: { (Error) in
            print("Error to retweet \(Error)")
        })
    }
    
    func setRetweeted(_ isRetweeted: Bool) {
        
        if(isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
            
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
    
    
    
    
    func setfavorite(_ isfavorited:Bool) {
        favorited = isfavorited
        if(favorited) {
            fabButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else {
            fabButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
