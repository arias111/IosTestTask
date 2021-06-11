//
//  DetailViewController.swift
//  TestProject
//
//  Created by galiev nail on 10.06.2021.
//

import UIKit

class DetailViewController: UIViewController {

    private let service: ApiService = ApiServiceImpl()
    var country: Country?
    var images = [UIImage]()
    var urls = [URL]()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        let nib = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
        imageCollectionView.register(nib, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
        imageCollectionView.isPagingEnabled = true
        imageCollectionView.showsHorizontalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        let nib1 = UINib(nibName: "CountryTableViewCell", bundle: nil)
        tableView.register(nib1, forCellReuseIdentifier: CountryTableViewCell.identifier)
        let nib2 = UINib(nibName: "FooterTableViewCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: FooterTableViewCell.identifier)
        pageControl.hidesForSinglePage = true        
        pageControl.currentPage = 0
        pageControl.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func obtainTableCell(cell: CountryTableViewCell, indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            cell.nameLabel.text = "Столица"
            cell.iconImage.image = #imageLiteral(resourceName: "star")
            guard let capital = country?.capital
            else { return }
            cell.infoLabel.text = capital
                
        case 1:
            cell.nameLabel.text = "Население"
            guard let population = country?.population
            else { return }
            cell.infoLabel.text = String(population)
            cell.iconImage.image = #imageLiteral(resourceName: "smile")
                
        case 2:
            cell.nameLabel.text = "Континент"
            guard let continent = country?.continent
            else { return }
            cell.infoLabel.text = continent
            cell.iconImage.image = #imageLiteral(resourceName: "global")
                
        default:
            break
        }
    }
    
    func isImagesPresent() -> Int {
        if country?.countryInfo?.images.count != 0 {
            for i in (country?.countryInfo?.images)! {
                urls.append(URL(string: i)!)
            }
            pageControl.numberOfPages = (country?.countryInfo?.images.count)!
            return (country?.countryInfo?.images.count)!
        } else {
            urls.append(URL(string: (country?.countryInfo?.flag)!)!)
            pageControl.numberOfPages = 1
            return 1
        }
    }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        isImagesPresent()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { fatalError("coudnt deque cell") }
        for url in urls {
            DispatchQueue.main.async {
                cell.imageCell.downloaded(from: url, contentMode: .scaleAspectFill)
            }
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = scrollView.contentOffset.x / view.frame.width
        pageControl.currentPage = Int(scrollPos)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as?
                CountryTableViewCell else { fatalError("Could not dequeue cell") }
            obtainTableCell(cell: cell, indexPath: indexPath)
            Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { timer in
                cell.removeSectionSeparators()
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FooterTableViewCell.identifier, for: indexPath) as?
                    FooterTableViewCell else { fatalError("Could not dequeue cell") }
            cell.aboutLabel.text = "О стране"
            cell.descriptionLabel.text = country?.description
            // Необходим для удаления ненужных сепараторов
            Timer.scheduledTimer(withTimeInterval: 0.15, repeats: false) { timer in
                cell.removeSectionSeparators()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return country?.name
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.clear
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        header.textLabel?.frame = header.frame
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row < 3 {
             return CGFloat(80)
        } else {
            let size = CGFloat(tableView.estimatedRowHeight)
            return size
        }
    }
    
}
