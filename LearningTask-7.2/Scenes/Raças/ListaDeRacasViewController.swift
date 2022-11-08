//
//  ViewController.swift
//  LearningTask-7.2
//
//  Created by rafael.rollo on 13/05/2022.
//

import UIKit

class ListaDeRacasViewController: UICollectionViewController {
    
    var dogsAPI: DogsAPI?
    
    var racas: [Raca] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        applyTheme()
        // Do any additional setup after loading the view.
        loadRacas()
    }
    
    func loadRacas() {
        guard let dogsAPI = dogsAPI else { return }
        racas = dogsAPI.listaRacas()
    }

}

// MARK: - UICollectionViewDataSource implementations
extension ListaDeRacasViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return racas.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListaDeRacasViewCell", for: indexPath) as? ListaDeRacasViewCell else {
            fatalError("Não foi possível obter célula para a coleção")
        }
        cell.raca = racas[indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewDelegate implementations
extension ListaDeRacasViewController {

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return configureReusableHeaderView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
        default:
            fatalError("Tipo de view não é suportado: \(kind)")
        }
    }
    
    private func configureReusableHeaderView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "RacasSectionHeaderView", for: indexPath) as? RacasSectionHeaderView else {
            fatalError("Não foi possível obter a view para o header da seção")
        }
        header.title = "Raças"
        return header
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout implementations
extension ListaDeRacasViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError("É esperado que a lista de filmes em cartaz trabalhe com base em UICollectionViewFlowLayout")
        }
        
        let itemPerLine: CGFloat = 3
        let margins = flowLayout.sectionInset
        let itemsSpacing = flowLayout.minimumInteritemSpacing
        
        let utilWidth = collectionView.bounds.width // Width total (180)
                        - (margins.left + margins.right) // menos margens direita e esquerda (180 - 48 = 132)
                        - itemsSpacing * (itemPerLine - 1) // Menos espaço entre itens (132 - 24 * (3 - 1) = 84)
        let itemWidth = utilWidth / itemPerLine // Area util (84) / itens por linha (3) = 81
        
        return CGSize(width: itemWidth, height: itemWidth * 1.26)
    }
}
