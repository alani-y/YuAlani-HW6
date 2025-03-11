// Project: YuAlani-HW5
// EID: ay7892
// Course: CS329E
//  PizzaCreationVC.swift
//  YuAlani-HW5
//
//  Created by Alani Yu on 2/27/25.
//

import UIKit

class PizzaCreationVC: UIViewController {

    @IBOutlet weak var size: UISegmentedControl!
    @IBOutlet weak var pizzaString: UILabel!
    
    var pSizeChoice = "Small";
    var crustChoice = "";
    var cheeseChoice = "";
    var meatChoice = "";
    var veggieChoice = "";
    
    var delegate: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onSegmentChanged(_ sender: Any){
        switch size.selectedSegmentIndex{
        case 1:
            pSizeChoice = "Medium"
        case 2:
            pSizeChoice = "Large"
        default:
            pSizeChoice = "Small"
        }
    }
    
    // gets the user's crust choice
    @IBAction func onSelectCrust(_ sender: Any){
        let crustController = UIAlertController(
            title: "Select Crust",
            message:"Choose a Crust Type",
            preferredStyle: .alert)
        
        // option for thin crust
        crustController.addAction(UIAlertAction(
            title: "Thin Crust",
            style: .default,
            handler: alertHandler(alert:)
        ))
        // option for thick crust
        crustController.addAction(UIAlertAction(
            title: "Thick Crust",
            style: .default,
            handler: alertHandler(alert:)
        ))
        
        present(crustController, animated: true)
    }
    
    // stores the crust choice
    func alertHandler(alert:UIAlertAction) {
        crustChoice = alert.title!
    }
    
    // gets the user's cheese choice
    @IBAction func onSelectCheese(_ sender: Any){
        let cheeseController = UIAlertController(
            title: "Select Cheese",
            message: "Choose a Cheese Type",
            preferredStyle: .actionSheet)
    
        // option for no cheese
        cheeseController.addAction(UIAlertAction(title: "No Cheese", style: .default)
            { [self] (action) in cheeseChoice = "No Cheese"} )
        
        // option for regular cheese
        cheeseController.addAction(UIAlertAction(title: "Regular Cheese", style: .default)
            { [self] (action) in cheeseChoice = "Regular Cheese" } )
        
        // option for double cheese
        cheeseController.addAction(UIAlertAction(title: "Double Cheese", style: .default)
            { [self] (action) in cheeseChoice = "Double Cheese" } )
        
        present(cheeseController, animated: true)
        
    }
    
    // gets the user's meat choice
    @IBAction func onSelectMeat(_ sender: Any){
        let meatController = UIAlertController(
            title: "Select Meat",
            message: "Choose One Meat",
            preferredStyle: .actionSheet)
    
        // option for pepperoni
        meatController.addAction(UIAlertAction(title: "Pepperoni", style: .default)
            { [self] (action) in meatChoice = "Pepperoni"} )
        
        // option for sausage
        meatController.addAction(UIAlertAction(title: "Sausage", style: .default)
            { [self] (action) in meatChoice = "Sausage" } )
        
        // option for double cheese
        meatController.addAction(UIAlertAction(title: "Canadian Bacon", style: .default)
            { [self] (action) in meatChoice = "Canadian Bacon" } )
        
        present(meatController, animated: true)
    }
    
    @IBAction func onSelectVeggies(_ sender:Any){
        let veggieController = UIAlertController(
            title: "Select Veggies",
            message: "Choose Your Veggies",
            preferredStyle: .actionSheet)
    
        // option for mushrooms
        veggieController.addAction(UIAlertAction(title: "Mushrooms", style: .default)
            { [self] (action) in veggieChoice = "Mushrooms"} )
        
        // option for onions
        veggieController.addAction(UIAlertAction(title: "Onion", style: .default)
            { [self] (action) in veggieChoice = "Onion" } )
        
        // option for green olives
        veggieController.addAction(UIAlertAction(title: "Green Olives", style: .default)
            { [self] (action) in veggieChoice = "Green Olives" } )
        
        veggieController.addAction(UIAlertAction(title: "Black Olives", style: .default)
            { [self] (action) in veggieChoice = "Black Olives" } )
        
        veggieController.addAction(UIAlertAction(title: "None", style: .default)
            { [self] (action) in veggieChoice = "None" } )
        
        present(veggieController, animated: true)
    }
    
    // Displays the user's pizza selection
    @IBAction func onDoneButton(_ sender: Any){
        
        let missingIngController = UIAlertController(
            title: "Missing Ingredient",
            message: "",
            preferredStyle: .alert
        )
        
        missingIngController.addAction(UIAlertAction(title: "OK", style: .default))
        
        switch (crustChoice, cheeseChoice, meatChoice, veggieChoice){
        case ("", _, _, _):
            missingIngController.message = "Please select a crust type."
            present(missingIngController, animated: true)
        case (_, "", _, _):
            missingIngController.message = "Please select a cheese type."
            present(missingIngController, animated: true)
        case ( _, _, "", _):
            missingIngController.message = "Please select a meat option."
            present(missingIngController, animated: true)
        case ( _, _, _, ""):
            missingIngController.message = "Please select a veggie option."
            present(missingIngController, animated: true)
        default:
            
            let userPizza = Pizza(pSize: pSizeChoice, crust: crustChoice, cheese: cheeseChoice, meat: meatChoice, veggies: veggieChoice)
            
            pizzaString.isHidden = false
            pizzaString.text = userPizza.toString()
            
            let menuVC = delegate as! addNewPizza
            // adds the userPizza to the pizzaList array
            menuVC.addPizza(pizza: userPizza)
        }
    }

}
