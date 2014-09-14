//
//  MovieDetailViewController.swift
//  RottenTomatoes
//
//  Created by Julien Lecomte on 9/12/14.
//  Copyright (c) 2014 Julien Lecomte. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var synopsisLabel: UILabel!
    @IBOutlet weak var synopsisViewContainer: UIView!

    var movieTitle = ""
    var synopsis = ""
    var posterUrl = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Stretch the views, in code since I don't know how to use auto layout and other fancy iOS features :)

        var h = synopsisViewContainer.frame.height
        var y = view.frame.height - h
        var w = view.frame.width
        synopsisViewContainer.frame = CGRectMake(0, y, w, h)

        var x = synopsisLabel.frame.origin.x
        y = synopsisLabel.frame.origin.y
        w = view.frame.width - 2 * x
        h = synopsisLabel.frame.height
        synopsisLabel.frame = CGRectMake(x, y, w, h)

        title = movieTitle
        synopsisLabel.text = synopsis
        posterView.setImageWithURL(NSURL(string: posterUrl))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
