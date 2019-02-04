//
//  ViewController.swift
//  mn
//
//  Created by Mayra Ochoa on 2/3/19.
//  Copyright © 2019 codepath. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var movies = [[String:Any]]()
    
    @IBOutlet weak var tableView: UITableView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource =  self
        tableView.delegate =  self
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.movies = dataDictionary["results"] as! [[String:Any]]
                self.tableView.reloadData()
                print(dataDictionary)
                // TODO: Get the array of movies
                // TODO: Store the movies in a property to use elsewhere
                // TODO: Reload your table view data
                
            }
        }
        task.resume()
    }
    
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int)->Int{
        return movies.count
    }
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath)
        ->UITableViewCell{
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
            
            let movie = movies[indexPath.row]
            let title = movie["title"] as! String
            let synopsis = movie["overview"] as! String
            
            cell.titleLabel.text = title
            cell.syspnosisLabel.text = synopsis
            
            let baseUrl = "https://image.tmdb.org/t/p/w185"
            let posterPath=movie["poster_path"] as! String
            let posterUrl = URL(string: baseUrl + posterPath)
            
            cell.posterView.af_setImage(withURL: posterUrl!)
            return cell
            
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
}


