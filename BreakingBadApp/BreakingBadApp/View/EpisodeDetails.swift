//
//  EpisodeDetails.swift
//  BreakingBadApp
//
//  Created by Furkan Sarı on 26.11.2022.
//

import UIKit

protocol CloseDelegate {
    func closeButton()
}

class EpisodeDetails: UIView {
    
    @IBOutlet weak var characterListLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var delegate : CloseDelegate?
    var characterArray = [String]()
    var selectedEpisode = ""
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func xibSetup(frame : CGRect){
        let view = loadXib()
        view.frame = frame
        addSubview(view)
        tableView.delegate = self
        tableView.dataSource = self
        characterListLabel.text = "\(selectedEpisode)Characters List"
    }
    
    func loadXib() -> UIView{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "EpisodeDetails", bundle: bundle)
        let view = nib.instantiate(withOwner: self,options: nil).first as? UIView
        return view!
        
    }

    @IBAction func closeButton(_ sender: Any) {
        self.delegate?.closeButton()
        removeFromSuperview()
    }
}

extension EpisodeDetails : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.textColor = .white
        cell.backgroundColor = randomColor()
        cell.textLabel?.text = characterArray[indexPath.row]
        
        return cell
    }
    
    func randomColor()->UIColor {
        let red = CGFloat(drand48())
        let blue = CGFloat(drand48())
        let green = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    
}
