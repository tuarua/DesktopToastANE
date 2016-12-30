//
//  SwiftOSXANE.swift
//  SwiftOSXANE
//
//  Created by User on 04/12/2016.
//  Copyright © 2016 Tua Rua Ltd. All rights reserved.
//

import Cocoa
import Foundation

@objc class SwiftOSXANE: NSObject {

    private var dllContext: FREContext!
    private let aneHelper = ANEHelper()

    private func trace(value:String) {
        FREDispatchStatusEventAsync(self.dllContext, value, "TRACE")
    }

    func getIsSwiftCool(argv:NSPointerArray) -> FREObject {
        return aneHelper.getFreObject(bool: true)
    }

    func getPrice(argv:NSPointerArray) -> FREObject {
        return aneHelper.getFREObject(double: 59.99)
    }

    func getAgeWith(argv:NSPointerArray) -> FREObject {
        var age = 31
        let inFRE:FREObject! = argv.pointer(at: 0)
        let person:Dictionary<String, AnyObject> = aneHelper.getIdObjectFromFREObject(freObject: inFRE)
            as! Dictionary<String, AnyObject>
        if let val = person["age"] as? NSNumber { // AnyObject is read back as NSNumber
            age = Int(val) + 7
        }
        
        return aneHelper.getFreObject(int:age)
    }
    

    func getHelloWorld(argv:NSPointerArray) -> FREObject {
        let inFRE:FREObject! = argv.pointer(at: 0)
        let txt:String = aneHelper.getIdObjectFromFREObject(freObject: inFRE) as! String
        let fre:FREObject = aneHelper.createFREObject(className:"com.tuarua.Person")
        aneHelper.setFREObjectProperty(freObject: fre, name: "name", prop: aneHelper.getFreObject(string: "Kitty"))
        aneHelper.setFREObjectProperty(freObject: fre, name: "age", prop: aneHelper.getFreObject(int: 21))

        let person = aneHelper.getIdObjectFromFREObject(freObject: fre) as! Dictionary<String, AnyObject>
        let personName:String = person["name"] as! String

        return aneHelper.getFreObject(string: "\(txt) talking to \(personName)")

    }
    

    func setFREContext(ctx: FREContext) {
        dllContext = ctx
        aneHelper.setFREContext(ctx:ctx)
    }


}







