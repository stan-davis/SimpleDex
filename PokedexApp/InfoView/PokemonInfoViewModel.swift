//
//  PokemonInfoViewModel.swift
//  PokedexApp
//
//  Created by Stan on 14/05/2022.
//

import Foundation
import SwiftUI

struct ExtraData : Hashable, Codable
{
    let name : String
}

struct Pokemon : Hashable, Codable
{
    let types : [Types]
    let stats : [Stats]
    let moves : [Moves]
    let abilities : [Abilities]
    let height: Float
    let weight: Float
}

struct Moves : Hashable, Codable
{
    let move : ExtraData
    let version_group_details : [VersionGroupDetails]
}

struct VersionGroupDetails : Hashable, Codable
{
    let level_learned_at : Int
    let move_learn_method : ExtraData
    let version_group : ExtraData
}

struct Types : Hashable, Codable
{
    let slot : Int
    let type : ExtraData
}

struct Stats : Hashable, Codable
{
    let base_stat : Int
    let stat : ExtraData
}

struct Abilities : Hashable, Codable
{
    let ability : ExtraData
    let is_hidden : Bool
}

class PokemonInfoViewModel : ObservableObject
{
    @Published var types : [Types] = []
    @Published var stats : [Stats] = []
    @Published var moves : [Moves] = []
    @Published var abilities : [Abilities] = []
    @Published var height : Float = 0
    @Published var weight: Float = 0
    
    func fetch(pokemonID : Int)
    {
        guard let url = URL(string : "https://pokeapi.co/api/v2/pokemon/\(pokemonID)/") else {return}
        
        URLSession.shared.dataTask(with: url)
        {
            [weak self] data, _, error in
            guard let data = data, error == nil else {return}
            
            //Convert to JSON
            do
            {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                
                DispatchQueue.main.async
                {
                    //get pokemon data here
                    self?.types = pokemon.types
                    self?.stats = pokemon.stats
                    self?.abilities = pokemon.abilities
                    self?.height = pokemon.height / 10
                    self?.weight = pokemon.weight / 10
                    self?.moves = pokemon.moves
                }
            }
            catch
            {
                print(error)
            }
        }.resume()
    }
}
