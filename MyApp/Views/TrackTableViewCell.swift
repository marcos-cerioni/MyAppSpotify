//
//  TrackTableViewCell.swift
//  MyApp
//
//  Created by Marcos Cerioni on 04/11/2021.
//

import UIKit

class TrackTableViewCell: UITableViewCell {

    var play = Bool()
    var track:Track?
    var parent:ButtonOnCellDelegate?
    
    func configureCelda(_ cancion: Track) {
        title.text = cancion.title
        artist.text = cancion.artist
    }
    
    var icon: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "nota")
        imgView.backgroundColor = .white
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    var title: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = .white
        titleLabel.autoresizingMask = .flexibleWidth
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    var artist: UILabel = {
        let artistLabel = UILabel()
        artistLabel.font = UIFont.systemFont(ofSize: 15)
        artistLabel.textColor = .gray
        artistLabel.autoresizingMask = .flexibleWidth
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        return artistLabel
    }()
    
    var playButton: HighlightButton = {
        let pButton = HighlightButton()
        pButton.icon = UIImage(named: "play")
        pButton.secondIcon = UIImage(named: "pause")
        pButton.perfomTwoStateSelection()
        pButton.addTarget(self, action: #selector(callButton), for: .touchUpInside)
        pButton.backgroundColor = .white
        pButton.translatesAutoresizingMaskIntoConstraints = false

        return pButton
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)


        addSubview(icon)
        NSLayoutConstraint.activate([
            icon.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            icon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            icon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            icon.widthAnchor.constraint(equalTo: icon.heightAnchor)
        ])


        addSubview(playButton)
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            playButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            playButton.widthAnchor.constraint(equalTo: playButton.heightAnchor)
        ])
        
        addSubview(title)
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            title.heightAnchor.constraint(equalToConstant: 35),
            title.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 5),
            title.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -5)
        ])
        
        addSubview(artist)
        NSLayoutConstraint.activate([
            artist.heightAnchor.constraint(equalToConstant: 35),
            artist.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            artist.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 5),
            artist.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -5)
        ])
        contentView.isUserInteractionEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    
    @objc func callButton() {
        playButton.perfomTwoStateSelection()
        guard let parent = parent else { return }
        parent.buttonTouchedOnCell(parametro: self)
    }
}
