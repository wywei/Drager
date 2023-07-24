//
//  ViewController.swift
//  Drager
//
//  Created by andy on 2023/7/8.
//  外界继承即可使用

import UIKit
fileprivate let targetY: CGFloat = 100
fileprivate let targetL: CGFloat = -300
fileprivate let targetR: CGFloat = 300
fileprivate let screenW: CGFloat = UIScreen.main.bounds.width
fileprivate let screenH: CGFloat = UIScreen.main.bounds.height

class ViewController: UIViewController {
    
    public lazy private(set)  var leftView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.blue
        v.frame = self.view.bounds
        return v
    }()
    
    public lazy private(set) var rightView: UIView = {
        let v = UIView()
        v.frame = self.view.bounds
        v.backgroundColor = UIColor.orange
        return v
    }()
    
    public lazy private(set) var mainView: UIView = {
        let v = UIView()
        v.frame = self.view.bounds
        v.backgroundColor = UIColor.purple
        return v
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        addGestureRecognizer()
    }
    
    @objc private func tap() {
        UIView.animate(withDuration: 0.25) {
            self.mainView.frame = self.view.bounds
        }
    }
    
    @objc private func pan(pan: UIPanGestureRecognizer) {
        
        let tranP = pan.translation(in: mainView)
        mainView.frame = frameWithOffsetX(offset: tranP.x)
        
        if mainView.frame.origin.x > 0 {//右滑
            rightView.isHidden = true
        } else {
            rightView.isHidden = false
        }
        
        var target: CGFloat = 0
        if pan.state == .ended {
            if mainView.frame.origin.x > screenW * 0.5 {
                target = targetR
            } else if CGRectGetMaxX(mainView.frame) < screenW * 0.5 {
                target = targetL
            }
            let detal = target - mainView.frame.origin.x
            UIView.animate(withDuration: 0.25) {
                self.mainView.frame = self.frameWithOffsetX(offset: detal)
            }
        }
  
        pan.setTranslation(CGPoint.zero, in: mainView)
    }
    
    private func frameWithOffsetX(offset: CGFloat) -> CGRect {
        var frame = mainView.frame
        frame.origin.x += offset
        let y = abs(frame.origin.x * targetY/screenW)
        frame.origin.y = y
        frame.size.height = screenH - 2*y
        return frame
    }

}

extension ViewController {
    private func setupUI() {
        view.addSubview(leftView)
        view.addSubview(rightView)
        view.addSubview(mainView)
    }
    
    private func addGestureRecognizer() {
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(pan))
        mainView.addGestureRecognizer(pan)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tap))
        view.addGestureRecognizer(tap)
    }
}
