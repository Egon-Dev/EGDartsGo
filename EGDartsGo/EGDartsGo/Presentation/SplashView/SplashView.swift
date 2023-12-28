//
//  SplashView.swift
//  EGDartsGo
//
//  Created by changmuk.im@phoenixdarts.com on 12/27/23.
//

import Lottie
import SwiftUI

struct SplashView: View {
    private var lottieView = {
        LottieView(fileName: "LottieDartBoard")
    }()

    var body: some View {
        ZStack {
            GeometryReader { geometry in
                let width = geometry.size.width
                let height = geometry.size.height
                let lottieSize = width * 0.6
                let lottieOffsetX = width / 2 - lottieSize / 2 + lottieSize * 0.06
                let lottieOffsetY = height / 2 - lottieSize / 2 - height * 0.05

                lottieView
                    .frame(width: lottieSize, height: lottieSize)
                    .offset(x: lottieOffsetX, y: lottieOffsetY)
            }
        }
    }
}

private struct LottieView: UIViewRepresentable {
    var fileName: String
    var animationCompletionHandler: ((Bool) -> Void)?

    func makeUIView(context: Context) -> some UIView {
        let view = UIView()
        let animationView = LottieAnimationView()
        let animation = LottieAnimation.named(fileName)
        animationView.animation = animation
        animationView.animationSpeed = 2.0
        animationView.loopMode = .loop
        animationView.contentMode = .scaleAspectFit
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

extension LottieView {
    class Coordinator: NSObject, CAAnimationDelegate {
        var parent: LottieView

        init(_ parent: LottieView) {
            self.parent = parent
        }

        private func animationDidStop(_ animation: Animation, finished: Bool) {
            parent.animationCompletionHandler?(finished)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

#Preview {
    SplashView()
}
