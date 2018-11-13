//
//  ViewController.swift
//  Pokedex
//
//  Created by Andrew Beauchamp on 11/12/18.
//  Copyright © 2018 Andrew Beauchamp. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController {

    let pokemonAPIBaseURL = "https://pokeapi.co/api/v2/pokemon/"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBOutlet weak var pokemonIDTextField: UITextField!
    @IBOutlet weak var pokemonDescTextView: UITextView!
    @IBOutlet weak var spriteImage: UIImageView!
    
    
    @IBAction func submitButtonTapped(_ sender: Any) {
        
        pokemonIDTextField.resignFirstResponder()
        //Checking to make sure the text field has a value
        guard let pokemonID = pokemonIDTextField.text else {
            return
    }
        
        //clearing out text field
        pokemonIDTextField.text = ""
        //Replacing spaces in the name/title with + so they can be used as part of the url
        let pokemonIDURL = pokemonID.replacingOccurrences(of: " ", with: "+")
        //Building our complete request URL
        let requestURL = pokemonAPIBaseURL + pokemonIDURL
        
        Alamofire.request(requestURL).responseJSON {(response ) in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.pokemonDescTextView.text = json["name"].stringValue
                let imageURL = URL(string:  "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(pokemonIDURL).png")
                if let url = imageURL {
                    self.spriteImage.sd_setImage(with: imageURL)
                }
                
            case .failure(let error) :
                self.pokemonDescTextView.text = "Invalid selection entered or an error occured please try again"
                print(error.localizedDescription)
            }
        }
 
    }
}

