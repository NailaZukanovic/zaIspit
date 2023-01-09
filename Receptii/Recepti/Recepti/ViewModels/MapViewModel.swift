//
//  MapViewModel.swift
//  Recepti
//
//  Created by Digital Atrium on 16.11.22..
//

import Foundation
import Combine

class MapViewModel: ObservableObject{
    @Published var restoraunts: [RestorauntLocation] = []
    var cancellables = Set<AnyCancellable>()
    private let dataService = RestorauntsData.shared
    
    init(){
        addSubcriber()
        dataService.fetchAll()
    }
    
    func fetchAll(){
        dataService.fetchAll()
    }
    
    private func addSubcriber(){
        dataService.$restoraunts.sink { [weak self]data in
            self?.restoraunts = data
        }.store(in: &cancellables)
    }
}
