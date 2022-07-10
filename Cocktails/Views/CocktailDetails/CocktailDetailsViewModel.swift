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
    let loader: ImageLoader
    @Published private(set) var cocktail: DetailedCocktail?
    @Published var errorMessage: String?
    @Published private(set) var cocktailImage: Image?
    
    init(cocktailId: String, service: CocktailsServiceable = CocktailsService(), loader: ImageLoader = ImageLoader()) {
        self.cocktailId = cocktailId
        self.service = service
        self.loader = loader
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
        let uIimage = try await loader.fetch(url)
        cocktailImage = Image(uiImage: uIimage)
    }
}
