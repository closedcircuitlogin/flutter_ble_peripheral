/*
 * Copyright (c) 2020. Julian Steenbakker.
 * All rights reserved. Use of this source code is governed by a
 * BSD-style license that can be found in the LICENSE file.
 */


import Foundation
import CoreBluetooth
import CoreLocation

class FlutterBlePeripheralManager : NSObject {
    
    let stateChangedHandler: StateChangedHandler
    var peripheralManager: CBPeripheralManager?
    private var initialized = false
    
    init(stateChangedHandler: StateChangedHandler) {
        self.stateChangedHandler = stateChangedHandler
        super.init()
    }
    
    func initialize() {
        if !initialized {
            peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: [CBPeripheralManagerOptionShowPowerAlertKey : true])
            initialized = true
        }
    }
    
    // min MTU before iOS 10
//    var mtu: Int = 158 {
//        didSet {
//          onMtuChanged?(mtu)
//        }
//    }
    
//    var dataToBeAdvertised: [String: Any]!
//
//    var txCharacteristic: CBMutableCharacteristic?
//    var txSubscribed = false {
//        didSet {
//            if txSubscribed {
//                state = .connected
//            } else if isAdvertising() {
//                state = .advertising
//            }
//        }
//    }
//    var rxCharacteristic: CBMutableCharacteristic?
//
//    var txSubscriptions = Set<UUID>()
    
    func start(advertiseData: PeripheralData) {
        if !initialized {
            initialize()
        }
        
        var dataToBeAdvertised: [String: Any]! = [:]
        if (advertiseData.uuid != nil) {
            dataToBeAdvertised[CBAdvertisementDataServiceUUIDsKey] = [CBUUID(string: advertiseData.uuid!)]
        }
        
        if (advertiseData.localName != nil) {
            dataToBeAdvertised[CBAdvertisementDataLocalNameKey] = advertiseData.localName
        }
        
        print("[flutter_ble_peripheral] start advertising data: \(String(describing: dataToBeAdvertised))")
        
        peripheralManager?.startAdvertising(dataToBeAdvertised)
        
//         TODO: Add service to advertise
//        if peripheralManager.state == .poweredOn {
//            addService()
//        }
    }
    
// TODO: Add service to advertise
//    private func addService() {
//        // Add service and characteristics if needed
//        if txCharacteristic == nil || rxCharacteristic == nil {
//
//            let mutableTxCharacteristic = CBMutableCharacteristic(type: CBUUID(string: PeripheralData.txCharacteristicUUID), properties: [.read, .write, .notify], value: nil, permissions: [.readable, .writeable])
//            let mutableRxCharacteristic = CBMutableCharacteristic(type: CBUUID(string: PeripheralData.rxCharacteristicUUID), properties: [.read, .write, .notify], value: nil, permissions: [.readable, .writeable])
//
//            let service = CBMutableService(type: CBUUID(string: PeripheralData.serviceUUID), primary: true)
//            service.characteristics = [mutableTxCharacteristic, mutableRxCharacteristic];
//
//            peripheralManager.add(service)
//
//            self.txCharacteristic = mutableTxCharacteristic
//            self.rxCharacteristic = mutableRxCharacteristic
//        }
//
//        peripheralManager.startAdvertising(dataToBeAdvertised)
//    }
//
//    func send(data: Data) {
//
//        print("[flutter_ble_peripheral] Send data: \(data)")
//
//        guard let characteristic = txCharacteristic else {
//            return
//        }
//
//        peripheralManager.updateValue(data, for: characteristic, onSubscribedCentrals: nil)
//    }
}
