//
//  BitMath.swift
//  CivilGenerations
//
//  Created by Jordan Trana on 8/16/22.
//

import Foundation


public extension Int64 {
    init(_ bytes: [Int8]) {
        precondition(bytes.count <= MemoryLayout<Self>.size)

        var value: Int64 = 0

        for byte in bytes {
            value <<= 8
            value |= Int64(byte)
        }

        self.init(value)
    }
    
    init(_ bytes: [Int32]) {
        precondition(bytes.count <= MemoryLayout<Self>.size)

        var value: Int64 = 0

        for byte in bytes {
            value <<= 32
            value |= Int64(byte)
        }

        self.init(value)
    }
    
    init(first:Int32, second:Int32) {
        self.init([first,second])
    }
    
    var hi:Int32 {
        return Int32(truncatingIfNeeded:self >>> 32)
    }

    var lo:Int32 {
        return Int32(truncatingIfNeeded:self)
    }
    
    init(hi:Int32, lo:Int32) {
        self.init(Int64(hi) << 32 | Int64(lo) & Int64(0xFFFFFFFF))
    }
}


//public static long w (int hi, int lo)
//{
//    return ((long) hi << 32) | lo & 0xFFFFFFFFL;
//}
//
//public static int hi (long w)
//{
//    return (int) (w >>> 32);
//}
//
//public static int lo (long w)
//{
//    return (int) w;
//}



public extension UInt64 {
    init(_ bytes: [UInt8]) {
        precondition(bytes.count <= MemoryLayout<Self>.size)

        var value: UInt64 = 0

        for byte in bytes {
            value <<= 8
            value |= UInt64(byte)
        }

        self.init(value)
    }
    
    init(_ bytes: [UInt32]) {
        precondition(bytes.count <= MemoryLayout<Self>.size)

        var value: UInt64 = 0

        for byte in bytes {
            value <<= 32
            value |= UInt64(byte)
        }

        self.init(value)
    }
    
    init(first:UInt32, second:UInt32) {
        self.init([first,second])
    }
}

infix operator >>> : BitwiseShiftPrecedence
func >>> (lhs: Int64, rhs: Int64) -> Int64 {
    return Int64(bitPattern: UInt64(bitPattern: lhs) >> UInt64(rhs))
}

