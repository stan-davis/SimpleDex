//
//  PokemonContentView.swift
//  PokedexApp
//
//  Created by Stan on 13/05/2022.
//

import Foundation
import SwiftUI

struct PokemonInfoView: View
{
    @StateObject var infoViewModel = PokemonInfoViewModel()
    @State var currentTab: Int = 0
    
    var pokemonID : Int
    var typeColors : [String: Color] = [
        "normal": Color(red: 0.658, green: 0.658, blue: 0.471),
        "fire": Color(red: 0.94, green: 0.5, blue: 0.188),
        "fighting": Color(red: 0.75, green: 0.188, blue: 0.156),
        "water": Color(red: 0.4, green: 0.56, blue: 0.94),
        "flying": Color(red: 0.66, green: 0.56, blue: 0.94),
        "grass": Color(red: 0.47, green: 0.78, blue: 0.31),
        "poison": Color(red: 0.7, green: 0.25, blue: 0.63),
        "electric": Color(red: 0.97, green: 0.82, blue: 0.18),
        "ground": Color(red: 0.87, green: 0.75, blue: 0.4),
        "psychic": Color(red: 0.97, green: 0.34, blue: 0.54),
        "rock": Color(red: 0.72, green: 0.63, blue: 0.22),
        "ice": Color(red: 0.59, green: 0.84, blue: 0.84),
        "bug": Color(red: 0.65, green: 0.72, blue: 0.12),
        "dragon": Color(red: 0.43, green: 0.22, blue: 0.97),
        "ghost": Color(red: 0.44, green: 0.34, blue: 0.59),
        "dark": Color(red: 0.44, green: 0.34, blue: 0.28),
        "steel": Color(red: 0.72, green: 0.72, blue: 0.81),
        "fairy": Color(red: 0.93, green: 0.6, blue: 0.67),
        "undefined" :Color(red: 1.0, green: 1.0, blue: 1.0)
    ]
    
    var body: some View
    {
        VStack
        {
            VStack
            {
                HStack
                {
                    //Types
                    ForEach(infoViewModel.types, id: \.self)
                    {
                        type in
                        
                        Text("\(type.type.name.capitalized)")
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .padding(.vertical, 2)
                            .frame(width: 70)
                            .background(RoundedRectangle(cornerRadius: 8).fill(typeColors[type.type.name]!).shadow(radius: 2))
                    }
                }
                
                //Main Image
                AsyncImage(url: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(pokemonID).png")){image in image.resizable() } placeholder:
                {
                ProgressView()
                }
                .frame(width: 200, height: 200)
            }
            .padding()

            
            //Insert tab bar here
            ZStack(alignment: .top)
            {
                TabView(selection: self.$currentTab)
                {
                    AboutView(height: infoViewModel.height, weight: infoViewModel.weight, abilities: infoViewModel.abilities).tag(0)
                    StatsView(stats: infoViewModel.stats).tag(1)
                    MovesView(moves: infoViewModel.moves).tag(2)
                    EvolutionView(pokemonID: pokemonID).tag(3)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .background(Color.white)
                .padding(.top, 50)
                
                TabBarView(currentTab: self.$currentTab)
            }
        }
        .onAppear
        {
            infoViewModel.fetch(pokemonID: pokemonID)
        }
        .background(LinearGradient(colors: [typeColors[infoViewModel.types.first?.type.name ?? "undefined"] ?? Color.white, Color.white], startPoint: .top, endPoint: .bottom))
    }
}

struct TabBarView: View
{
    @Binding var currentTab: Int
    var tabTitles: [String] = ["About", "Base Stats", "Moves", "Evolutions"]
    
    var body: some View
    {
        ScrollView(.horizontal, showsIndicators: false)
        {
            HStack(spacing: 20)
            {
                ForEach(Array(zip(self.tabTitles.indices, self.tabTitles)), id: \.0)
                {
                    index, name in
                    
                    TabBarItem(currentTab: self.$currentTab, tabTitle: name, tabID: index)
                }
            }
            .padding()
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .frame(height: 50)
    }
}

struct TabBarItem: View
{
    @Binding var currentTab: Int
    @Namespace var namespace
    
    var tabTitle: String
    var tabID: Int
    
    var body: some View
    {
        Button
        {
            self.currentTab = tabID
        } label:
        {
            VStack()
            {
                Text(tabTitle)
                if currentTab == tabID
                {
                    Color.black
                        .frame(height: 2)
                        .matchedGeometryEffect(id: "underline", in: namespace, properties: .frame)
                }
            }
            .animation(.spring(), value: self.currentTab)
        }
        .buttonStyle(.plain)
    }
}

struct PokemonInfoView_Previews: PreviewProvider
{
    static var previews: some View
    {
        PokemonInfoView(pokemonID: 1)
    }
}
