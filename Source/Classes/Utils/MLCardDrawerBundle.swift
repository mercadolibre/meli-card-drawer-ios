//
//  MLCardDrawerBundle.swift
//  MLCardDrawer
//
//  Created by Eric Ertl on 06/11/2020.
//

import Foundation

internal class MLCardDrawerBundle {
    static func bundle() -> Bundle {
        let bundle = Bundle(for: MLCardDrawerBundle.self)
        if let path = bundle.path(forResource: "MLCardDrawerResources", ofType: "bundle"),
            let resourcesBundle = Bundle(path: path) {
            return resourcesBundle
        }
        return bundle
    }
}
