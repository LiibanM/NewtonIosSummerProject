//
//  PreviewCommsViewController.swift
//  IosSummerProject
//
//  Created by Bradley Burgess on 03/08/2020.
//  Copyright © 2020 Liiban Mukhtar. All rights reserved.
//

import UIKit
import Kingfisher

class PreviewCommsViewController: UIViewController, Storyboarded {
    var previewCommsPresenter: PreviewCommsPresenterProtocol!
    var comm: Article!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoryView: LabelButton!
    @IBOutlet weak var descriptionView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        previewCommsPresenter.loadComm()
        guard let url = URL(string: comm.image) else {
            print("bad url")
            return
        }
        self.imageView.kf.setImage(with: url)
        self.categoryView.setTitle(comm.category.categoryName, for: .normal)
        self.descriptionView.text = comm.content
    }
}

extension PreviewCommsViewController: PreviewCommsPresenterView {
    func setCommsData(with article: Article) {
        comm = article
        print(comm, "preview")
    }
}
