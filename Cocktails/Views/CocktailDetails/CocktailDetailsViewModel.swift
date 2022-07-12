//
//  CocktailDetailsViewModel.swift
//  Cocktails
//
//  Created by Johan Forsell on 2022-07-10.
//

import SwiftUI

@MainActor
class CocktailDetailsViewModel: ObservableObject {
    let cocktailId: String
    let service: CocktailsServiceable
    let imageCache: ImageCache
    @Published private(set) var cocktail: DetailedCocktail?
    @Published var errorMessage: String?
    @Published private(set) var cocktailImage: Image?
    
    init(cocktailId: String, service: CocktailsServiceable = CocktailsService(), imageCache: ImageCache) {
        self.cocktailId = cocktailId
        self.service = service
        self.imageCache = imageCache
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
        let uIimage = try await imageCache.load(url: url as NSURL)
        cocktailImage = Image(uiImage: uIimage)
    }
}
