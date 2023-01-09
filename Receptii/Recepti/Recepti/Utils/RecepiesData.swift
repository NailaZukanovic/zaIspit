//
//  RecepiesData.swift
//  Recepti
//
//  Created by MacLab6 on 22.10.22..
//

import Foundation
import Combine
class RecepiesData: ObservableObject {
    static let instance = RecepiesData()
    @Published var categories : [Category] = []
    @Published var meals : [Meals] = []
    @Published var details : Details? = nil
    var categoriesCancellables = Set<AnyCancellable>()
    var recipesCancellables = Set<AnyCancellable>()
    
    init() {
        fetchCategories()
    }
    
    static let baseUrl = "https://www.themealdb.com/api/json/v1/1/"
    
    static let categoryUrl = baseUrl + "categories.php";
    
    static let recipesUrl = baseUrl + "filter.php?c=";
    
    static let detailUrl = baseUrl + "lookup.php?i=";
    func fetchCategories() {
        guard let url = URL(string: RecepiesData.categoryUrl) else {return}
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleInput)
            .decode(type: CategoriesResponse.self, decoder: JSONDecoder())
            .sink{
                (comp) in
                switch (comp){
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
                    
            }receiveValue: { [weak self]categoriesResponse in
                self?.categories = categoriesResponse.categories
            }.store(in: &categoriesCancellables)
        
    }
    
    func fetchRecipesByCategory(category: Category){
        guard let url = URL(string: RecepiesData.recipesUrl + category.strCategory) else {return}
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleInput)
            .decode(type: RecipesResponse.self, decoder: JSONDecoder())
            .sink{
                (comp) in
                switch (comp){
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
                    
            }receiveValue: { [weak self]recipesResponse in
                self?.meals = recipesResponse.meals
            }.store(in: &recipesCancellables)
        
    }
    
    func fetchRecipesById(id: String){
        guard let url = URL(string: RecepiesData.detailUrl + id) else {return}
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleInput)
            .decode(type: DetailsResponse.self, decoder: JSONDecoder())
            .sink{
                (comp) in
                switch (comp){
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
                    
            }receiveValue: { [weak self]detailsResponse in
                let recipes = detailsResponse.meals[0]
                var details = Details(idMeal: recipes["idMeal"]! ?? "", strMeal: recipes["strMeal"]! ?? "", strCategory: recipes["strCategory"]! ?? "", strArea: recipes["strArea"]! ?? "", strInstructions: [], strMealThumb: recipes["strMealThumb"]! ?? "", strTags: recipes["strTags"]! ?? "", strYoutube: recipes["strYoutube"]! ?? "", ingredients: [])
                details.strInstructions = (recipes["strInstructions"]! ?? "").components(separatedBy: "\n")
                for i in 1...20 {
                    let name = recipes["strIngredient\(i)"]!
                    let measure = recipes["strMeasure\(i)"]!
                    if let nm = name{
                        if(nm.isEmpty){
                            continue
                        }
                        let ingredient = Ingredient(name: nm, measure: measure!)
                        details.ingredients.append(ingredient)
                    }
                }
                self?.details = details;
            }.store(in: &recipesCancellables)
    }
}
