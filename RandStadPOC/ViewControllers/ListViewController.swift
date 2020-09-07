//
//  ViewController.swift
//  RandStadPOC
//
//  Created by Harsha VARDHAN on 02/09/2020.
//  Copyright © 2020 Harsha VARDHAN. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    var viewModel: ListViewModel!
    
    @IBOutlet var contentView:UIView!
//    var tilesArray:[UIButton] = []
    
    //MARK:- init and viewDidLoads
    class func initWithViewModel(_ viewModel:ListViewModel) -> ListViewController {
        
        let storyBoardRef = UIStoryboard.init(name: StringConstants.MAIN, bundle: nil)
        let viewController = storyBoardRef.instantiateViewController(identifier: StringConstants.ViewControllers.LIST_VC) as ListViewController
        
        viewController.viewModel = viewModel
        viewController.viewModel.listProtocol = viewController
        viewController.title = StringConstants.Tile
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightBarButton = UIBarButtonItem.init(image: UIImage.init(named: StringConstants.Assets.RELOAD), style: .plain, target: self, action: #selector(ListViewController.fetch))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        let double1:Double = 0.92
        let priority = (Int(double1*100))/10 + 1
        print(priority)
    }
    
    @objc func fetch() {
        viewModel.fetch()
    }
}

extension ListViewController: ViewModelProtocol {
    
    func showStaticAlert(_ title: String, message: String) {
        
        DispatchQueue.main.async(execute: {() -> Void in
            
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: StringConstants.OK, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    func showLoadingIndicator() {
        DispatchQueue.main.async(execute: {() -> Void in
            
            MBProgressHUD.showAdded(to: self.view, animated: true)
        })
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async(execute: {() -> Void in
            
            MBProgressHUD.hide(for: self.view, animated: true)
        })
    }
    
    func reloadUI() {
       DispatchQueue.main.async(execute: {() -> Void in
        for subview in self.contentView.subviews {
            subview.removeFromSuperview()
        }
        guard let tiles = self.viewModel.dataSource?.tiles else {
            return
        }
        var index:Int = 0
        for tile in tiles {
            let length = self.viewModel.getLength(for: tile)
            
            let tileRect = self.viewModel.getFrame(for: length, in: self.contentView.subviews)
            if tileRect != nil {
                let tileButton = UIButton.init(type: .system)
                tileButton.setTitle(tile.label, for: .normal)
                tileButton.titleLabel?.adjustsFontSizeToFitWidth = true
                tileButton.addTarget(self, action: #selector(ListViewController.click(sender:)), for: .touchUpInside)
                
                tileButton.frame = CGRect.init(x: Int(tileRect!.origin.x)+1, y: Int(tileRect!.origin.y)+1, width: length-2, height: length-2)
                tileButton.tag = index
                tileButton.layer.borderWidth = 1.0
                tileButton.layer.borderColor = UIColor.red.cgColor
                tileButton.layer.cornerRadius = 0.5
                
                self.contentView.addSubview(tileButton)
            }
            index += 1
        }
       })
    }
    
    @objc func click(sender:UIButton) {
        self.viewModel.invokeTileClick(sender.tag)
    }
    
}

