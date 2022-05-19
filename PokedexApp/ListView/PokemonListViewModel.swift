//
//  ViewModel.swift
//  PokedexApp
//
//  Created by Stan on 09/05/2022.
//

import Foundation
import SwiftUI

struct Pokedex : Hashable, Codable
{
    let pokemon_entries : [PokemonEntries]
}

struct PokemonEntries : Hashable, Codable
{
    let entry_number : Int
    let pokemon_species : PokemonSpecies
}

struct PokemonSpecies : Hashable, Codable
{
    let name : String
    let url : String
}

class PokemonListViewModel : ObservableObject
{
    @Published var entries : [PokemonEntries] = []
    @Published var sprites : [String] = []
    
    func fetch()
    {
        guard let url = URL(string : "https://pokeapi.co/api/v2/pokedex/national") else {return}
        
        URLSession.shared.dataTask(with: url)
        {
            [weak self] data, _, error in
            guard let data = data, error == nil else {return}
            
            //Convert to JSON
            do
            {
                let pokemon = try JSONDecoder().decode(Pokedex.self, from: data)
                
                DispatchQueue.main.async
                {
                    //get pokemon data here
                    self?.entries = pokemon.pokemon_entries
                }
            }
            catch
            {
                print(error)
            }
        }.resume()
    }
}
