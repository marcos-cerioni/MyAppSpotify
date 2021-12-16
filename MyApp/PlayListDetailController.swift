//
//  PlayListDetailController.swift
//  MyApp
//
//  Created by Marcos Cerioni on 29/11/2021.
//

import UIKit

class PlayListDetailController: UIViewController, TracksPickerDelegate, UITableViewDataSource, UITableViewDelegate, TracksTableVCDelegate {

    let textField = UITextField()
    let b1 = UIButton(type: .custom)
    let tv = UITableView()

    func addTrack(objetoTrack track: Track) {
        tracks.insert(track)
        tracksArray = Array(tracks)
        tv.reloadData()
    }
    
    func addTrackTV(objetoTrack track: Track) {
        tracks.insert(track)
        tracksArray = Array(tracks)
        tv.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tv.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        self.view.addSubview(textField)
        textField.placeholder = "Playlist..."
        textField.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.5)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo:self.view.topAnchor, constant: 40).isActive = true
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.view.addSubview(b1)
        b1.setImage(UIImage(systemName: "plus.rectangle.fill.on.rectangle.fill"), for: .normal)
        b1.translatesAutoresizingMaskIntoConstraints=false
        b1.topAnchor.constraint(equalTo:self.view.topAnchor, constant: 40).isActive = true
        b1.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 10).isActive = true
        b1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        b1.heightAnchor.constraint(equalToConstant: 50).isActive = true
        b1.addTarget(self, action:#selector(showView), for: .touchUpInside)
        
        self.view.addSubview(tv)
        tv.translatesAutoresizingMaskIntoConstraints=false
        tv.topAnchor.constraint(equalTo:textField.bottomAnchor, constant: 20).isActive = true
        tv.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        tv.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        tv.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant: -20).isActive = true
        tv.backgroundColor = .clear
        tv.separatorColor = UIColor.systemBlue.withAlphaComponent(0.5)
        tv.separatorStyle = .singleLine
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "track")
        tv.dataSource = self
        tv.delegate = self
    }
    
    @objc func showView() {
        let trv = TracksPickerView (frame: CGRect(x: 0, y: self.view.frame.height/2, width: self.view.frame.width, height: self.view.frame.height/2))
        trv.delegate = self
        self.view.addSubview(trv)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // MARK: - TableView Datasource & Delegate
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         tracksArray.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "track", for: indexPath)
         let track = tracksArray[indexPath.row]
         cell.textLabel?.text = track.title
         return cell
     }
}
