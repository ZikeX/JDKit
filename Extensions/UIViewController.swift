
import UIKit
extension UIViewController {
    func configNavBarItem(closure:((UINavigationItem) -> ())?) {
        func clearNavigationItem() {
            let backItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
            backItem.rx.tap.subscribe(onNext:{ [unowned self](_) in
                self.popVC()
            }).addDisposableTo(disposeBag)
            self.navigationItem.backBarButtonItem = backItem
                
            self.navigationItem.titleView?.removeFromSuperview()
            self.navigationItem.titleView = nil
            self.navigationItem.title = nil
            self.navigationItem.leftBarButtonItems = [UIBarButtonItem]()
            self.navigationItem.rightBarButtonItems = [UIBarButtonItem]()
        }
        clearNavigationItem()
        closure?(self.navigationItem)
    }
}

extension UIViewController {
    // MARK: - VC Flow
    func pushVC(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    func popVC(animated:Bool = true) {
        _ = navigationController?.popViewController(animated: animated)
    }
    func presentVC(_ vc: UIViewController,animated:Bool = true) {
        present(vc, animated: animated, completion: nil)
    }
    func dismissVC(animated:Bool = true,completion: (() -> Void)? = nil) {
        dismiss(animated: animated, completion: completion)
    }
    
    func addAsChildViewController(_ vc: UIViewController, toView: UIView) {
        toView.addSubview(vc.view)
        self.addChildViewController(vc)
        vc.didMove(toParentViewController: self)
    }
}
extension UIViewController {
    var navBar:UINavigationBar? {
        return self.navigationController?.navigationBar
    }
    var navC:UINavigationController? {
        return self.navigationController
    }
}
extension UIViewController {
    func parentVC<T:UIViewController>(_ vcType:T.Type) -> T? {
        if let viewCon = self.parent as? T {
            return viewCon
        }else {
            return nil
        }
    }
    func findParentVC<T:UIViewController>(_ vcType:T.Type) -> T? {
        if let viewCon = self.parentVC(T.self) {
            return viewCon
        }else {
            return self.parentVC(UIViewController.self)?.parentVC(T.self)
        }
    }
    func previousVC<T:UIViewController>(_ vcType:T.Type) -> T? {
        guard let navC = self.navigationController else {
            return nil
        }
        if let index = navC.viewControllers.index(of: self),index > 1 {
            if let viewCon = navC.viewControllers[index-1] as? T {
                return viewCon
            }else {
                return nil
            }
        }else {
            return nil
        }
    }
    func findPreviousVC<T:UIViewController>(_ vcType:T.Type) -> T? {
        if let viewCon = self.previousVC(T.self) {
            return viewCon
        }else {
            return self.previousVC(UIViewController.self)?.previousVC(T.self)
        }
    }
}
extension UIViewController {
    /// ZJaDe: Adds UIImage as a ImageView in the Background
    @nonobjc func setBackgroundImage(_ image: UIImage?) {
        let imageView = ImageView(frame: view.frame)
        imageView.image = image
        view.addSubview(imageView)
        view.sendSubview(toBack: imageView)
    }
}

