//
//  StatsView.swift
//  PokedexApp
//
//  Created by Stan on 16/05/2022.
//

import Foundation
import SwiftUI

struct StatsView: View
{
    var stats : [Stats] = []
    
    var body: some View
    {
        VStack(alignment: .leading, spacing: 20)
        {
            ForEach(stats, id: \.self)
            {
                stat in
                
                HStack
                {
                    Text("\(stat.stat.name.capitalized)")
                        .foregroundColor(Color.gray)
                        .frame(width: 130, alignment: .leading)
                    Spacer()
                    Text("\(stat.base_stat)")
                        .bold()
                        .frame(width: 35, alignment: .leading)
                        .padding(.horizontal, 5)
                    Spacer()
                    ZStack(alignment: .leading)
                    {
                        Rectangle()
                            .fill(Color.gray)
                        Rectangle()
                            .fill(Color.green)
                            .frame(width: CGFloat(stat.base_stat))
                    }
                    .frame(height: 5)
                }
            }
        }
        .padding()
    }
}
