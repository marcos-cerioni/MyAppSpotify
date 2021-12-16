//
//  TracksTableViewController.swift
//  MyApp
//
//  Created by Marcos Cerioni on 03/11/2021.
//

import UIKit

class TracksTableViewController: UITableViewController, ButtonOnCellDelegate {
    
    var favorites = [Int]()
    var downloads = [Int]()
    var playing = [Int]()
    var delegate: TracksTableVCDelegate?
    var songPlaying = Bool()

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func buttonTouchedOnCell(parametro: UITableViewCell) {
        let apvc = AudioPlayerViewController()
        guard let index = tableView.indexPath(for: parametro) else { return }
        
        let song = misTracks[index.item]
        apvc.track = song
        apvc.modalPresentationStyle = .fullScreen
        self.present(apvc, animated: true)
        	
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateTable(_:)),
            name: NSNotification.Name("updateTable"),
            object: nil)

        let _ = Timer.scheduledTimer(withTimeInterval: 30.0, repeats: true) { timer in
            NotificationCenter.default.post(name: NSNotification.Name("updateTable"), object: nil)
            
            // Change icon if is playing song after dismiss audioplayer
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(self.changeIcon(_:)),
                name: NSNotification.Name(rawValue: "changeButtonIcon"),
                object: nil)
            
        }

        self.tableView.backgroundColor = .black
        // 1. Le indico al table view de que tipo van a ser las celdas que va a mostrar
        self.tableView.register(TrackTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    @objc func changeIcon(_ notification: Notification) {
        guard let mysong = notification.object as? Bool else { return }
        print(mysong)
    }

    @objc func updateTable(_ notification: Notification) {
//        misTracks.append(Track(title: "Nueva cancion", artist: "Nuevo artista", album: "Nuevo album", song_id: "0", genre: ""))
//        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return misTracks.count
    }
    
    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [weak self]_ in
            let favorite = UIAction(
                title: self?.favorites.contains(indexPath.row) == true ? "Unfavorite" : "Favorite",
                image: self?.favorites.contains(indexPath.row) == true ? UIImage(systemName: "star.slash") : UIImage(systemName: "star")
            ) { [weak self]_ in
                if self?.favorites.contains(indexPath.row) == true {
                    self?.favorites.removeAll(where: { $0 == indexPath.row} )
                    self?.alertOK(title: "Favorites", message: "Removed from Favorites", action: "OK")
                } else {
                    self?.favorites.append(indexPath.row)
                    self?.alertOK(title: "Favorites", message: "Added to Favorites", action: "OK")
                }

            }
            
            let download = UIAction(
                title: "Download",
                image: UIImage(systemName: "arrow.down.circle")
                
            ) { _ in
                if self?.downloads.contains(indexPath.row) == false {
                    DownloadManager.shared.startDownload(url: URL(string: "https://speed.hetzner.de/100MB.bin")!)
                    
                    self?.downloads.append(indexPath.row)
                    let songSelected = misTracks[indexPath.row]
                    let message = "You are downloading \n \(songSelected.title) - \(songSelected.artist ?? "")"
                    self?.alertOK(title: "Downloading...", message: message, action: "OK")
                    
                }
            }
            
            let addPlaylist = UIAction(
                title: "Add to Playlist",
                image: UIImage(systemName: "arrow.up.forward.app")
                
            ) { _ in
                let playlist = PlayListDetailController()
                self?.delegate = playlist.self
                let songSelected = misTracks[indexPath.row]
                self?.delegate?.addTrackTV(objetoTrack: songSelected)
            }
            
            let shareSong = UIAction(
                title: "Share Song",
                image: UIImage(systemName: "arrow.up.forward.app")
                
            ) { _ in
                let songSelected = misTracks[indexPath.row]
                let song = [songSelected.artist, songSelected.title]
                                let ac = UIActivityViewController(activityItems: song as [Any], applicationActivities: nil)
                                ac.popoverPresentationController?.sourceView = self?.view
                                self?.present(ac, animated: true)
            }
            
            let remove = UIAction(
                title: "Remove",
                image: UIImage(systemName: "trash"),
                attributes: .destructive
            ) { _ in
                misTracks.remove(at: indexPath.row)
                self?.tableView.reloadData()
            }
            
            let children: [UIAction]
            self?.downloads.contains(indexPath.row) == true ? (children = [favorite, remove, addPlaylist, shareSong]) : (children = [favorite, download, addPlaylist, shareSong, remove])

            return UIMenu(title: "", options: UIMenu.Options.displayInline, children: children)
        }
        return config
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Le pedimos al table view una celda y hacemos el CAST al tipo de clase que se registro en el paso 1
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! TrackTableViewCell
       
        let tracks = misTracks[indexPath.row]
        cell.configureCelda(tracks)
        cell.parent = self
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        cell.playButton.isPlaying = songPlaying
        cell.playButton.perfomTwoStateSelection()
        return cell
    }
}


