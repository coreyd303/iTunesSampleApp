//
//  FilterPickerViewController.swift
//  LoveverySampleApp
//
//  Created by Corey Davis on 6/16/20.
//  Copyright © 2020 Corey Davis. All rights reserved.
//

import Foundation
import UIKit

protocol FilterPickerPresentable: Presentable {
    var didFinish: (() -> ())? { get set }
    var didSelectFilter: ((String?) -> ())? { get set }
    var names: [String?] { get set }
}

class FilterPickerViewController: UIViewController, FilterPickerPresentable {

    var didFinish: (() -> ())?
    var didSelectFilter: ((String?) -> ())?
    var names: [String?] = []

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Arial", size: 25)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Select a name to filter posts by"

        return label
    }()

    private(set) lazy var picker: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.backgroundColor = .white
        picker.delegate = self
        picker.dataSource = self

        return picker
    }()

    private(set) lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 18)
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)

        return button
    }()

    private(set) lazy var selectButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Select", for: .normal)
        button.backgroundColor = UIColor.darkGray
        button.addTarget(self, action: #selector(didTapSelect), for: .touchUpInside)

        return button
    }()

    // MARK: - Lifecycle

    override func viewDidLayoutSubviews() {
        applyDesign()
    }

    // MARK: - Private

    @objc private func didTapClose() {
        didFinish?()
    }

    @objc private func didTapSelect() {
        didSelectFilter?(names[picker.selectedRow(inComponent: 0)])
    }
}

extension FilterPickerViewController {

    // MARK: - Design

    private func applyDesign() {
        view.backgroundColor = .white
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.widthAnchor.constraint(equalToConstant: 100),
            closeButton.heightAnchor.constraint(equalToConstant: 60),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])

        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            titleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])

        view.addSubview(selectButton)
        NSLayoutConstraint.activate([
            selectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            selectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            selectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            selectButton.heightAnchor.constraint(equalToConstant: 35)
        ])

        view.addSubview(picker)
        NSLayoutConstraint.activate([
            picker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            picker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            picker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            picker.bottomAnchor.constraint(equalTo: selectButton.topAnchor)
        ])
    }
}

extension FilterPickerViewController: UIPickerViewDelegate {

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return names[row]?.capitalized
    }

}

extension FilterPickerViewController: UIPickerViewDataSource {

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return names.count
    }
}
