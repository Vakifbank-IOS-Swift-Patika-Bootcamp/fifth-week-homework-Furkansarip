//
//  EpisodesViewController.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 22.11.2022.
//

import UIKit
import MaterialActivityIndicator

final class EpisodesViewController: UIViewController {

    let indicator = MaterialActivityIndicatorView()
    @IBOutlet weak var episodesTableView: UITableView!
    var episodeArray = [EpisodesModel]()
    var characterPopUp : EpisodeDetails!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
        episodesTableView.register(UINib(nibName: "EpisodeViewCell", bundle: nil), forCellReuseIdentifier: "EpisodeCell")
        NetworkManager.shared.getAllEpisodes(series: "Breaking+Bad") { result in
            switch result {
            case.success(let episodes):
                self.episodeArray = episodes
                DispatchQueue.main.async {
                    self.episodesTableView.reloadData()
                    self.indicator.stopAnimating()
                }
                //print(self.episodeArray)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        indicatorSetup()
        indicator.startAnimating()
    }
    
    func indicatorSetup(){
        view.addSubview(indicator)
        indicator.color = .green
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
}


extension EpisodesViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.count
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionHeader = SectionType(rawValue: section)
        return sectionHeader?.header
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let type = SectionType(rawValue: section)
        switch type {
        case .season1:
            let filteredArray = episodeArray.filter({$0.season == "1"})
            return filteredArray.count
        case .season2:
            let filteredArray = episodeArray.filter({$0.season == "2"})
            return filteredArray.count
        case .season3:
            let filteredArray = episodeArray.filter({$0.season == "3"})
            return filteredArray.count
        case .season4:
            let filteredArray = episodeArray.filter({$0.season == "4"})
            return filteredArray.count
        case .season5:
            let filteredArray = episodeArray.filter({$0.season == "5"})
            return filteredArray.count
        default:
            fatalError("error")
        }
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = episodesTableView.dequeueReusableCell(withIdentifier: "EpisodeCell", for: indexPath) as? EpisodeViewCell else { return UITableViewCell()
        }
        let cellType = SectionType(rawValue: indexPath.section)
        switch cellType {
        case .season1:
            let filteredArray = episodeArray.filter({$0.season == "1"})
            cell.configure(to: filteredArray[indexPath.row])
        case .season2:
            let filteredArray = episodeArray.filter({$0.season == "2"})
            cell.configure(to: filteredArray[indexPath.row])
        case .season3:
            let filteredArray = episodeArray.filter({$0.season == "3"})
            cell.configure(to: filteredArray[indexPath.row])
        case .season4:
            let filteredArray = episodeArray.filter({$0.season == "4"})
            cell.configure(to: filteredArray[indexPath.row])
        case .season5:
            let filteredArray = episodeArray.filter({$0.season == "5"})
            cell.configure(to: filteredArray[indexPath.row])
            return cell
        case .none:
            return UITableViewCell()
        }
        return cell
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        self.characterPopUp = EpisodeDetails(frame: self.view.frame)
        self.characterPopUp.selectedEpisode = episodeArray[indexPath.row].title
        self.view.addSubview(characterPopUp)
        self.characterPopUp.delegate = self
        self.characterPopUp.characterArray = episodeArray[indexPath.row].characters
       
    }
    
}

extension EpisodesViewController : CloseDelegate {
    func closeButton() {
        print("Close Delegate triggered!")
    }
    
    
}


