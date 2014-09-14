//
//  MoviesViewController.swift
//  RottenTomatoes
//
//  Created by Julien Lecomte on 9/12/14.
//  Copyright (c) 2014 Julien Lecomte. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var refreshControl: UIRefreshControl!

    var movies: [NSDictionary] = []
    var filteredMovies: [NSDictionary] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh...")
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.addSubview(refreshControl)

        activityIndicator.center = view.center
        activityIndicator.startAnimating()

        tableView.hidden = true

        fetchMovies(false)
    }

    func fetchMovies(pullToRefresh: Bool) {
        var url = "http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=4jvsq52hmsc9vsngu6ewrqku&limit=50&country=us"

        var request = NSURLRequest(URL: NSURL(string: url))

        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            var hasError = false

            self.activityIndicator.stopAnimating()
            self.refreshControl.endRefreshing()

            if error == nil {
                var object = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as NSDictionary
                if object["error"] == nil {
                    self.movies = object["movies"] as [NSDictionary]
                    self.tableView.reloadData()
                } else {
                    hasError = true
                }
            } else {
                hasError = true
            }

            if hasError {
                var alert = UIAlertController(title: "Error", message: "The Rotten Tomatoes API returned a friggin' error...", preferredStyle: UIAlertControllerStyle.Alert)
                self.presentViewController(alert, animated: false, completion: nil)
            } else {
                self.tableView.hidden = false
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func refresh(sender:AnyObject) {
        movies = []
        tableView.reloadData()
        fetchMovies(true)
    }

    func filterContentForSearchText(searchText: String) {
        filteredMovies = movies.filter { (movie: NSDictionary) -> Bool in
            let title = movie["title"] as String
            let stringMatch = title.rangeOfString(searchText)
            return stringMatch != nil
        }
    }

    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        filterContentForSearchText(searchString)
        return true
    }

    // Needed for iOS < 8...
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 133
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchDisplayController!.searchResultsTableView {
            return filteredMovies.count
        } else {
            return movies.count
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieCell

        var movie: NSDictionary

        if tableView == searchDisplayController!.searchResultsTableView {
            movie = filteredMovies[indexPath.row]
        } else {
            movie = movies[indexPath.row]
        }

        cell.titleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String

        var posters = movie["posters"] as NSDictionary
        var thumbnailUrl = posters["thumbnail"] as String
        cell.posterView.setImageWithURL(NSURL(string: thumbnailUrl))

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)

        var movie: NSDictionary

        if tableView == searchDisplayController!.searchResultsTableView {
            movie = filteredMovies[indexPath.row]
        } else {
            movie = movies[indexPath.row]
        }

        performSegueWithIdentifier("Movie Detail", sender: movie)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        var vc = segue.destinationViewController as MovieDetailViewController

        var movie = sender as NSDictionary

        vc.movieTitle = movie["title"] as String
        vc.synopsis = movie["synopsis"] as String

        var posters = movie["posters"] as NSDictionary
        var posterUrl = posters["original"] as String

        // replace '_tmb.' by '_ori.'
        posterUrl = posterUrl.stringByReplacingOccurrencesOfString("_tmb.", withString: "_ori.", options: nil, range: nil)

        vc.posterUrl = posterUrl
    }
}
