//
//  transmit model.swift
//  baby Checker
//
//  Created by Yixiao Sun on 4/13/16.
//  Copyright © 2016 Yixiao Sun. All rights reserved.
//

import Foundation

class transmitter {
    var inp: Unmanaged<CFReadStream>?
    var out: Unmanaged<CFWriteStream>?
    var readStream: CFReadStream
    var writeStream: CFWriteStream
    var host: CFString
    var port: UInt32
    init (host: CFString, port: UInt32) {
        self.host = host
        self.port = port
        CFStreamCreatePairWithSocketToHost(nil, host, port, &inp, &out)
        self.readStream = inp!.takeRetainedValue()
        self.writeStream = out!.takeRetainedValue()
    }
    
    func createSocketObj() {
        CFStreamCreatePairWithSocketToHost(nil, host, port, &inp, &out)
        self.readStream = inp!.takeRetainedValue()
        self.writeStream = out!.takeRetainedValue()
    }
    
    func readAll() -> [UInt8] {
        var res = [UInt8]()
        var buf = [UInt8](count: 256, repeatedValue:0)
        var readCount: CFIndex = 256
        var totalCount: CFIndex = 0
        createSocketObj()
        CFReadStreamOpen(readStream)
        repeat {
            readCount = CFReadStreamRead(readStream, &buf, 256)
            res += buf
            totalCount += readCount
        } while readCount==256
        res = Array(res[0...totalCount-1])
        CFReadStreamClose(readStream)
        return res
    }
    
    func sendCmd(cmd: String) {
        createSocketObj()
        CFWriteStreamOpen(writeStream)
        CFWriteStreamWrite(writeStream, cmd, CFIndex(strlen(cmd)))
        CFWriteStreamClose(writeStream)
    }
    
}