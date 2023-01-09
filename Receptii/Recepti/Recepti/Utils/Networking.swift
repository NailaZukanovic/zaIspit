//
//  Networking.swift
//  Recepti
//
//  Created by Digital Atrium on 16.11.22..
//

import Foundation

func handleInput(output: URLSession.DataTaskPublisher.Output) throws-> Data{
    guard let response = output.response as? HTTPURLResponse, (response.statusCode >= 200 && response.statusCode <= 300) else
    { throw URLError(.badServerResponse)}
    
    return output.data;
}
