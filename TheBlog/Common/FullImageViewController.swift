//
//  FullImageViewController.swift
//  TheBlog
//
//  Created by Marcio Garcia on 13/06/20.
//  Copyright © 2020 Oxl Tech. All rights reserved.
//

import UIKit
import DesignSystem

class FullImageViewController: UIViewController {

    // MARK: Layout properties

    private lazy var scrollView = { UIScrollView() }()
    private lazy var imageView = { UIImageView() }()

    var imageUrl: String?
    var image: UIImage?
    var imageWorker: ImageWorkLogic?

    init(imageUrl: String?, image: UIImage?, imageWorker: ImageWorkLogic?) {
        self.imageUrl = imageUrl
        self.image = image
        self.imageWorker = imageWorker
        super.init(nibName: nil, bundle: nil)
        setupViewConfiguration()
    }

    required init?(coder: NSCoder) {
        fatalError("This view should be implemented by view conding")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        if let urlString = imageUrl, let url = URL(string: urlString) {
            _ = imageWorker?.download(with: url, completion: { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let image):
                        self.imageView.image = image
                    case .failure:
                        self.imageView.image = nil
                    }
                }
            })
        } else {
            self.imageView.image = self.image
        }
    }
}

extension FullImageViewController: ViewCodingProtocol {
    func buildViewHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }

    func setupConstraints() {
        scrollView.constraint {[
            $0.topAnchor.constraint(equalTo: view.topAnchor),
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]}
        imageView.constraint {[
            $0.topAnchor.constraint(equalTo: scrollView.topAnchor),
            $0.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            $0.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            $0.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            $0.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            $0.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ]}
    }

    func configureViews() {
        view.backgroundColor = .black
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 4
        imageView.contentMode = .scaleAspectFit
    }
}

extension FullImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
}
