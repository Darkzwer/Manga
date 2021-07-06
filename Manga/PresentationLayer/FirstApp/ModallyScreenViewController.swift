//
//  ModallyScreenViewController.swift
//  Manga
//
//  Created by Igor on 22/05/2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import UIKit

class ModallyScreenViewController: UIViewController, UIScrollViewDelegate {
    var manga: String?
    var url: String?
    @IBOutlet private weak var modallyImageView: UIImageView!
    @IBOutlet private weak var scrollViewZoom: UIScrollView!
    @IBOutlet weak var dismissButton: UIButton!
    private var imageService = ImageService()
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        self.scrollViewZoom.minimumZoomScale = 1.0
        self.scrollViewZoom.maximumZoomScale = 8.0
        dismissButton.layer.cornerRadius = 18
    }
    
    func setImage() {
        if let urlString = manga {
            imageService.downloadImage(urlString: urlString) { [weak self] (result) in
                switch result {
                case .success(let image):
                    self?.modallyImageView.image = image
                    //print(self?.manga)
                case .failure(let error):
                    print("error:", error)
                }
            }
        }
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return modallyImageView
    }
    @IBAction private func dismiss(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction private func shareAction(_ sender: Any) {
        let shareController = UIActivityViewController(activityItems: [url as Any], applicationActivities: nil)
        shareController.completionWithItemsHandler = { _, bool, _, _ in }
        present(shareController, animated: true, completion: nil)
    }
}
