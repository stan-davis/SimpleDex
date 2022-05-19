//
//  LocationsView.swift
//  PokedexApp
//
//  Created by Stan on 19/05/2022.
//

import Foundation
import SwiftUI

struct LocationsView: View
{
    @StateObject var locationsViewModel = LocationsViewModel()
    var pokemonID : Int
    
    var body: some View
    {
        ScrollView
        {
            VStack(alignment: .leading, spacing: 20)
            {
                ForEach(locationsViewModel.locations, id: \.self)
                {
                    location in
                    
                    Text(location.location_area.name.replacingOccurrences(of: "-", with: " ").replacingOccurrences(of: "area", with: "").capitalized)
                        .bold()
                }
            }
            .onAppear
            {
                locationsViewModel.fetch(pokemonID: pokemonID)
            }
        }
        .padding()
    }
}
