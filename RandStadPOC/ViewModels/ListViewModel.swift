//
//  ListViewModel.swift
//  RandStadPOC
//
//  Created by Harsha VARDHAN on 05/09/2020.
//  Copyright © 2020 Harsha VARDHAN. All rights reserved.
//

import UIKit

class ListViewModel {
    
    var listProtocol:ViewModelProtocol?
    var dataSource:TileList?
    
    var router:RouterProtocol = Router.sharedInstance
    
    init() {
        dataSource = TileList.init({ (tiles, serviceEvent) in
            
            self.listProtocol?.reloadUI()
            self.listProtocol?.hideLoadingIndicator()
        }, errorObserver: { (error, serviceEvent) in
            
            self.listProtocol?.hideLoadingIndicator()
            self.listProtocol?.showStaticAlert(StringConstants.ERROR, message: error.localizedDescription)
        })
    }
    
    // MARK:- data source functions
    func fetch() {
        
        listProtocol?.showLoadingIndicator()
        dataSource?.fetch()
    }
    
    // MARK:- routing functions
    func invokeTileClick(_ index:Int)  {
        let tile = dataSource?.tiles![index]
        tile!.messageObserver = { (message, error, serviceEvent) in
            
            if message != nil {
                self.listProtocol?.showStaticAlert(StringConstants.Tile+" "+tile!.label+" "+StringConstants.CLICKED, message: message!)
            } else {
                self.listProtocol?.showStaticAlert(tile!.label+" "+StringConstants.CLICKED, message: error!.localizedDescription)
            }
        }
        tile?.fetchMessage()
    }
    
    // MARK:- viewcontroller tableView handler functions
    func getLength(for tile:Tile) -> Int {
        var length = 100
        if tile.priority <= 0.12 {
            length = 10
        }
        else if tile.priority >= 0.13 && tile.priority <= 0.20 {
            length = 20
        }
        else if tile.priority >= 0.21 && tile.priority <= 0.29 {
            length = 25
        }
        else if tile.priority >= 0.30 && tile.priority <= 0.40 {
            length = 33
        }
        else if tile.priority >= 0.41 && tile.priority <= 0.59 {
            length = 50
        }
        else if tile.priority >= 0.60 && tile.priority <= 0.74 {
            length = 66
        }
        else if tile.priority >= 0.75 && tile.priority <= 0.89 {
            length = 75
        }
        
        if (dataSource?.tiles!.count)! <= 15 {
            length = length*3
        } else if (dataSource?.tiles!.count)! >= 16 && (dataSource?.tiles!.count)! <= 24 {
            length = length*2
        }
        
        return length
    }
    
    func getFrame(for tileLength:Int, in contentsView:[UIView]) -> CGRect? {
        var x:Int = 0
        var y:Int = 0
        var tileRect:CGRect?
        var intersects = false
        
        while (y+tileLength) <= (Int(UIScreen.main.bounds.height) - 64) {
            
            x = 0
            intersects = false
            while (x+tileLength) <= Int(UIScreen.main.bounds.width) {
                
                intersects = false
                tileRect = CGRect.init(x:x, y:y, width: tileLength, height: tileLength)
                for subview in contentsView {
                    let rect2 = subview.frame
                    if tileRect!.intersects(rect2) {
                        intersects = true
                        break
                    }
                }
                
                if intersects == false {
                    break
                }
                x += 5
            }
            
            if intersects == false {
                break
            }
            y += 5
        }
        
        return tileRect
    }
}
