//
//  AllPokemonViewController.swift
//  Pokedex
//
//  Created by Andrew Beauchamp on 11/14/18.
//  Copyright © 2018 Andrew Beauchamp. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AllPokemonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var allPokemonTableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return pokemonNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell")
        cell?.textLabel?.text = pokemonNames[indexPath.row]
        return cell!
    }
    
    // an array to hold all the pokemon names
    var pokemonNames: [String] = [ ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //URL for the request to get back all pokemon
        let url = "https://pokeapi.co/api/v2/pokemon/"
        
        //alamofire request made from that url
        let alamoFireRequest = Alamofire.request(url)
        
        //carry out the request and get back from the response JSON
        alamoFireRequest.responseJSON { response in
            
            //switch based on the result of the response
            switch response.result {
            case .success(let value):
                print(value)
                
                //convert our response json to a swiftyjson object
                let json = JSON(value)
                //Attempting to pull results from the JSON
                if let results = json["results"].array {
                    for result in results{
                        //Attempting to pull out the pokemon name from each results element
                        if let pokemonNAme =
                            result["name"].string {
                            self.pokemonNames.append(pokemonNAme.capitalized)
                        }
                    }
                    //Reload view
                    self.allPokemonTableView.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
}
