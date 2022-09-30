//
//  ViewController.swift
//  FinalTest_Danqi
//
//  Created by Danqi Zhao on 2022-04-14.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var countriesTableView: UITableView!
    var countries:[Country] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
        countriesTableView.delegate = self
        countriesTableView.dataSource = self
    }
    
    func getData(){
        let apiEndpoint = "https://restcountries.com/v2/all"
        guard let apiURL = URL(string: apiEndpoint) else{
            print("Could not convert to URL")
            return
        }
        URLSession.shared.dataTask(with: apiURL) { data, response, error in
            if let err = error{
                print{"Fetching data error: \(err)"}
                return
            }
            if let jsonData = data{
                do{
                    let decoder = JSONDecoder()
                    let decodedItem:[Country] = try decoder.decode([Country].self, from: jsonData)
                    DispatchQueue.main.async {
                        self.countries = decodedItem
                        self.countriesTableView.reloadData()
                    }
                }
                catch let error{
                    print("JSON decoding error: \(error)")
                }
            }
        }.resume()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = countriesTableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        let currCountry = countries[indexPath.row]
        cell.textLabel!.text = currCountry.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let screen2 = storyboard?.instantiateViewController(withIdentifier: "screen2") as? Screen2ViewController else{
            print("Faild to screen2")
            return
        }
        screen2.country = countries[indexPath.row]
        show(screen2,sender: self)
    }
    
}

