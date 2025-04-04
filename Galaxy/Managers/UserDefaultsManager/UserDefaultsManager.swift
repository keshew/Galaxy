import SwiftUI

enum Keys: String {
    case shopItems = "shopItems"
    case tableItems = "tableItems"
    case currentLevel = "currentLevel"
    case coin = "coin"
    case life = "life"
    case backgroundVolume = "backgroundVolume"
    case soundEffectVolume = "soundEffectVolume"
    case isSoundEnabled = "isSoundEnabled"
    case isMusicEnabled = "isMusicEnabled"
    case levelScores = "levelScores"
}

class UserDefaultsManager: ObservableObject {
    static let defaults = UserDefaults.standard
    
    @Published var arrayOfBalls: [BallModel] = [
        BallModel(name: "Mystical\nball", image: GalaxyImageName.ball1.rawValue, isAvailible: false, isSelected: false),
        BallModel(name: "Esoteric\nball", image: GalaxyImageName.ball2.rawValue, isAvailible: false, isSelected: false),
        BallModel(name: "Occult\nball", image: GalaxyImageName.ball3.rawValue, isAvailible: false, isSelected: false),
        BallModel(name: "Spiritual\nball", image: GalaxyImageName.ball4.rawValue, isAvailible: false, isSelected: false),
        BallModel(name: "Supernatural\nball", image: GalaxyImageName.ball5.rawValue, isAvailible: false, isSelected: false)]
    
    @Published var arrayOfTable: [TableModel] = [
        TableModel(name: "Mystical\nDesk", image: GalaxyImageName.desc1.rawValue, deskName: "table1", isAvailible: false, isSelected: false),
        TableModel(name: "Esoteric\nDesk", image: GalaxyImageName.desc2.rawValue, deskName: "table2", isAvailible: false, isSelected: false),
        TableModel(name: "Occult\nDesk", image: GalaxyImageName.desc3.rawValue, deskName: "table3", isAvailible: false, isSelected: false),
        TableModel(name: "Spiritual\nDesk", image: GalaxyImageName.desc4.rawValue, deskName: "table4", isAvailible: false, isSelected: false),
        TableModel(name: "Supernatural\nDesk", image: GalaxyImageName.desc5.rawValue, deskName: "table5", isAvailible: false, isSelected: false)]
    
    init() {
        if let savedBalls = loadBalls() {
            self.arrayOfBalls = savedBalls
        }
        
        if let savedTables = loadDesk() {
            self.arrayOfTable = savedTables
        }
        saveDesk()
        saveBalls()
    }
    
    func firstLaunch() {
        if UserDefaultsManager.defaults.object(forKey: Keys.currentLevel.rawValue) == nil {
            UserDefaultsManager.defaults.set(1000,  forKey: Keys.coin.rawValue)
            UserDefaultsManager.defaults.set(5,  forKey: Keys.life.rawValue)
            UserDefaultsManager.defaults.set(1,  forKey: Keys.currentLevel.rawValue)
            UserDefaultsManager.defaults.set(0.5, forKey: Keys.backgroundVolume.rawValue)
            UserDefaultsManager.defaults.set(0.5, forKey: Keys.soundEffectVolume.rawValue)
        }
    }
    
    func loadBalls() -> [BallModel]? {
        if let savedItemsData = UserDefaultsManager.defaults.data(forKey: Keys.shopItems.rawValue) {
            let decoder = JSONDecoder()
            if let loadedBalls = try? decoder.decode([BallModel].self, from: savedItemsData) {
                return loadedBalls
            }
        }
        return nil
    }
    
    func loadDesk() -> [TableModel]? {
        if let savedItemsData = UserDefaultsManager.defaults.data(forKey: Keys.tableItems.rawValue) {
            let decoder = JSONDecoder()
            if let loadedBalls = try? decoder.decode([TableModel].self, from: savedItemsData) {
                return loadedBalls
            }
        }
        return nil
    }
    
