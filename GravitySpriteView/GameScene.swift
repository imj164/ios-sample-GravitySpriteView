//
//  Scene.swift
//  GravitySpriteView
//
//  Created by Hiroshi IMAJO on 2024/02/07.
//

import SpriteKit

// シーン
final class GameScene: SKScene {
    // 重力を管理するオブジェクト
    var gravityManager: GravityManager!

    // シーン境界の反発係数
    private let edgeRestitution = 0.4

    // イニシャライザ
    init(size: CGSize, gravityManager: GravityManager) {
        super.init(size: size)
        self.gravityManager = gravityManager
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // シーンが始まったときの処理（主に初期化）
    override func didMove(to view: SKView) {
        // 背景色設定
        backgroundColor = .darkGray
        // 画面境界を生成
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        // 反発係数を設定
        physicsBody?.restitution = edgeRestitution
        // 重力を指定
        physicsWorld.gravity = gravityManager.gravity
    }
    
    // フレームごとに実行する処理
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        // 重力を変更
        physicsWorld.gravity = gravityManager.gravity
    }
    
    // タッチ開始時の処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // タッチ情報がない場合は処理なし
        guard let touch = touches.first else {
            return
        }
        // 新しくノードを生成
        let node = ShapeNode()
        // 位置を設定
        node.position = touch.location(in: self)
        // シーンに追加
        addChild(node)
    }
}
