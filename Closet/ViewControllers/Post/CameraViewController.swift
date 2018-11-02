//
//  CameraViewController.swift
//  Closet
//
//  Created by Levi Linchenko on 01/11/2018.
//  Copyright © 2018 Levi Linchenko. All rights reserved.
//

import UIKit
import AVKit

class CameraViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate, AVCapturePhotoCaptureDelegate {

    @IBOutlet weak var cameraLayer: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var position: AVCaptureDevice.Position = .front
    var capturePhotoOutput: AVCapturePhotoOutput?
    var flash: AVCaptureDevice.FlashMode = .off
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCamera()

    }
    
    
    func setUpCamera(){
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: position) else {fatalError("Poop")}
        
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            capturePhotoOutput = AVCapturePhotoOutput()
            

            capturePhotoOutput!.isHighResolutionCaptureEnabled = true
            let captureMetaDataOutput = AVCaptureMetadataOutput()
            let captureSession = AVCaptureSession()
            captureSession.addInput(input)
            captureSession.addOutput(capturePhotoOutput!)
            
            captureSession.addOutput(captureMetaDataOutput)
            captureSession.startRunning()
            captureMetaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            let videoLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoLayer.frame = cameraLayer.layer.bounds
            videoLayer.videoGravity = .resizeAspectFill
            videoLayer.connection?.videoOrientation = .portrait
            videoLayer.position = CGPoint(x: self.cameraLayer.frame.width/2, y: self.cameraLayer.frame.height/2)
            if cameraLayer.layer.sublayers != nil {
                cameraLayer.layer.replaceSublayer(cameraLayer.layer.sublayers!.first!, with: videoLayer)
            } else {
                cameraLayer.layer.addSublayer(videoLayer)
            }


            
        } catch {
            return
        }
    }
    
    
    
    
    @IBAction func flipCameraTapped(_ sender: Any) {
        if position == .front {
            position = .back
        } else {
            position = .front
        }
        setUpCamera()
    }
    
    
    @IBAction func takePhotoTapped(_ sender: Any) {
     
        
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = flash
        capturePhotoOutput!.capturePhoto(with: photoSettings, delegate: self)
        
    }
    
 
    
    func photoOutput(_ captureOutput: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photoSampleBuffer: CMSampleBuffer?,
                     previewPhoto previewPhotoSampleBuffer: CMSampleBuffer?,
                     resolvedSettings: AVCaptureResolvedPhotoSettings,
                     bracketSettings: AVCaptureBracketedStillImageSettings?,
                     error: Error?) {
        if let error = error {
            print ("💩💩 error in file \(#file), function \(#function), \(error),\(error.localizedDescription)💩💩")
            return
        }
        guard let imageData =
            AVCapturePhotoOutput.jpegPhotoDataRepresentation(forJPEGSampleBuffer: photoSampleBuffer!, previewPhotoSampleBuffer: previewPhotoSampleBuffer) else {return}
        imageView.isHidden = false
        imageView.image = UIImage(data: imageData)
    }

}
