//
//  Extensions.swift
//  MyApp
//
//  Created by Marcos Cerioni on 15/12/2021.
//

import Foundation
import CoreData

extension UIViewController {
    func alertOK(title: String, message: String, action: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .default, handler: { _ in }))
        self.present(alert, animated: true, completion: nil)

    }
    
    func goToMainViewController() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TabBarViewController") as? UITabBarController
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true)
    }
    
    func savedData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.managedObjectContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Tracks")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context!.fetch(request) // fetch nos da elementos no nulos
            misTracks = [Track]()
            
            for data in result as! [NSManagedObject] {
                let title = data.value(forKey: "title") as? String
                let artist = data.value(forKey: "artist") as? String
                let song_id = data.value(forKey: "song_id") as? String
                let album = data.value(forKey: "album") as? String
                let genre = data.value(forKey: "genre") as? String
                
                let track = Track(title: title ?? "",
                                  artist: artist ?? "",
                                  album: album ?? "",
                                  song_id: song_id ?? "",
                                  genre: genre ?? "",
                                  isPlaying: false
                )
                misTracks.append(track)
            }
            
        } catch {
            print("Falle al obtener info de la BD \(error), \(error.localizedDescription)")
        }
        
//        if false {
        self.downloadTracks()
//        }
        
    }
    
    func downloadTracks() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.managedObjectContext
        
        RestServiceManager.shared.getToServer(
            responseType: [Track].self,
            method: .get,
            endpoint: "songs") { status, data in
            misTracks = [Track]()
                if let _data = data {
                    misTracks = _data
                    if let _context = context {
                        // Eliminar contenido
                        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Tracks")
                        let deleteRquest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                        do {
                            try appDelegate.persistentStoreCoordinator?.execute(deleteRquest, with: _context)
                        } catch {
                            print(error)
                        }
                        //Fin eliminar contenido
                        
                        //Agregar contenido a CoreData
                        for item in _data {
                            let tracksEntity = NSEntityDescription.insertNewObject(forEntityName: "Tracks", into: _context)
                            tracksEntity.setValue(item.artist, forKey: "artist")
                            tracksEntity.setValue(item.title, forKey: "title")
                            tracksEntity.setValue(item.song_id, forKey: "song_id")
                            tracksEntity.setValue(item.genre, forKey: "genre")
                            tracksEntity.setValue(item.album, forKey: "album")
                            tracksEntity.setValue(item.isPlaying , forKey: "isPlaying")

                            
                            
                            do {
                                try context?.save()
                            } catch {
                                print("No se guardo la info \(error), \(error.localizedDescription)" )
                            }
                        }
                    }
                }
        }
    }
}

extension UITextField {
    func shake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}

extension RegisterViewController {
    static func checkMail(mailInput: String) -> Bool {
        let patron = #"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"#
        let regex = try! NSRegularExpression(pattern: patron, options: [])
        let matches = regex.matches(in:mailInput, options:[], range: NSRange(location: 0, length: mailInput.count))
        return matches.count == 1 ? true : false
    }
    
   static func checkPass (passInput: String) -> Bool {
        let patron = #"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"#
        let regex = try! NSRegularExpression(pattern: patron, options: [])
        let matches = regex.matches(in:passInput, options:[], range: NSRange(location: 0, length: passInput.count))
        return matches.count == 1 ? true : false
    }
}
