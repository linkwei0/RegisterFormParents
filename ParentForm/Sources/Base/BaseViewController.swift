//
//  BaseViewController.swift
//  ParentForm
//
//  Created by Артём Бацанов on 24.10.2022.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .white
    }
}
