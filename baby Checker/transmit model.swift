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
    
    
    func createCommandWithArray(cmds:[String]) -> String {
        var out = ""
        for cmd in cmds {
            out += cmd + "*"
        }
        out.removeAtIndex(out.endIndex.predecessor())
        return out
    }
    
    func requireDataWithCommand(cmds: [String]) -> [UInt8] {
        let cmd = createCommandWithArray(cmds)
        createSocketObj()
        CFReadStreamOpen(readStream)
        CFWriteStreamOpen(writeStream)
        let buffsize: CFIndex = 4
        var readCount = buffsize
        var totalCount = 0
        var res = [UInt8]()
        var buf = [UInt8](count: buffsize, repeatedValue: 0)
        CFWriteStreamWrite(writeStream, cmd, CFIndex(strlen(cmd)))
        while !CFReadStreamHasBytesAvailable(readStream) {
            
        }
        repeat {
            readCount = CFReadStreamRead(readStream, &buf, buffsize)
            res += buf
            totalCount += readCount
        } while readCount == buffsize
        res = Array(res[0...totalCount-1])
        
        CFReadStreamClose(readStream)
        CFWriteStreamClose(writeStream)
        
        return res
        
    }
    
}