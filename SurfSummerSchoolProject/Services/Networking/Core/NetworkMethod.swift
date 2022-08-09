//
//  NetworkMethod.swift
//  SurfSummerSchoolProject
//
//  Created by Михаил Светлов on 09.08.2022.
//

import Foundation

enum NetworkMethod: String {

    case get
    case post

}

extension NetworkMethod {

    var method: String {
        rawValue.uppercased()
    }

}
