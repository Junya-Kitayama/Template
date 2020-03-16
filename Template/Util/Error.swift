//
//  Error.swift
//  Template
//
//  Created by junya kitayama on 2020/03/16.
//  Copyright © 2020 junya kitayama. All rights reserved.
//

import Foundation

enum APIClientError: Error {
    case statusCode(Int)
    case responseParse(String)
    case missingData
    case other(Error)
}
