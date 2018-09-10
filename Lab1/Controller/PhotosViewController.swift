//
//  ViewController.swift
//  Lab1
//
//  Created by Sanaz Khosravi on 8/31/18.
//  Copyright © 2018 GirlsWhoCode. All rights reserved.
//

import UIKit
 import AlamofireImage

class PhotosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    

    @IBOutlet var myTable: UITableView!
    let refreshControl = UIRefreshControl()
    var posts:[[String:Any]] = []
    let HeaderViewIdentifier = "TableViewHeaderView"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.delegate = self
        myTable.dataSource = self
        myTable.rowHeight = 250
        fetchData()
        myTable.reloadData()
        
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        myTable.insertSubview(refreshControl, at: 0)
        myTable.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: HeaderViewIdentifier)

    }

    @objc func refreshControlAction(_ refreshControl: UIRefreshControl) {
        fetchData()
    }
    
    
    func fetchData(){
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        // Configure session so that completion handler is executed on main UI thread
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                // Get the posts and store in posts property
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                // Store the returned array of dictionaries in our posts property
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                self.myTable.reloadData()
                // Tell the refreshControl to stop spinning
                self.refreshControl.endRefreshing()
            }
        }
        task.resume()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myTable.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyCustomCellTableViewCell
      //  let post = posts[indexPath.row]
        let post = posts[indexPath.section]
        if let photos = post["photos"] as? [[String: Any]] {
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String: Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            cell.myImageView.af_setImage(withURL: url!)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderViewIdentifier)! as UITableViewHeaderFooterView
        headerView.contentView.frame = CGRect(x: 0, y: 0, width: 320, height: 40)
        headerView.contentView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        let profileView = UIImageView(frame: CGRect(x: 8, y: 2, width: 28, height: 28))
        profileView.clipsToBounds = true
        profileView.layer.cornerRadius = 15;
        profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).cgColor
        profileView.layer.borderWidth = 1;
        
        // set the avatar
        profileView.af_setImage(withURL: URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/avatar")!)
        headerView.addSubview(profileView)
        
        // Add a UILabel for the date here
        let dateLabel = UILabel()
        dateLabel.frame = CGRect(x: 60, y: 0, width: 220, height: 30)
        dateLabel.backgroundColor = UIColor(white: 1, alpha: 0.9)
        let post = posts[section]
        dateLabel.text = post["date"] as? String
        headerView.addSubview(dateLabel)
        
        return headerView
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! MyCustomCellTableViewCell
        let indexPath = myTable.indexPath(for: cell)
        let picture = posts[indexPath!.section]
        let detailViewController = segue.destination as! PhotoDetailViewController
        detailViewController.picture = picture
      
    }
    
    
}

