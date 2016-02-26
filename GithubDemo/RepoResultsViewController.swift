//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD

// Main ViewController
class RepoResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
//    @IBOutlet weak var tableView: UITableView!
    
    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    var repos: [GithubRepo]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar

        // Perform the first search when the view controller first loads
        doSearch()
    }

    // Perform the search.
    private func doSearch() {
    
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            // Print the returned repositories to the output window
            for repo in newRepos {
                self.repos = newRepos
                
//                self.tableView.reloadData()
                print(repo)
                
            }   

            MBProgressHUD.hideHUDForView(self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //    if let subRepo = repos {
        //        return subRepo.count
        //    }else{
        return 0
        //    }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("RepoResultsCell", forIndexPath: indexPath) as! RepoResultsCell
        //    let subRepo = repos![indexPath.row]
        //
        //    cell.nameLabel.text = subRepo.name
        //    cell.ownerHandleLabel.text = subRepo.ownerHandle
        //
        //    //convert int to string
        //    let forkCount = subRepo.forks
        //    cell.forkCount.text = String(format: "%d", forkCount!)
        //
        //    let starsCount = subRepo.stars
        //    cell.starLabel.text = String(format: "%d", starsCount!)
        //
        //    let avatarURL = NSURL(string: subRepo.ownerAvatarURL!)
        //    cell.ownerAvatar.setImageWithURL(avatarURL!)
        //    
        //    cell.descriptionLabel.text = subRepo.details
        
        return cell
    }
}






// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true;
    }

    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true;
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}