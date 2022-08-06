//
//  DataHandler.swift
//  Todo Organizer
//
//  Created by Neil Doherty on 8/2/22.
//

import Foundation
import CoreData

protocol DataEncoder {
    var jsonEncoder: JSONEncoder { get set }
    var jsonDecoder: JSONDecoder { get set }
    var pListEncoder: PropertyListEncoder { get set }
    var pListDecoder: PropertyListDecoder { get set }
    func encodeTodoDataForJSON(for dataToConvert: [Todo]) -> Data?
    func decodeTodoDataForJSON(for dataToConvert: Data) -> [Todo]?
}

// Struct to assist with encoding/decoding data

struct DataHandler: DataEncoder {
    
    var jsonEncoder = JSONEncoder()
    var jsonDecoder = JSONDecoder()
    var pListEncoder = PropertyListEncoder()
    var pListDecoder = PropertyListDecoder()
    
    // Needed to save custom object to UserDefaults
    func encodeTodoDataForJSON(for dataToConvert: [Todo]) -> Data? {
        var encodedData: Data?
        do {
            encodedData = try jsonEncoder.encode(dataToConvert)
            return encodedData!
        } catch  {
            print("Error encoding JSON data")
            return nil
        }
    }
    
    func decodeTodoDataForJSON(for dataToConvert: Data) -> [Todo]?{
        var decodedData: [Todo]?
        
        do {
            decodedData = try jsonDecoder.decode([Todo].self, from: dataToConvert)
            return decodedData!
            
        } catch {
            print("Error while decoding JSON data!")
            return nil
        }
    }
    
    func encodeTodoDataForPList(for dataToConvert: [Todo]) -> Data? {
        var encodedData: Data?
        
        do {
            encodedData = try pListEncoder.encode(dataToConvert)
            return encodedData!
        } catch  {
            print("Error encoding data for Property List")
            return nil
        }
    }
    
    func decodeTodoDataForPList(for dataToConvert: Data) -> [Todo]?{
        var decodedData: [Todo]?
        
        do {
            decodedData = try pListDecoder.decode([Todo].self, from: dataToConvert)
            return decodedData!
            
        } catch {
            print("Error while decoding JSON data!")
            return nil
        }
    }
    
}

// MARK: Core Data extension
extension DataHandler {
    
}
