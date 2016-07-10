//
//  StringUtility.swift
//  SwiftStringExtensions
//
//  Created by Nemanja Vlahovich on 7/10/16.
//  Copyright © 2016 Nemanja Vlahovic. All rights reserved.
//

import Foundation

extension String {
    
    // Count characters in a String
    
    public var length: Int {
        return self.characters.count
    }
    
    // Capitalize first letter in a String
    
    public var capitalizeFirstLeter: String {
        guard characters.count > 0
            else {
                return self
        }
        var result = self
        result.replaceRange(startIndex...startIndex, with: String(self[startIndex]).capitalizedString)
        return result
    }
    
    // Remove white space
    
    public func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
    // Parses a String containing an int into a optional int and returns int or nil
    
    func asInt() -> Int? {
        let scanner = NSScanner(string: self)
        var int : Int = 0
        
        if scanner.scanInteger(&int) {
            return int
        }
        return nil
        
    }
    
    // Parses a String containing a double into an optional double and returns double, or nil
    
    func asDouble() -> Double? {
        let scanner = NSScanner(string: self)
        var double: Double = 0.0
        
        if scanner.scanDouble(&double) {
            return double
        }
        
        return nil
    }
    
    // Parses a String containing a float into a optional float and returns float, or nil
    
    func asFloat() -> Float? {
        let scanner = NSScanner(string: self)
        var float: Float = 0.0
        
        if scanner.scanFloat(&float) {
            return float
        }
        
        return nil
    }
    
    // Parses a String containing a boolean value into an optional bool and returns bool, or nil
    
    func asBool() -> Bool? {
        let text : String = ""
        if text == "true" || text == "false" || text == "YES" || text == "NO" {
            return (text as NSString).boolValue
        }
        
        return nil
    }
    
    // Count number of words in a String
    
    public var countWords: Int {
        let regularExpression = try? NSRegularExpression(pattern: "\\w+", options: NSRegularExpressionOptions())
        return regularExpression?.numberOfMatchesInString(self, options: NSMatchingOptions(), range: NSRange(location: 0, length: self.length)) ?? 0
    }
    
    // Count number of paragraphs in a String
    
    public var countParagraphs: Int {
        let regularExpression = try? NSRegularExpression(pattern: "\\n", options: NSRegularExpressionOptions())
        let string = self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        return (regularExpression?.numberOfMatchesInString(string, options: NSMatchingOptions(), range: NSRange(location: 0, length: length)) ?? -1) + 1

    }
    
    // Extract URLs from a String
    
    public var getURLs: [NSURL] {
        var urls: [NSURL] = []
        let dataDetector: NSDataDetector?
        
        do {
            dataDetector = try NSDataDetector(types: NSTextCheckingType.Link.rawValue)
        } catch _ as NSError {
            dataDetector = nil
        }
        
        let text = self
        
        if let dataDetector = dataDetector {
            dataDetector.enumerateMatchesInString(text, options: [], range: NSRange(location: 0, length: length), usingBlock: {
                (result: NSTextCheckingResult?, flags: NSMatchingFlags, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
                if let result = result, url = result.URL {
                    urls.append(url)
                }
            })
        }
        return urls
    }
}