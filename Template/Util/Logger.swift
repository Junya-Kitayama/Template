import UIKit
import os.log

extension OSLogType: CustomStringConvertible {
    public var description: String {
        switch self {
        case OSLogType.info:
            return "ℹ️(info)"
        case OSLogType.debug:
            return "🔹(debug)"
        case OSLogType.error:
            return "‼️(error)"
        case OSLogType.fault:
            return "💣(fault)"
        default:
            return "DEFAULT"
        }
    }
}

enum Logger {

    static func info(_ message: String,
                     functionName: StaticString = #function,
                     fileName: StaticString = #file,
                     lineNumber: Int = #line) {
        doLog(message,
              logType: .info,
              functionName: functionName,
              fileName: fileName,
              lineNumber: lineNumber)
    }

    static func debug(_ message: String,
                      functionName: StaticString = #function,
                      fileName: StaticString = #file,
                      lineNumber: Int = #line) {
        doLog(message,
              logType: .debug,
              functionName: functionName,
              fileName: fileName,
              lineNumber: lineNumber)
    }

    static func error(_ message: String,
                      functionName: StaticString = #function,
                      fileName: StaticString = #file,
                      lineNumber: Int = #line) {
        doLog(message,
              logType: .error,
              functionName: functionName,
              fileName: fileName,
              lineNumber: lineNumber)
    }

    static func fault(_ message: String,
                      functionName: StaticString = #function,
                      fileName: StaticString = #file,
                      lineNumber: Int = #line) {
        doLog(message,
              logType: .fault,
              functionName: functionName,
              fileName: fileName,
              lineNumber: lineNumber)
    }

    static func `default`(_ message: String,
                          functionName: StaticString = #function,
                          fileName: StaticString = #file,
                          lineNumber: Int = #line) {
        doLog(message,
              logType: .default,
              functionName: functionName,
              fileName: fileName,
              lineNumber: lineNumber)
    }

    private static func doLog(_ message: String,
                              logType: OSLogType,
                              functionName: StaticString,
                              fileName: StaticString,
                              lineNumber: Int) {

        let log = OSLog(subsystem: Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as! String, category: "default")
        guard log.isEnabled(type: logType) else { return }

        let output = "[\(logType)] [\((String(describing: fileName) as NSString).lastPathComponent):\(lineNumber)] \(functionName) \n => \(message)"

        os_log("%@", output)
    }
}
