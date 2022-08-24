//
//  CocktailDetailsViewModel.swift
//  Cocktails
//
//  Created by Johan Forsell on 2022-07-10.
//

import SwiftUI

@MainActor
class CocktailDetailsViewModel: ObservableObject {
    private let cocktailId: String
    private let service: CocktailsServiceable
    private let imageLoader: ImageLoader
    @Published private(set) var cocktail: DetailedCocktail?
    @Published private(set) var errorMessage: String?
    @Published private(set) var cocktailImage: Image?
    
    init(cocktailId: String, service: CocktailsServiceable = CocktailsService(), imageLoader: ImageLoader) {
        self.cocktailId = cocktailId
        self.service = service
        self.imageLoader = imageLoader
    }
    
    func getCocktail() async {
        do {
            cocktail = try await service.getDetailedCocktail(withID: cocktailId)
            try await getImageWithUrl(cocktail?.imageUrl)
        } catch let error as RequestError {
            errorMessage = error.customMessage
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    private func getImageWithUrl(_ urlString: String?) async throws {
        let url = URL(string: urlString!)!
        let uIimage = try await imageLoader.fetch(url)
        cocktailImage = Image(uiImage: uIimage)
    }
}
