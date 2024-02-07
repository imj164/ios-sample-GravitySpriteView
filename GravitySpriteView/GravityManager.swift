//
//  GravityManager.swift
//  GravitySpriteView
//
//  Created by Hiroshi IMAJO on 2024/02/07.
//

import CoreMotion

// 重力を管理するオブジェクト
final class GravityManager: ObservableObject {
    // 重力値
    @Published var gravity: CGVector = CGVector(dx: 0, dy: 0)

    // センサー管理
    private var motionManager = CMMotionManager()
    // センサー値の取得時間間隔
    private let interval = 0.1
    // センサー値から重力値への変換係数
    private let multiply = 10.0

    // イニシャライザ
    init() {
        startSensing()
    }
    // デイニシャライザ
    deinit {
        stopSensing()
    }
    
    // センサー開始
    private func startSensing() {
        // デバイスの動きのセンサーが有効であれば、以下の設定を行う
        if motionManager.isDeviceMotionAvailable {
            // センサーの更新時間間隔を指定
            motionManager.deviceMotionUpdateInterval = interval
            // センサーの更新を開始する、更新されたときの処理を定義する
            motionManager.startDeviceMotionUpdates(to: .main, withHandler: { data, error in
                // センサーデータが空なら処理なし
                guard let data = data else {
                    return
                }
                // センサーデータから重力を取得し
                let gravity = data.gravity
                // 自分自身の重力の値を更新する
                self.gravity = CGVector(dx: gravity.x * self.multiply, dy: gravity.y * self.multiply)  // y方向は正負逆に出る
            })
        }
    }
    // センサー停止
    private func stopSensing() {
        motionManager.stopDeviceMotionUpdates()
    }
}
