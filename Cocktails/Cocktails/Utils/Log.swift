//
//  Log.swift
//  Cocktails
//
//  Created by Pasquale on 30/06/22.
//

import Foundation
import os

struct Log {
    private static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm:ss" /* "hh:mm:ssSSS"  "yyyy-MM-dd hh:mm:ssSSS" */
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    private static func emoj(fileName: String)-> String {
        let logEmojis = ["๐","๐","๐ฑ","๐","๐บ","๐ฝ","๐พ","๐ค","๐","๐","๐","๐ง ","๐","๐งค","๐ถ","๐ฑ","๐ญ","๐น","๐ฆ","๐ป","๐จ","๐ต","๐ฆ","๐ฆ","๐","๐ฅ","๐ฅ","โญ๏ธ","๐","๐ฅ","๐ฝ","๐","๐ฟ","๐น","๐","โค๏ธ","๐งก","๐","๐","๐","๐","๐"]
        return logEmojis[abs(fileName.hashValue % logEmojis.count)]
    }
    
    
    private static var isLoggingEnabled: Bool {
#if DEBUG
        return true
#else
        return false
#endif
    }
    
    
    static private func writeLog(_ text: String = "", levelEmoj:String, object: Any, functionName: String, fileName: String, lineNumber: Int) {
        let className = (fileName as NSString).lastPathComponent
        print("\(text) \(dateFormatter.string(from: Date())) \(levelEmoj) \(emoj(fileName: fileName)) \(object) โ๏ธ\(functionName) โ\(className) #\(lineNumber)")
        
    }
    
    static func info(_ text: String = "", _ object: Any = "", functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        if isLoggingEnabled {
            writeLog(text, levelEmoj: "๐ข", object: object, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        }
    }
    
    static func warning(_ text: String = "", _ object: Any = "", functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        if isLoggingEnabled {
            writeLog(text, levelEmoj: "๐ก", object: object, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
        }
    }
    
    static func error(_ text: String = "", _ object: Any = "", functionName: String = #function, fileName: String = #file, lineNumber: Int = #line) {
        writeLog(text, levelEmoj: "๐ด", object: object, functionName: functionName, fileName: fileName, lineNumber: lineNumber)
    }
}

