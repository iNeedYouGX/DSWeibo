//
//  QRCodeViewController.swift
//  DSWeibo
//
//  Created by JsonBourne on 2020/9/22.
//  Copyright © 2020 JsonBourne. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController, UITabBarDelegate, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var tabbar: UITabBar!
    // 容器视图
    @IBOutlet weak var QRView: UIView!
    // 冲击波图片
    @IBOutlet weak var RQImageView: UIImageView!
    // 容器视图高度
    @IBOutlet weak var QRViewHeight: NSLayoutConstraint!
    // 容器视图宽度
    @IBOutlet weak var QRViewWidth: NSLayoutConstraint!
    // 冲击波顶部约束
    @IBOutlet weak var RQImageViewTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置选中第一个
        tabbar.selectedItem = tabbar.items![0]
        tabbar.delegate = self;
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startAnimate()
        
        starScan();
        
    }
    
    // MARK: - 动画
    func startAnimate()  {
        
        // 1.强制更新界面
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 1) {
            // 1. 首先要设置循环次数
            UIView.setAnimationRepeatCount(MAXFLOAT)
            
            // 1.1
            self.RQImageViewTop.constant = -self.RQImageViewTop.constant;
            
            // 2.强制更新界面
            self.view.layoutIfNeeded()
        }
    }
    
    // 关闭
    @IBAction func closeItemClick(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UITabBarDelegate
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item.tag == 1 {
            QRViewHeight.constant = 300;
            self.RQImageViewTop.constant = -300;
        } else {
            QRViewHeight.constant = 200;
            self.RQImageViewTop.constant = -200;
        }
        
        
        RQImageView.layer.removeAllAnimations()
        
        startAnimate()
    }
    
    // MARK: - 懒加载, 扫码相关
    
    // 会话
    private lazy var session : AVCaptureSession = AVCaptureSession()
    
    // 拿到输入设备
    lazy var deviceInput: AVCaptureDeviceInput? = {
        // 获取摄像头
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        // 创建输入对象
        do {
            let input = try AVCaptureDeviceInput(device: device!)
            return input
        } catch {
            print(error)
            return nil
        }
    }()
    
    // 拿到输出对象
    private lazy var output: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
    // 创建预览图层
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        layer.frame = UIScreen.main.bounds
        return layer
    }()
    
    // 绘制一个边线的图层
    lazy var drawLayer: CALayer = {
        let layer = CALayer()
        layer.frame = UIScreen.main.bounds
        return layer
    }()
    
    // MARK: - 扫描二维码
    func starScan() {
        // 1.判断是否能够将输入添加到会话中
        if !session.canAddInput(deviceInput!) { return }
        
        // 2.判断是否能够将输出添加到会话中
        if !session.canAddOutput(output) { return }
        
        // 3.将输入和输出都添加到会话中
        session.addInput(deviceInput!)
        session.addOutput(output)
        
        // 4.设置输出能够解析的数据类型 注意: 设置能够解析的数据类型, 一定要在输出对象添加到会员之后设置, 否则会报错
        output.metadataObjectTypes =  output.availableMetadataObjectTypes
        print(output.availableMetadataObjectTypes)
        
        // 5.设置输出对象的代理, 只要解析成功就会通知代理
        output.setMetadataObjectsDelegate(self, queue: dispatch_queue_global_t.main)
        
        // 添加预览图层
        view.layer.insertSublayer(previewLayer, at: 0)
        
        // 添加绘制图层到预览图层上
        previewLayer.addSublayer(drawLayer)
        
        // 6.告诉session开始扫描
        session.startRunning()
    }
    
    // 只要解析到数据就会调用
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection)
    {
        clearConers()// 先清空图层在画
        
        // 注意: 要使用stringValue
        let obj: AVMetadataMachineReadableCodeObject? = ((metadataObjects.last) as? AVMetadataMachineReadableCodeObject);
        print(obj as Any);
        print(obj?.stringValue as Any)
        
        if ((obj) != nil) {
            let codeObject = previewLayer.transformedMetadataObject(for: obj!)
            print(codeObject as Any)
            drawCorners(codeObject: codeObject as! AVMetadataMachineReadableCodeObject)
        }
    }
    
    /**
     绘制图形
     
     :param: codeObject 保存了坐标的对象
     */
    private func drawCorners(codeObject: AVMetadataMachineReadableCodeObject)
    {
        // 1.创建一个图层
        let layer = CAShapeLayer()
        layer.lineWidth = 4
        layer.strokeColor = UIColor.red.cgColor
        layer.fillColor = UIColor.clear.cgColor
        
        // 2.创建路径
        //        layer.path = UIBezierPath(rect: CGRect(x: 100, y: 100, width: 200, height: 200)).cgPath
        let path = UIBezierPath()
        var point: CGPoint = CGPoint.zero;
        print(codeObject.corners)
        
        // 2.1移动到第一个点
        point = codeObject.corners.first!
        path.move(to: point)
        for index in 1...codeObject.corners.count - 1 {
            print(index)
            point = codeObject.corners[index]
            path.addLine(to: point)
        }
        
        // 2.3关闭路径
        path.close()
        
        // 2.4绘制路径
        layer.path = path.cgPath
        
        // 3.将绘制好的图层添加到drawLayer上
        drawLayer.addSublayer(layer)
    }
    
    /**
     清空边线
     */
    private func clearConers(){
        // 1.判断drawLayer上是否有其它图层
        if drawLayer.sublayers == nil || drawLayer.sublayers?.count == 0{
            return
        }
        
        // 2.移除所有子图层
        for subLayer in drawLayer.sublayers!
        {
            subLayer.removeFromSuperlayer()
        }
    }
    
    
    
}
