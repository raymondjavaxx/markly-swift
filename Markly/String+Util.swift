//
//  String+Util.swift
//  Markly
//
//  Created by Ramon Torres on 5/2/21.
//

extension String {

    func indexOf(_ character: Character, from index: String.Index) -> String.Index? {
        return self[index...].firstIndex(of: character)
    }

}
