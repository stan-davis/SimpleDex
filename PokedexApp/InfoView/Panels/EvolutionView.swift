//
//  EvolutionView.swift
//  PokedexApp
//
//  Created by Stan on 18/05/2022.
//

import Foundation
import SwiftUI

struct EvolutionView: View
{
    @StateObject var evolutionViewModel = EvolutionViewModel()
    var pokemonID : Int
    
    var body: some View
    {
        //This is hideous I know but there is no other way
        
        VStack(spacing: 20)
        {
            Text("\(evolutionViewModel.chain?.chain.species.name.capitalized ?? "")")
                .bold()
            
            if ((evolutionViewModel.chain?.chain.evolves_to) != nil)
            {
                ForEach((evolutionViewModel.chain?.chain.evolves_to)!, id: \.self)
                {
                    evo_layer_1 in
                    
                    Text("\(evo_layer_1.species.name.capitalized)")
                        .bold()
                    
                    if ((evo_layer_1.evolves_to) != nil)
                    {
                        ForEach((evo_layer_1.evolves_to)!, id: \.self)
                        {
                            evo_layer_2 in
                            
                            Text("\(evo_layer_2.species.name.capitalized)")
                                .bold()
                            
                        }
                    }
                }
            }
            
            
        }
        .onAppear
        {
            evolutionViewModel.fetch(pokemonID: pokemonID)
        }
        .padding()
    }
}
