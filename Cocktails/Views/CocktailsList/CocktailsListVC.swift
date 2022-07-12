//
//  CocktailsListVC.swift
//  Cocktails
//
//  Created by Johan Forsell on 2022-07-07.
//

import UIKit
import SwiftUI

final class CocktailsListVC: UITableViewController {
    private let service: CocktailsServiceable
    private let imageCache: ImageCache
    var cocktails = [Cocktail]()
    var errorMessage: String? {
        didSet {
            if let errorMessage = errorMessage {
                let ac = UIAlertController(title: "Something went wrong!", message: errorMessage, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Try again", style: .default, handler: { [weak self] _ in
                    self?.loadCocktails()
                }))
                ac.addAction(UIAlertAction(title: "OK", style: .cancel))
                present(ac, animated: true)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Cocktails"

        tableView.register(CocktailCell.self, forCellReuseIdentifier: CocktailCell.identifier)
        tableView.estimatedRowHeight = 200
        tableView.showsVerticalScrollIndicator = false
        
        loadCocktails()
    }
    
    init(service: CocktailsServiceable, imageCache: ImageCache = ImageCache()) {
        self.service = service
        self.imageCache = imageCache
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Completion block used for testing asynchronous load
    func loadCocktails(completion: (() -> Void)? = nil) {
        Task {
            do {
                cocktails = try await service.getCocktails()
                tableView.reloadData()
                completion?()
            } catch let error as RequestError {
                errorMessage = error.customMessage
            } catch {
                errorMessage = error.localizedDescription
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
        
        cell.imageCache = imageCache
        Task {
            do {
                try await cell.getImageWithUrl(cocktail.imageUrl)
            } catch {
                errorMessage = error.localizedDescription
            }
        }
        
        cell.name.text = cocktail.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = CocktailDetailsViewModel(cocktailId: cocktails[indexPath.item].id, imageCache: imageCache)
        let vc = UIHostingController(rootView: CocktailDetailsView(viewModel: viewModel))
        navigationController?.navigationBar.isHidden = false
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let imageHeader = UIImageView()
        let cocktailImage = UIImage(named: "cocktailwithtext")!
        imageHeader.image = cocktailImage
        imageHeader.contentMode = .scaleAspectFit
        return imageHeader
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
}
