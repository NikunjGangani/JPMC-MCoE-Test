//
//  LoadingViewController.swift
//  JPMC MCoE Test
//
//  Created by Nikunj Gangani on 18/04/2023.
//

import Foundation
import UIKit

fileprivate class LoadingViewController: UIViewController {
    var loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .white
        indicator.startAnimating()
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
        return indicator
    }()
    
    var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.8
        blurEffectView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        return blurEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        blurEffectView.frame = self.view.bounds
        view.insertSubview(blurEffectView, at: 0)
        loadingActivityIndicator.center = CGPoint(
            x: view.bounds.midX,
            y: view.bounds.midY
        )
        view.addSubview(loadingActivityIndicator)
    }
}

struct ProgressDialog {
    fileprivate static var alert = LoadingViewController()
}

class LoadingView {
    static func show() {
        DispatchQueue.main.async {
            let loadingView = ProgressDialog.alert
            let keyWindow = UIApplication.shared.connectedScenes
                    .compactMap { $0 as? UIWindowScene }
                    .flatMap { $0.windows }
                    .first(where: { $0.isKeyWindow })
            let view: UIView = (keyWindow?.subviews.last)!
            view.addSubview(loadingView.view)
        }
    }
    
    static func hide() {
        DispatchQueue.main.async {
            ProgressDialog.alert.view.removeFromSuperview()
        }
    }
}
