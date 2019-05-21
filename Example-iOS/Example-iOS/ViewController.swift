import UIKit

final class ViewController: UIViewController {
    let svgView = SVGView(named: "loading-text", animationOwner: .css, style: .cssFile(name: "loading-text"))
//    let svgView = SVGView(named: "image", animationOwner: .svg, style: .default)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(svgView)
        svgView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            svgView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            svgView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            svgView.widthAnchor.constraint(equalToConstant: 400),
            svgView.heightAnchor.constraint(equalToConstant: 400),
            ])
        svgView.load()

        view.backgroundColor = .green
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
    }

    @objc private func viewTapped() {
        svgView.isAnimate { [weak self] (value) in
            guard let value = value else { return }
            value ? self?.svgView.stopAnimation() : self?.svgView.startAnimation()
        }

        svgView.isAnimateCSS { (value) in
            print("cssAnimate:", value)
        }
    }
}
