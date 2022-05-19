//
//  LocationsViewModel.swift
//  PokedexApp
//
//  Created by Stan on 19/05/2022.
//

import Foundation
import SwiftUI

struct Locations : Hashable, Codable
{
    let location_area : ExtraData
}

class LocationsViewModel: ObservableObject
{
    @Published var locations : [Locations] = []
    
    func fetch(pokemonID : Int)
    {
        guard let url = URL(string : "https://pokeapi.co/api/v2/pokemon/\(pokemonID)/encounters") else {return}
        
        URLSession.shared.dataTask(with: url)
        {
            [weak self] data, _, error in
            guard let data = data, error == nil else {return}
            
            //Convert to JSON
            do
            {
                let locations = try JSONDecoder().decode([Locations].self, from: data)
                
                DispatchQueue.main.async
                {
                    self?.locations = locations
                }
            }
            catch
            {
                print(error)
            }
        }.resume()
    }
}
