//
//  TweetViewController.swift
//  Twitter
//
//  Created by Mahmuda Akter on 3/4/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        textView.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancel(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any) {
        
        if(!textView.text.isEmpty) {
            TwitterAPICaller.client?.postTweet(tweetString: textView.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (Error) in
                print("Error post tweet \(Error)")
                self.dismiss(animated: true, completion: nil)
                
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    @IBOutlet weak var textView: UITextView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
