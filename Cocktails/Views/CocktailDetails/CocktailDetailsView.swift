//
//  CocktailDetailsView.swift
//  Cocktails
//
//  Created by Johan Forsell on 2022-07-10.
//

import SwiftUI

struct CocktailDetailsView: View {
    @StateObject var viewModel: CocktailDetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                cocktailImage()
                cocktailText()
                Spacer()
            }
            .task {
                await viewModel.getCocktail()
            }
        }
    }
    
    @ViewBuilder
    private func cocktailImage() -> some View {
        if let image = viewModel.cocktailImage {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Image.placeholder
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.top, 60)
        }
    }
    
    @ViewBuilder
    private func cocktailText() -> some View {
        if let cocktail = viewModel.cocktail {
            Text(cocktail.name)
            Text(cocktail.glass)
            Text(cocktail.instructions)
            ForEach(cocktail.ingredients, id: \.self) { ingredient in
                HStack {
                    Text(ingredient.name)
                    Text(ingredient.measure ?? "")
                }
            }
        } else {
            Text("This drink seems to be missing. Sorry!")
                .font(.title2)
                .padding(.top, 40)
            Text(viewModel.errorMessage ?? "")
        }
    }
}
