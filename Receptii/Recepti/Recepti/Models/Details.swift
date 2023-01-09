//
//  Details.swift
//  Recepti
//
//  Created by MacLab6 on 5.11.22..
//

import Foundation

struct DetailsResponse: Codable {
    let meals: [[String: String?]]
}

struct Details{
    var idMeal: String
    var strMeal: String
    var strDrinkAlternate: String?
    var strCategory: String
    var strArea: String
    var strInstructions: [String]
    var strMealThumb: String
    var strTags: String
    var strYoutube: String
    var ingredients: [Ingredient]
}

struct Ingredient {
    var name: String
    var measure: String
}
