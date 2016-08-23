//
//  Updatable.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/22/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation

protocol Updatable {
    /** Defines a common interface for updating views */
    func updateWithModel<T: Model>(model: T)
}