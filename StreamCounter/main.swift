#!/usr/bin/env swift

//  Created by Matthew Dias on 1/4/20.
//  Copyright © 2020 Matthew Dias. All rights reserved.

import Foundation

let fileManager = FileManager.default
let currentDirectory = fileManager.currentDirectoryPath
let filePath = "\(currentDirectory)/count.txt"
var count = 0

if !fileManager.fileExists(atPath: filePath) {
    fileManager.createFile(atPath: filePath, contents: nil, attributes: nil)
}

let args = CommandLine.arguments

func increment() {
    if let data = fileManager.contents(atPath: filePath), let fileContents = String(data: data, encoding: .utf8) {
        count = Int(fileContents) ?? 0
    }
    
    count += 1
    write()
}

func reset() {
    count = 0
    write()
}

func write() {
    var output = "\(count)"
    
    if count < 10 {
        output = "0\(count)"
    }
    
    do {
        try output.write(to: URL(fileURLWithPath: filePath), atomically: false, encoding: String.Encoding.utf8)
    } catch {
        // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        print("something went wrong")
    }
}

if args.contains("-r") {
    reset()
} else {
    increment()
}
