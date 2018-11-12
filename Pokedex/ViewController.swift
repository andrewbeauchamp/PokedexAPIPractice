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

class ViewController: UIViewController {

    let pokemonAPIBaseURL = "https://pokeapi.co/docs/v2"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBOutlet weak var pokemonIDTextField: UITextField!
    @IBOutlet weak var pokemonDescTextView: UITextView!
    
    
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
        let requestURL = pokemonAPIBaseURL + pokemonID
        
}
}
