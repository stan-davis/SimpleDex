//
//  AboutView.swift
//  PokedexApp
//
//  Created by Stan on 16/05/2022.
//

import Foundation
import SwiftUI

struct AboutView: View
{
    var height : Float = 0
    var weight : Float = 0
    var abilities : [Abilities] = []
    
    var body: some View
    {
        HStack()
        {
            VStack(alignment: .leading, spacing: 20)
            {
                Text("Height")
                Text("Weight")
                Text("Abilities")
            }
            .foregroundColor(Color.gray)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 20)
            {
                Text(String(format:"%.01f", height) + " m")
                Text(String(format:"%.01f", weight) + " kg")
                HStack
                {
                    ForEach(abilities, id: \.self)
                    {
                        ability in
                        
                        if ability != abilities.last
                        {
                            Text("\(ability.ability.name.capitalized),")
                        }
                        else
                        {
                            Text("\(ability.ability.name.capitalized)")
                        }
                    }
                }
            }
        }
        .padding()
    }
}
