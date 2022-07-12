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
        ScrollView(showsIndicators: false) {
            VStack(alignment: viewModel.cocktail != nil ? .leading : .center) {
                cocktailImage()
                cocktailText()
                    .padding(basePadding)
                Spacer()
            }
        }
        .task {
            await viewModel.getCocktail()
        }
    }
}

// MARK: - Main view components

extension CocktailDetailsView {
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
                .padding(.top, basePadding * 15)
        }
    }
    
    @ViewBuilder
    private func cocktailText() -> some View {
        if let cocktail = viewModel.cocktail {
            Text(cocktail.name)
                .font(.title)
                .padding(.bottom, -(basePadding * 4))
            Text(cocktail.glass)
                .font(.callout)
                .textCase(.uppercase)
                .opacity(0.6)
            Text(cocktail.instructions)
                .padding(.top, basePadding * 2)
            VStack {
                ForEach(cocktail.ingredients, id: \.self) { ingredient in
                    HStack {
                        Text(ingredient.name)
                            .padding(basePadding)
                        Spacer()
                        Text(ingredient.measure ?? "")
                            .padding(basePadding)
                    }
                    Divider()
                }
                .frame(width: UIScreen.main.bounds.size.width * 0.7)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, basePadding * 10)
        } else {
            Text("This drink seems to be missing. Sorry!")
                .font(.title2)
                .padding(.top, basePadding * 10)
            Text(viewModel.errorMessage ?? "")
            Button("Try again") {
                Task {
                    await viewModel.getCocktail()
                }
            }
            .buttonStyle(.bordered)
            .foregroundColor(.cocktailGreen)
        }
    }
}

// MARK: - Local constants

extension CocktailDetailsView {
    private var basePadding: CGFloat {
        4
    }
}
