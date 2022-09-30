//
//  Screen2ViewController.swift
//  FinalTest_Danqi
//
//  Created by Danqi Zhao on 2022-04-14.
//

import UIKit
import CoreData

class Screen2ViewController: UIViewController {

    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCapital: UILabel!
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblPopulation: UILabel!
    var country:Country?
    var nameReceived:String = ""
    var populationReceived:Int = 0
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let name = country?.name,let capital = country?.capital,let code = country?.code,let population = country?.population else {
            lblError.text = "Sorry, no country information found"
            return
        }
        
        lblName.text = "Name: \(name)"
        nameReceived = name
        lblCapital.text = "Capital: \(capital)"
        lblCode.text = "Code: \(code)"
        lblPopulation.text = "Population: \(population)"
        populationReceived = population
    }
    
    @IBAction func addButtonPressed(_ sender: Any) {
        if(nameReceived == "" || populationReceived == 0){
            print("Cannot add")
        }else{
            var newFavorite:Bool = true            
            let request:NSFetchRequest<Favorite> = Favorite.fetchRequest()
            do{
                let allFavorites = try self.context.fetch(request)
                
                for favorite in allFavorites {
                    if(favorite.name == nameReceived){
                        newFavorite = false
                    }
                }
            }catch{
                print("Fetching error")
            }
            

            
            if(newFavorite){
                addFavorite(name: nameReceived,population: populationReceived)
                let box = UIAlertController(title: "Adding Favorite", message: "Add Success", preferredStyle: .alert)
                box.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                self.present(box,animated: true)
            }else{
                let box = UIAlertController(title: "Adding Favorite", message: "The country is alread exist", preferredStyle: .alert)
                box.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
                self.present(box,animated: true)
            }
            
        }
        
    }
    
    func addFavorite(name:String,population:Int){
        let favorite:Favorite = Favorite(context: self.context)
        favorite.name = name
        favorite.population = Int32(population)
        
        do{
            try self.context.save()
        }catch{
            print("Save failed")
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
