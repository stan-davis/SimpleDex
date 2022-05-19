//
//  PokemonListView.swift
//  PokedexApp
//
//  Created by Stan on 13/05/2022.
//

import Foundation
import SwiftUI

struct PokemonListView: View
{
    @StateObject var listViewModel = PokemonListViewModel()
    @State var searchText = ""
    
    var body: some View
    {
        NavigationView
        {
            List
            {
                ForEach(listViewModel.entries.filter {searchText.isEmpty ? true : $0.pokemon_species.name.contains(searchText.lowercased()) || String($0.entry_number).contains(searchText.lowercased())}, id: \.self)
                {
                    entry in
                    
                    NavigationLink(destination: PokemonInfoView(pokemonID: entry.entry_number).navigationBarTitle(entry.pokemon_species.name.capitalized, displayMode: .large), label:
                    {
                        HStack
                        {
                            Text("\(entry.entry_number)")
                                .bold()
                            Text(entry.pokemon_species.name.capitalized)
                            AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-viii/icons/\(entry.entry_number).png")) {image in image } placeholder:
                                {
                                ProgressView()
                                }
                                .frame(width: 50, height: 50)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    })
                }
            }
            .navigationBarTitle("Pokédex", displayMode: .inline)
            .searchable(text: $searchText)
            .onAppear
            {
                listViewModel.fetch()
            }
        }
    }
}
