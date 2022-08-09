//
//  TokenStorage.swift
//  SurfSummerSchoolProject
//
//  Created by Михаил Светлов on 09.08.2022.
//

import Foundation

protocol TokenStorage {

    func getToken() throws -> TokenContainer
    func set(newToken: TokenContainer) throws

}

