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
        let resortsArray = UserDefaults.standard.stringArray(forKey: key) ?? [String]()
        resorts = Set(resortsArray)
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
        let resortsArray = Array(resorts)
        UserDefaults.standard.set(resortsArray, forKey: key)
    }
}
