//
//  CustomCameraController.swift
//  DeepPink
//
//  Created by Artemii Shabanov on 28.01.2021.
//

import UIKit
import AVFoundation
import CoreImage

class CustomCameraController: UIViewController {

    // MARK: - Properties

    // AV
    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    var photoOutput = AVCapturePhotoOutput()
    var orientation: AVCaptureVideoOrientation = .portrait

    var delegate: AVCapturePhotoCaptureDelegate?

    // App
    let appColor: AppColor
    let addLabel: Bool

    // UI
    var filteredImageView = UIImageView()
    var overlay = UIImageView()
    private var counter = 0

    // MARK: - Methods

    func capture(flash: Bool) {
        let settings = AVCapturePhotoSettings()
        if flash {
            settings.flashMode = .on
        } else {
            settings.flashMode = .off
        }
        photoOutput.capturePhoto(with: settings, delegate: delegate!)
    }

    // Init

    init(appColor: AppColor, addLabel: Bool) {
        self.appColor = appColor
        self.addLabel = addLabel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

// MARK: - Private Methods

private extension CustomCameraController {

    func setup() {
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
    }

    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }

    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera],
                                                                      mediaType: AVMediaType.video,
                                                                      position: AVCaptureDevice.Position.unspecified)
        for device in deviceDiscoverySession.devices {

            switch device.position {
            case AVCaptureDevice.Position.front:
                self.frontCamera = device
            case AVCaptureDevice.Position.back:
                self.backCamera = device
            default:
                break
            }
        }

        self.currentCamera = self.backCamera
    }

    func setupInputOutput() {
        do {
            setupCorrectFramerate(currentCamera: currentCamera!)
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
            if captureSession.canAddInput(captureDeviceInput) {
                captureSession.addInput(captureDeviceInput)
            }
            let videoOutput = AVCaptureVideoDataOutput()

            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sample buffer delegate", attributes: []))
            if captureSession.canAddOutput(videoOutput) {
                captureSession.addOutput(videoOutput)
            }
            if captureSession.canAddOutput(photoOutput) {
                captureSession.addOutput(photoOutput)
            }
            captureSession.startRunning()
        } catch {
            print(error)
        }

    }

    func setupCorrectFramerate(currentCamera: AVCaptureDevice) {
        for vFormat in currentCamera.formats {

            let ranges = vFormat.videoSupportedFrameRateRanges as [AVFrameRateRange]
            let frameRates = ranges[0]

            do {
                //set to 240fps - available types are: 30, 60, 120 and 240 and custom
                // lower framerates cause major stuttering
                if frameRates.maxFrameRate == 240 {
                    try currentCamera.lockForConfiguration()
                    currentCamera.activeFormat = vFormat as AVCaptureDevice.Format
                    //for custom framerate set min max activeVideoFrameDuration to whatever you like, e.g. 1 and 180
                    currentCamera.activeVideoMinFrameDuration = frameRates.minFrameDuration
                    currentCamera.activeVideoMaxFrameDuration = frameRates.maxFrameDuration
                }
            }
            catch {
                print("Could not set active format")
                print(error)
            }
        }
    }

    func setupPreviewLayer() {
        filteredImageView.frame = self.view.frame
        filteredImageView.contentMode = .scaleAspectFit
        self.view.addSubview(filteredImageView)
        overlay.frame = self.view.frame
        overlay.contentMode = .scaleAspectFit
        self.view.addSubview(overlay)
    }

    func startRunningCaptureSession() {
        captureSession.startRunning()
    }

}

// MARK: - AVCaptureVideoDataOutputSampleBufferDelegate

extension CustomCameraController: AVCaptureVideoDataOutputSampleBufferDelegate {

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        connection.videoOrientation = orientation

        let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        let cameraImage = CIImage(cvImageBuffer: pixelBuffer!)

        DispatchQueue.main.async {
            self.filteredImageView.image = FilterApplyer.shared.apply(self.appColor, to: cameraImage, addLabel: false)
            guard self.counter < 6 else { return }
            self.counter += 1
            if self.counter > 5  {
                let emptyImage = FilterApplyer.shared.emptyImage(self.appColor, to: cameraImage, addLabel: self.addLabel)
                self.overlay.image = emptyImage
            }
        }
    }

}
