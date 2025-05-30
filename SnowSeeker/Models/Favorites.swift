//
//  Favorites.swift
//  SnowSeeker
//

import Foundation

@Observable
class Favorites {
    // ユーザーがお気に入り登録した実際のリゾート
    private var resorts: Set<String>
    
    // UserDefaults で使用するキー
    private let key = "Favorites"
    
    init() {
        // 保存されたデータを読み込む
        
        // データがなければ空の配列を使用
        resorts = []
    }
    
    // 指定されたリゾートがセットに含まれているかどうかを返す
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    // リゾートをセットに追加して変更を保存
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    // リゾートをセットから削除して変更を保存
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // データを書き出す
    }
}
