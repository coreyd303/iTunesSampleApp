//
//  MusicFeedCell.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 6/15/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

class MusicFeedCell: UITableViewCell {

    // MARK: - Properties

    static let identifier: String = "musicCell"

    lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = .white
        container.translatesAutoresizingMaskIntoConstraints = false

        return container
    }()

    lazy var albumCover: CachedImageView = {
        let cover = CachedImageView()
        cover.translatesAutoresizingMaskIntoConstraints = false
        cover.layer.cornerRadius = 5.0
        cover.layer.borderColor = UIColor.darkGray.cgColor
        cover.layer.borderWidth = 2.0
        cover.clipsToBounds = true
        cover.contentMode = .scaleAspectFit

        return cover
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 2

        return label
    }()

    lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.italicSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .darkGray

        return label
    }()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        applyDesign()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public

    func configure(with album: Album?) {
        applyDesign()

        guard let album = album else { return }
        if let url = URL(string: album.artworkUrl100) {
            albumCover.setImage(url)
        }

        titleLabel.text = album.name
        artistLabel.text = album.artistName
    }
}

extension MusicFeedCell {

    // MARK: - Design

    private func applyDesign() {
        addContainerView()
        addImageView()
        addAlbumLabel()
        addArtistLabel()
    }

    private func addContainerView() {
        addSubview(container)
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func addImageView() {
        container.addSubview(albumCover)
        NSLayoutConstraint.activate([
            albumCover.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            albumCover.topAnchor.constraint(equalTo: container.topAnchor, constant: 15),
            albumCover.widthAnchor.constraint(equalToConstant: 150),
            albumCover.heightAnchor.constraint(equalToConstant: 150)
        ])
    }

    private func addAlbumLabel() {
        container.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -25),
            titleLabel.topAnchor.constraint(equalTo: albumCover.bottomAnchor, constant: 8)
        ])
    }

    private func addArtistLabel() {
        container.addSubview(artistLabel)
        NSLayoutConstraint.activate([
            artistLabel.heightAnchor.constraint(equalToConstant: 17),
            artistLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
            artistLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15),
            artistLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            artistLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10)
        ])
    }
}
