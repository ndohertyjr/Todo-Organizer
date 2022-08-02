//
//  DataHandler.swift
//  Todo Organizer
//
//  Created by user220431 on 8/2/22.
//

import Foundation

protocol DataEncoder {
    var encoder: JSONEncoder { get set }
    var decoder: JSONDecoder { get set }
    func encodeTodoData(for dataToConvert: [Todo]) -> Data?
    func decodeTodoData(for dataToConvert: Data) -> [Todo]?
}

struct DataHandler: DataEncoder {
    
    var encoder = JSONEncoder()
    var decoder = JSONDecoder()
    
    // Needed to save custom object to UserDefaults
    func encodeTodoData(for dataToConvert: [Todo]) -> Data? {
        var encodedData: Data?
        do {
            encodedData = try encoder.encode(dataToConvert)
            return encodedData!
        } catch  {
            print("Error encoding data")
            return nil
        }
    }
        
    func decodeTodoData(for dataToConvert: Data) -> [Todo]?{
        var decodedData: [Todo]?
        
        do {
            decodedData = try decoder.decode([Todo].self, from: dataToConvert)
            return decodedData!
            
        } catch {
            print("Error while decoding data!")
            return nil
        }
    }
    
}
