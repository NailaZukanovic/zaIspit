//
//  RestorauntsData.swift
//  Recepti
//
//  Created by Digital Atrium on 16.11.22..
//

import Foundation
import Combine

class RestorauntsData: ObservableObject {
    
    static let shared = RestorauntsData()
    @Published var restoraunts: [RestorauntLocation] = []
    var cancellables = Set<AnyCancellable>()
    
    private static let url = "https://raw.githubusercontent.com/markopex/playground/main/locations.json"
    
    func fetchAll(){
        guard let url = URL(string: Self.url) else {return}
        
        URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap(handleInput)
            .decode(type: [RestorauntLocation].self, decoder: JSONDecoder())
            .sink{
                (comp) in
                switch (comp){
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
                    
            }receiveValue: { [weak self]data in
                self?.restoraunts = data
            }.store(in: &cancellables)
        
    }
    
}
