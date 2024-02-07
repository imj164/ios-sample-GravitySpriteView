//
//  ContentView.swift
//  GravitySpriteView
//
//  Created by Hiroshi IMAJO on 2024/02/07.
//

import SwiftUI
import SpriteKit

// メイン画面
struct ContentView: View {
    // 重力を管理するオブジェクト
    @ObservedObject private var gravityManager = GravityManager()
    
    // ビュー本体
    var body: some View {
        // 画面全体の情報を取得できるようにするためのコンテナ
        GeometryReader { geometry in
            // シーンを表示するためのビュー
            SpriteView(scene: GameScene(size: geometry.size, gravityManager: gravityManager), debugOptions: [.showsFPS, .showsNodeCount])
        }
    }
}

#Preview {
    ContentView()
}
