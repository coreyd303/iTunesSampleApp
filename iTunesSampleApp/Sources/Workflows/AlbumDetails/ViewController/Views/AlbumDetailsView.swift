//
//  AlbumDetailsView.swift
//  iTunesSampleApp
//
//  Created by Corey Davis on 7/15/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

class AlbumDetailsView: UIView {

    // MARK: - Properties

    var didFinish: (() -> ())?
    var didRequestAlbum: (() -> ())?

    lazy var container: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .white

        return container
    }()

    lazy var coverImage: CachedImageView = {
        let imageView = CachedImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 10.0
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowOpacity = 1.0

        return imageView
    }()

    lazy var contentStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .center
        stack.spacing = 10

        return stack
    }()

    lazy var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        stack.spacing = 10

        return stack
    }()

    lazy var albumTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 2

        return label
    }()

    lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.italicSystemFont(ofSize: 15)
        label.textColor = .darkGray

        return label
    }()

    lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray

        return label
    }()

    lazy var releaseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray

        return label
    }()

    lazy var copyrightLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        label.numberOfLines = 2

        return label
    }()

    lazy var itunesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.titleLabel?.textColor = .white
        button.setTitle("View on iTunes", for: .normal)
        button.addTarget(self, action: #selector(didTapItunesButton(_:)), for: .touchUpInside)

        return button
    }()

    // MARK: - Public

    /// configure the view using the provided album
    /// - Parameter album: an Album object containing information for the view
    func configure(with album: Album?) {
        guard let album = album else {
            didFinish?()
            return
        }

        applyDesign()

        if let url = URL(string: album.artworkUrl100) {
            coverImage.setImage(url)
        }

        albumTitleLabel.text = album.name
        artistLabel.text = album.artistName
        genreLabel.text = album.genres.first?.name
        releaseLabel.text = album.releaseDate
        copyrightLabel.text = album.copyright
    }
}

extension AlbumDetailsView {

    // MARK: - Actions

    @objc func didTapItunesButton(_ sender: UIButton) {
        didRequestAlbum?()
    }
}

extension AlbumDetailsView {

    // MARK: - Design

    private func applyDesign() {
        addContainer()
        addContentStack()
        addCoverImage()
        addAlbumTitleLabel()
        addArtistLabel()
        addHorizontalStack()
        addGenreLabel()
        addReleaseLabel()
        addCopyrightLabel()
        addButton()
    }

    private func addContainer() {
        addSubview(container)
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    private func addCoverImage() {
        contentStack.addArrangedSubview(coverImage)
        NSLayoutConstraint.activate([
            coverImage.heightAnchor.constraint(equalToConstant: 300),
            coverImage.widthAnchor.constraint(equalToConstant: 300)
        ])
    }

    private func addContentStack() {
        container.addSubview(contentStack)
        NSLayoutConstraint.activate([
            contentStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 25),
            contentStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -25),
            contentStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 50)
        ])
    }

    private func addAlbumTitleLabel() {
        contentStack.addArrangedSubview(albumTitleLabel)
        NSLayoutConstraint.activate([
            albumTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
        ])
    }

    private func addArtistLabel() {
        contentStack.addArrangedSubview(artistLabel)
        NSLayoutConstraint.activate([
            artistLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }

    private func addHorizontalStack() {
        contentStack.addArrangedSubview(horizontalStack)
        NSLayoutConstraint.activate([
            horizontalStack.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    private func addGenreLabel() {
        horizontalStack.addArrangedSubview(genreLabel)
        NSLayoutConstraint.activate([
            genreLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    private func addReleaseLabel() {
        horizontalStack.addArrangedSubview(releaseLabel)
        NSLayoutConstraint.activate([
            releaseLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }

    private func addCopyrightLabel() {
        contentStack.addArrangedSubview(copyrightLabel)
        NSLayoutConstraint.activate([
            copyrightLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 15)
        ])
    }

    private func addButton() {
        container.addSubview(itunesButton)
        NSLayoutConstraint.activate([
            itunesButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20),
            itunesButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -20),
            itunesButton.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            itunesButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
