//
//  DetailsViewModel.swift
//  Recepti
//
//  Created by MacLab6 on 5.11.22..
//

import Foundation
import Combine

class DetailsViewModel: ObservableObject{
    @Published var details: Details? = nil
    var detailsCancellables = Set<AnyCancellable>()
    private let dataService = RecepiesData.instance
    
    init(){
        addSubcriber()
    }
    
    private func addSubcriber(){
        dataService.$details.sink { [weak self]details in
            self?.details = details
        }.store(in: &detailsCancellables)
    }
    
    public func fetchDetails(mealId: String){
        dataService.fetchRecipesById(id: mealId)
    }
}
