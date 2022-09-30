//
//  Screen3ViewController.swift
//  FinalTest_Danqi
//
//  Created by Danqi Zhao on 2022-04-14.
//

import UIKit
import CoreData

class Screen3ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var favoriteTableView: UITableView!
    var favorites:[Favorite] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        favorites.removeAll()
        fetchAll(_sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoriteTableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath)
        let currCountry = favorites[indexPath.row]
        cell.textLabel!.text = currCountry.name
        cell.detailTextLabel!.text = "Population: \(currCountry.population)"

        if(currCountry.population > 38005238){
            cell.backgroundColor = UIColor.yellow
        }else{
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteFavorite(_sender: self, name: favorites[indexPath.row].name!)
            self.favorites.remove(at: indexPath.row)
            favoriteTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func fetchAll(_sender:Any){
        let request:NSFetchRequest<Favorite> = Favorite.fetchRequest()
        do{
            favorites = try self.context.fetch(request)
            favoriteTableView.reloadData()
        }catch{
            print("Fetching error")
        }
    }
    
    func deleteFavorite(_sender:Any,name:String){
        let request:NSFetchRequest<Favorite> = Favorite.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        do{
            let result = try self.context.fetch(request)
            self.context.delete(result.first!)
            try self.context.save()
        }catch{
            print("Delete failed")
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
