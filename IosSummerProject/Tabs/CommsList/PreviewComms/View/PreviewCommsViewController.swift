//
//  PreviewCommsViewController.swift
//  IosSummerProject
//
//  Created by Bradley Burgess on 03/08/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit

class PreviewCommsViewController: UIViewController, Storyboarded {
    var previewCommsPresenter: PreviewCommsPresenterProtocol!
    var comm: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previewCommsPresenter.loadComm()
    }
}

extension PreviewCommsViewController: PreviewCommsPresenterView {
    func setCommsData(with article: Article) {
        comm = article
        print(comm, "preview")
    }
}
