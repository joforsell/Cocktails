//
//  CocktailsListVC.swift
//  Cocktails
//
//  Created by Johan Forsell on 2022-07-07.
//

import UIKit
import SwiftUI

class CocktailsListVC: UITableViewController {
    private let service: CocktailsServiceable
    var cocktails = [Cocktail]()
    var errorMessage: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CocktailCell.self, forCellReuseIdentifier: CocktailCell.identifier)
        tableView.estimatedRowHeight = 200
        tableView.showsVerticalScrollIndicator = false
        
        loadCocktails()
    }
    
    init(service: CocktailsServiceable) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadCocktails() {
        Task {
            do {
                cocktails = try await service.getCocktails()
                tableView.reloadData()
            } catch let error as RequestError {
                errorMessage = error.customMessage
            }
        }
    }
}

// MARK: - TableView methods

extension CocktailsListVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cocktails.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.rowHeight
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CocktailCell.identifier, for: indexPath) as? CocktailCell else {
            fatalError("Unable to type cast cell")
        }
        
        let cocktail = cocktails[indexPath.item]
        
        Task {
            do {
                cell.cocktailImageView.image = try await getImageWithUrl(cocktail.imageUrl)
            } catch {
                errorMessage = error.localizedDescription
            }
        }
        
        cell.name.text = cocktail.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = CocktailDetailsViewModel(cocktailId: cocktails[indexPath.item].id)
        let vc = UIHostingController(rootView: CocktailDetailsView(viewModel: viewModel))
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Cell logic

extension CocktailsListVC {
    func getImageWithUrl(_ urlString: String, loader: ImageLoader = ImageLoader()) async throws -> UIImage {
        let url = URL(string: urlString)!
        let image = try await loader.fetch(url)
        return image
    }
}
