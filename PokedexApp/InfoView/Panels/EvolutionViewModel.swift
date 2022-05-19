//
//  EvolutionViewModel.swift
//  PokedexApp
//
//  Created by Stan on 18/05/2022.
//

import Foundation
import SwiftUI

struct EvolutionChainData : Hashable, Codable
{
    let chain : EvolutionChain
}

struct EvolutionChain : Hashable, Codable
{
    let evolution_details : [EvolutionDetails]?
    let evolves_to : [EvolutionChain]?
    let is_baby : Bool
    let species : ExtraData
}

struct EvolutionDetails : Hashable, Codable
{
    let item : ExtraData?
    let min_level : Int?
}

struct PokemonSpeciesData : Hashable, Codable
{
    let evolution_chain : EvolutionChainURL
}

struct EvolutionChainURL : Hashable, Codable
{
    let url : String
}

class EvolutionViewModel : ObservableObject
{
    @Published var chain : EvolutionChainData?
    
    func fetch(pokemonID : Int)
    {
        guard let url = URL(string : "https://pokeapi.co/api/v2/pokemon-species/\(pokemonID)/") else {return}
        
        URLSession.shared.dataTask(with: url)
        {
            [weak self] data, _, error in
            guard let data = data, error == nil else {return}
            
            //Convert to JSON
            do
            {
                let pokemon = try JSONDecoder().decode(PokemonSpeciesData.self, from: data)
                
                DispatchQueue.main.async
                {
                    self!.fetchChain(in_url: pokemon.evolution_chain.url)
                }
            }
            catch
            {
                print(error)
            }
        }.resume()
    }
    
    func fetchChain(in_url : String)
    {
        guard let url = URL(string : in_url) else {return}
        
        URLSession.shared.dataTask(with: url)
        {
            [weak self] data, _, error in
            guard let data = data, error == nil else {return}
            
            //Convert to JSON
            do
            {
                let pokemon_chain = try JSONDecoder().decode(EvolutionChainData.self, from: data)
                
                DispatchQueue.main.async
                {
                    self?.chain = pokemon_chain
                }
            }
            catch
            {
                print(error)
            }
        }.resume()
    }
}
