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

    var movieTitle = ""
    var synopsis = ""
    var posterUrl = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        title = movieTitle
        synopsisLabel.text = synopsis
        posterView.setImageWithURL(NSURL(string: posterUrl))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
