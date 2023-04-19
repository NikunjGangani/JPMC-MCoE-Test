//
//  String+Extension.swift
//  JPMC MCoE TestTests
//
//  Created by Nikunj Gangani on 18/04/2023.
//

import Foundation

extension String {
    func getDataFromJson() -> Data? {
        guard let fileURL = Bundle.main.url(forResource: self, withExtension: "json") else {
                return nil
            }
            return try? Data(contentsOf: fileURL)
    }
}