    func saveBalls() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(arrayOfBalls) {
            UserDefaultsManager.defaults.set(encoded, forKey: Keys.shopItems.rawValue)
        }
    }
    
    func saveDesk() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(arrayOfTable) {
            UserDefaultsManager.defaults.set(encoded, forKey: Keys.tableItems.rawValue)
        }
    }
    
    
    func manageShopItem(at index: Int) {
        guard index >= 0 && index < arrayOfBalls.count else {
            return
        }
        
        var selectedItem = arrayOfBalls[index]
        
        if selectedItem.isSelected {
            return
        }
        
        if selectedItem.isAvailible {
            for i in 0..<arrayOfBalls.count {
                if arrayOfBalls[i].isSelected {
                    arrayOfBalls[i].isSelected = false
                    arrayOfBalls[i].isAvailible = true
                    break
                }
            }
            
            selectedItem.isSelected = true
            selectedItem.isAvailible = false
            arrayOfBalls[index] = selectedItem
            
        } else {
            let countOfMoney = UserDefaultsManager.defaults.integer(forKey: Keys.coin.rawValue)
            if countOfMoney >= 30 {
                selectedItem.isAvailible = true
                for i in 0..<arrayOfBalls.count {
                    if arrayOfBalls[i].isSelected {
                        arrayOfBalls[i].isSelected = false
                        arrayOfBalls[i].isAvailible = true
                        break
                    }
                }
                
                selectedItem.isSelected = true
                selectedItem.isAvailible = false
                UserDefaultsManager.defaults.set(countOfMoney - 30, forKey: Keys.coin.rawValue)
                arrayOfBalls[index] = selectedItem
                
            }
        }
        
        saveBalls()
    }
    
    func manageDesk(at index: Int) {
        guard index >= 0 && index < arrayOfTable.count else {
            return
        }
        
        var selectedItem = arrayOfTable[index]
        
        if selectedItem.isSelected {
            return
        }
        
        if selectedItem.isAvailible {
            for i in 0..<arrayOfTable.count {
                if arrayOfTable[i].isSelected {
                    arrayOfTable[i].isSelected = false
                    arrayOfTable[i].isAvailible = true
                    break
                }
            }
            
            selectedItem.isSelected = true
            selectedItem.isAvailible = false
            arrayOfTable[index] = selectedItem
            
        } else {
            let countOfMoney = UserDefaultsManager.defaults.integer(forKey: Keys.coin.rawValue)
            if countOfMoney >= 30 {
                selectedItem.isAvailible = true
                for i in 0..<arrayOfTable.count {
                    if arrayOfTable[i].isSelected {
                        arrayOfTable[i].isSelected = false
                        arrayOfTable[i].isAvailible = true
                        break
                    }
                }
                
                selectedItem.isSelected = true
                selectedItem.isAvailible = false
                UserDefaultsManager.defaults.set(countOfMoney - 30, forKey: Keys.coin.rawValue)
                arrayOfTable[index] = selectedItem
                
            }
        }
        
        saveDesk()
    }
    
    func loseLevel() {
        let currentLife = UserDefaultsManager.defaults.object(forKey: Keys.life.rawValue) as? Int ?? 1
        let coin = UserDefaultsManager.defaults.object(forKey: Keys.coin.rawValue) as? Int ?? 1
        if coin >= 30 {
            UserDefaultsManager.defaults.set(coin - 30, forKey: Keys.coin.rawValue)
        }
        
        if currentLife >= 2 {
            UserDefaultsManager.defaults.set(currentLife - 1, forKey: Keys.life.rawValue)
        }
    }
    
    func buyLife() {
        let currentLife = UserDefaultsManager.defaults.object(forKey: Keys.life.rawValue) as? Int ?? 1
        let coin = UserDefaultsManager.defaults.object(forKey: Keys.coin.rawValue) as? Int ?? 1
        if coin >= 30 {
            UserDefaultsManager.defaults.set(coin - 30, forKey: Keys.coin.rawValue)
            UserDefaultsManager.defaults.set(currentLife + 1, forKey: Keys.life.rawValue)
        }
    }
    
    func increaseLevel() {
        let currentLevel = UserDefaultsManager.defaults.object(forKey: Keys.currentLevel.rawValue) as? Int ?? 1
        let currentLife = UserDefaultsManager.defaults.object(forKey: Keys.life.rawValue) as? Int ?? 1
        let coin = UserDefaultsManager.defaults.object(forKey: Keys.coin.rawValue) as? Int ?? 1
        
        UserDefaultsManager.defaults.set(currentLife + 1, forKey: Keys.life.rawValue)
        UserDefaultsManager.defaults.set(coin + 30, forKey: Keys.coin.rawValue)
        UserDefaultsManager.defaults.set(currentLevel + 1, forKey: Keys.currentLevel.rawValue)
    }
    
    func getSelectedBall() -> String? {
        let array =  arrayOfBalls.first { $0.isSelected }
        return array?.image
    }
    
    func getSelectedDesk() -> String? {
        let array = arrayOfTable.first { $0.isSelected }
        return array?.deskName
    }
    
    func saveVolumeSettings(backgroundVolume: Float, soundEffectVolume: Float) {
        UserDefaultsManager.defaults.set(backgroundVolume, forKey: Keys.backgroundVolume.rawValue)
        UserDefaultsManager.defaults.set(soundEffectVolume, forKey: Keys.soundEffectVolume.rawValue)
    }
    
    func loadVolumeSettings() -> (Float, Float) {
        var backgroundVolume = UserDefaultsManager.defaults.float(forKey: Keys.backgroundVolume.rawValue)
        var soundEffectVolume = UserDefaultsManager.defaults.float(forKey: Keys.soundEffectVolume.rawValue)
        if backgroundVolume == 0.0 && soundEffectVolume == 0.0 {
            backgroundVolume = 0.5
            soundEffectVolume = 0.5
        }
        return (backgroundVolume, soundEffectVolume)
    }
    
    func saveSoundSettings(isSoundEnabled: Bool) {
        UserDefaultsManager.defaults.set(isSoundEnabled, forKey: Keys.isSoundEnabled.rawValue)
    }

    func saveMusicSettings(isMusicEnabled: Bool) {
        UserDefaultsManager.defaults.set(isMusicEnabled, forKey: Keys.isMusicEnabled.rawValue)
    }

    func isSoundEnabled() -> Bool {
        return UserDefaultsManager.defaults.bool(forKey: Keys.isSoundEnabled.rawValue)
    }

    func isMusicEnabled() -> Bool {
        return UserDefaultsManager.defaults.bool(forKey: Keys.isMusicEnabled.rawValue)
    }
    
    func saveScore(level: Int, score: Int) {
        var scores = getScoresForLevel(level: level)
        scores.append(score)
        saveScoresForLevel(level: level, scores: scores)
    }
    
    func getScoresForLevel(level: Int) -> [Int] {
        let key = "\(Keys.levelScores.rawValue)_\(level)"
        if let savedData = UserDefaultsManager.defaults.array(forKey: key) as? [Int] {
            return savedData.sorted { $0 > $1 }
        }
        return []
    }
    
    private func saveScoresForLevel(level: Int, scores: [Int]) {
        let key = "\(Keys.levelScores.rawValue)_\(level)"
        UserDefaultsManager.defaults.set(scores, forKey: key)
    }
    
    func getBestScore() -> Int? {
        var allScores: [Int] = []
        for level in 1...UserDefaultsManager.defaults.integer(forKey: Keys.currentLevel.rawValue) {
            let scores = getScoresForLevel(level: level)
            allScores.append(contentsOf: scores)
        }
        return allScores.max()
    }
}
