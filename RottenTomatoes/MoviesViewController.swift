//
//  MoviesViewController.swift
//  RottenTomatoes
//
//  Created by Julien Lecomte on 9/12/14.
//  Copyright (c) 2014 Julien Lecomte. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var movies: [NSDictionary] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        var url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=4jvsq52hmsc9vsngu6ewrqku&limit=20&country=us"

        var request = NSURLRequest(URL: NSURL(string: url))

        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
        (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
            self.movies = object["movies"] as [NSDictionary]
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell

        var movie = movies[indexPath.row]

        cell.titleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String

        var posters = movie["posters"] as NSDictionary
        var thumbnailUrl = posters["thumbnail"] as String
        cell.posterView.setImageWithURL(NSURL(string: thumbnailUrl))

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
