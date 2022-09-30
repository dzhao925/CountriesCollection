//
//  Country.swift
//  FinalTest_Danqi
//
//  Created by Danqi Zhao on 2022-04-14.
//

import Foundation
class Country:Codable{
    var name:String = ""
    var capital:String = ""
    var code:String = ""
    var population:Int = 0
    
    enum CodingKeys: String,CodingKey {
        case name = "name"
        case capital = "capital"
        case code = "alpha3Code"
        case population = "population"
    }
    
    func encode(to encoder: Encoder) throws {
        
    }
    
    init(name:String,capital:String,code:String,population:Int){
        self.name = name
        self.code = code
        self.capital = capital
        self.population = population
    }
    
    required init(from decoder: Decoder) throws {
        let response = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try response.decodeIfPresent(String.self, forKey: CodingKeys.name) ?? ""
        self.capital = try response.decodeIfPresent(String.self, forKey: CodingKeys.capital) ?? ""
        self.code = try response.decode(String.self, forKey: CodingKeys.code) ?? ""
        self.population = try response.decode(Int.self, forKey: CodingKeys.population) ?? 0
    }
}
