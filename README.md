iOS Rotten Tomatoes App
=======================

Mandatory User Stories
----------------------

* User can view a list of movies from Rotten Tomatoes. Poster images must be loading asynchronously.
* User can view movie details by tapping on a cell
* User sees loading state while waiting for movies API. You can use one of the 3rd party libraries here (Links to an external site.).
* User sees error message when there's a networking error. You may not use UIAlertView to display the error. See this screenshot for what the error message should look like: network error screenshot (Links to an external site.).
* User can pull to refresh the movie list.

Optional User Stories
---------------------

* All images fade in.
* For the large poster, load the low-res image first, switch to high-res when complete.
* All images should be cached in memory and disk. In other words, images load immediately upon cold start.
* Customize the highlight and selection effect of the cell.
* Customize the navigation bar.
* Add a tab bar for Box Office and DVD.
* Add a search bar.

Additional Requirements
-----------------------

* Must use Cocoapods.
* Asynchronous image downloading must be implemented using the UIImageView category in the AFNetworking library.

Screen Capture
--------------

TODO :)
