//
//  MovesView.swift
//  PokedexApp
//
//  Created by Stan on 17/05/2022.
//

import Foundation
import SwiftUI

struct MovesView: View
{
    var moves: [Moves] = []
    
    var body: some View
    {
        ScrollView
        {
            VStack(alignment: .leading, spacing: 20)
            {
                ForEach(moves.sorted(by: {$0.version_group_details.last?.level_learned_at ?? 0 > $1.version_group_details.last?.level_learned_at ?? 0}), id: \.self)
                {
                    move in
                    
                    ForEach(move.version_group_details.filter({$0.move_learn_method.name.contains("level-up") && $0.version_group.name.contains("sword-shield")}), id: \.self)
                    {
                        details in
                        
                        HStack
                        {
                            Text(move.move.name.replacingOccurrences(of: "-", with: " ").capitalized)
                                .foregroundColor(Color.gray)
                                .frame(width: 130, alignment: .leading)
                            Spacer()
                            Text("\(details.level_learned_at)")
                                .bold()
                                .frame(width: 45, alignment: .leading)
                        }
                    }
                }
            }
        }
        .padding()
    }
}
