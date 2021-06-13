//
//  ViewController.swift
//  TestProject
//
//  Created by galiev nail on 09.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let dataManager = DataBaseManager()
    
    let url = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/pa.json"
    private let service: ApiService = ApiServiceImpl()
    private var countries: [Country] = []
    private var nextStringUrl: String?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workWithTableView()
        getData()
        dataManager.saveDataToCoreData(countries: countries, context: dataManager.viewContext)
        // Белый цвет стоял в дизайне, но так как есть баг что нет картинок сделал другого цвета
        // navigationController?.navigationBar.tintColor = .white
        // зеленый самый нетральный ничего не перекрывает
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
    }
    
    private func workWithTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "CountriesTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CountriesTableViewCell.identifier)
        tableView.estimatedRowHeight = 100
        tableView.refreshControl = myRefreshControl
    }
    
    let myRefreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refresh
    }()
    
    @objc private func refresh(sender: UIRefreshControl) {
        tableView.reloadData()
        sender.endRefreshing()
    }
    
    private func getData() {
        service.loadCountry(url: url) { [weak self] result in
            switch result {
            case .success(let countryModel):
                self?.countries = countryModel.countries
                self?.nextStringUrl = countryModel.next
                self?.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func obtainTableCell(cell: CountriesTableViewCell, indexPath: IndexPath) {
        let country = countries[indexPath.row]
        
        guard let name = country.name
        else { return }
        cell.countryNameLabel.text = name
        
        guard let capital = country.capital
        else { return }
        cell.countryCapitalLabel.text = capital
        
        guard let desicription = country.descriptionSmall
        else { return }
        cell.descriptionLabel.text = desicription
        guard let image = country.image
        else { return }
        
        if (country.countryInfo?.flag!.isValidURL)! {
            guard let imageUrl = URL(string: country.countryInfo?.flag ?? image) else { return }
            cell.countryImage.downloaded(from: imageUrl)
        }
    }
    
    private func createSpiner() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        return footerView
    }
}

// MARK: - extension

extension ViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountriesTableViewCell.identifier, for: indexPath) as? CountriesTableViewCell
        else { fatalError("Could not dequeue cell") }
        obtainTableCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        navigationController?.pushViewController(vc!, animated: true)
        let country = countries[indexPath.row]
        vc?.country = country
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position > (tableView.contentSize.height - 1 - scrollView.frame.size.height) {
            self.tableView.tableFooterView = createSpiner()
            service.loadCountry(url: nextStringUrl ?? "") { [weak self] result in
                DispatchQueue.main.async {
                    self?.tableView.tableFooterView = nil
                }
                switch result {
                case .success(let countryModel):
                    if self?.nextStringUrl != "" {
                        self?.countries.append(contentsOf: countryModel.countries)
                        self?.tableView.reloadData()
                        self?.nextStringUrl = countryModel.next
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
