//
//  QRCodeScanViewModel.swift
//  restaurant-order
//
//  Created by Andrej Naumovski on 6/5/18.
//  Copyright © 2018 Andrej Naumovski. All rights reserved.
//

import AVFoundation
import RxSwift
import ObjectMapper

class QRCodeScanViewModel: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    enum CameraError: Error {
        case noCameraAvailable
    }
    
    var tableData = Variable<TableData>(TableData())
    
    let session = AVCaptureSession()
    
    func inintializeAndReturnVideoLayer() throws -> AVCaptureVideoPreviewLayer {
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            throw CameraError.noCameraAvailable
        }
        
        let videoInput = try AVCaptureDeviceInput(device: captureDevice)
        session.addInput(videoInput)
        
        let videoOutput = AVCaptureMetadataOutput()
        session.addOutput(videoOutput)
        
        videoOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        
        videoOutput.metadataObjectTypes = [.qr]
        
        return AVCaptureVideoPreviewLayer(session: session)
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count == 0 {
            return
        }
        
        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if let qrCodeValue = metadataObject.stringValue {
            guard let tableData = Mapper<TableData>().map(JSONString: qrCodeValue) else {
                print("Invalid QR code")
                //TODO andrej-naumovski 15.06.2018: Handle error redirection here
                return
            }
            
            self.tableData.value = tableData;
        }
    }
}

