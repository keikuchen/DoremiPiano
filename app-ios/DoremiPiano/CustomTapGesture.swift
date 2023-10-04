import SwiftUI
import UIKit

class CustomTapGesture: UITapGestureRecognizer {
    var target: TapReactiveCoordinator? = nil
    var touchesBegan: (()->Void)?
    var touchesEnded: (()->Void)?

    init(target: Any?, action: Selector?, touchesBegan: (()->Void)? = nil, touchesEnded: (()->Void)? = nil) {
        super.init(target: target, action: action)
        if target is TapReactiveCoordinator {
            self.target = (target as! TapReactiveCoordinator)
        }
        self.touchesBegan = touchesBegan
        self.touchesEnded = touchesEnded
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        self.touchesBegan?()
        self.target?.touchesBegan()
    }
    
    // Use "reset" instead of "touchesEnded" to call it after "touchesBegan" abusolutely.
    override func reset() {
        super.reset()
        self.touchesEnded?()
        self.target?.touchesEnded()
    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
//        super.touchesEnded(touches, with: event)
//        self.touchesEnded?()
//        self.target?.touchesEnded()
//    }
}

struct CustomTapGestureHandler: UIViewRepresentable {
    var touchesBegan: (()->Void)?
    var touchesEnded: (()->Void)?
    @State var color = UIColor.clear
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.alpha = 0.7
        view.addGestureRecognizer(context.coordinator.makeGesture(touchesBegan: touchesBegan, touchesEnded: touchesEnded))
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        uiView.backgroundColor = color
    }
    
    class Coordinator: TapReactiveCoordinator {
        var parent: CustomTapGestureHandler
        
        init(_ pageViewController: CustomTapGestureHandler) {
            self.parent = pageViewController
        }
        
        @objc func action(_ sender: Any?) {
        }

        func makeGesture(touchesBegan: (()->Void)?, touchesEnded: (()->Void)?) -> CustomTapGesture {
            CustomTapGesture(
                target: self,
                action: #selector(self.action(_:)),
                touchesBegan: touchesBegan,
                touchesEnded: touchesEnded
            )
        }
        
        func touchesBegan() {
            parent.color = UIColor.gray
        }
        
        func touchesEnded() {
            parent.color = UIColor.clear
        }
    }
}

protocol TapReactiveCoordinator {
    func touchesBegan()
    func touchesEnded()
}
