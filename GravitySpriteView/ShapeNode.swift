//
//  ShapeNode.swift
//  GravitySpriteView
//
//  Created by Hiroshi IMAJO on 2024/02/07.
//

import SpriteKit

// ノード
final class ShapeNode: SKShapeNode {
    // ノードの色
    private let color = UIColor.red
    // ノード（四角）の辺長
    private let length = 30.0
    // ノードの反発係数
    private let restitution = 0.4

    // イニシャライザ
    override init() {
        super.init()
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // 初期設定
    private func setup() {
        // 四角を生成
        path = CGPath(rect: CGRect(x: -length / 2, y: -length / 2, width: length, height: length), transform: nil)
        // 線の色を指定
        strokeColor = .gray
        // 塗りの色を指定
        fillColor = color
        // 四角形状の物理モデルを適用
        physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: length, height: length))
        // 重力の影響を受ける
        physicsBody?.affectedByGravity = true
        // 動く
        physicsBody?.isDynamic = true
        // 反発係数を指定
        physicsBody?.restitution = restitution
        // ユーザによる操作を受け付ける
        isUserInteractionEnabled = true
    }
    
    // タッチ開始時の処理
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 重力の影響を反転する（受けていたものは受けないように）
        physicsBody?.affectedByGravity.toggle()
        // 動くかどうかも反転する（動いていたものは動かないように）
        physicsBody?.isDynamic.toggle()
        // 塗りの色を変える（動かないものは色がlightGray）
        fillColor = fillColor == color ? .lightGray : color
    }
}
