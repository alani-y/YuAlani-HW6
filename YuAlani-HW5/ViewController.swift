// Project: YuAlani-HW5
// EID: ay7892
// Course: CS329E
//  ViewController.swift
//  YuAlani-HW5
//
//  Created by Alani Yu on 2/27/25.
//

import UIKit
import CoreData


let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

protocol addNewPizza {
    func addPizza(pizza: Pizza)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, addNewPizza{
   
    @IBOutlet weak var pizzaTableView: UITableView!
    
    let textCellIdentifier = "TableCell"
    let pizzaSegue = "PizzaSegue"
    
    var pizzaList:[Pizza] = [] // stores the pizzas

    override func viewDidLoad() {
        super.viewDidLoad()
        pizzaTableView.delegate = self
        pizzaTableView.dataSource = self
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pizzaList.count
    }
    
    // fills the text cell with the pizza details using the pizza's toString method
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for:indexPath as IndexPath)
        cell.textLabel?.text = pizzaList[indexPath.row].toString()
        
        return cell
    }
    
    // deletes the pizza
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pizzaList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // prepares the pizza segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "PizzaSegue",
            let pizzaVC = segue.destination as? PizzaCreationVC {
            pizzaVC.delegate = self
        }
    }
    
    // adds a pizza to core data
    func addPizza(pizza: Pizza){
        pizzaList.append(pizza)
        self.pizzaTableView.reloadData()
        
        let storedPizza = NSEntityDescription.insertNewObject(forEntityName: "StoredPizza", into: context)
        
        storedPizza.setValue(pizza.pSize, forKey: "pSize")
        storedPizza.setValue(pizza.crust, forKey: "crust")
        storedPizza.setValue(pizza.cheese, forKey: "cheese")
        storedPizza.setValue(pizza.meat, forKey: "meat")
        storedPizza.setValue(pizza.veggies, forKey: "veggies")
        
        //addRetrievedPizzas()
        
        saveContext()
    }
    
    func retrievePizza() -> [NSManagedObject]{
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        var fetchedPizzas:[NSManagedObject]?
        
        //let predicate = NSPredicate(format: "name CONTAINS[c] 'ie'")
        //request.predicate = predicate
        
        do {
            try fetchedPizzas = context.fetch(request) as? [NSManagedObject]
        } catch {
            print("Error occurred while retrieving data")
            abort()
        }
        
        return fetchedPizzas!
    }
    
    // adds the retrieved pizzas to the pizzaList
    func addRetrievedPizzas() {
        let fetchedPizzas = retrievePizza()
        
        // adds the retrieved pizzas to the pizzaList
        for storedPizza in fetchedPizzas{
            guard let pSize = storedPizza.value(forKey: "pSize") as? String,
                  let pCrust = storedPizza.value(forKey: "crust") as? String,
                  let pCheese = storedPizza.value(forKey: "cheese") as? String,
                  let pMeat = storedPizza.value(forKey: "meat") as? String,
                  let pVeggies = storedPizza.value(forKey: "veggies") as? String
            else{
                return
            }
            let newPizza = Pizza(pSize: pSize, crust: pCrust, cheese: pCheese, meat: pMeat, veggies: pVeggies)
            
            pizzaList.append(newPizza)
        }
        
        saveContext()
    }
    
    // saves the pizza context
    func saveContext () {
    
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
}

