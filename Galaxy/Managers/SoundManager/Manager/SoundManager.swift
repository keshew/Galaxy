import AVFoundation
import SwiftUI

class SoundManager: ObservableObject {
    static let shared = SoundManager()
    var losePlayer: AVAudioPlayer?
    var winPlayer: AVAudioPlayer?
    var bgPlayer: AVAudioPlayer?
    
    @Published var backgroundVolume: Float {
        didSet {
            losePlayer?.volume = backgroundVolume
            winPlayer?.volume = backgroundVolume
            bgPlayer?.volume = backgroundVolume
        }
    }
    
    @Published var soundEffectVolume: Float {
        didSet {
        }
    }
    
    @Published var isSoundEnabled: Bool = true
    @Published var isMusicEnabled: Bool = true

    init() {
        self.backgroundVolume = UserDefaultsManager().loadVolumeSettings().0
        self.soundEffectVolume = UserDefaultsManager().loadVolumeSettings().1
        self.isSoundEnabled = UserDefaultsManager().isSoundEnabled()
        self.isMusicEnabled = UserDefaultsManager().isMusicEnabled()
        
        loadWinMusic()
        loadLoseMusic()
        loadBackgroundMusic()
        
        if isMusicEnabled {
            playBackgroundMusic()
        }
    }

    private func loadLoseMusic() {
        if let url = Bundle.main.url(forResource: "lose", withExtension: "mp3") {
            do {
                losePlayer = try AVAudioPlayer(contentsOf: url)
                losePlayer?.volume = backgroundVolume
                losePlayer?.prepareToPlay()
            } catch {
                print("Ошибка \(error)")
            }
        }
    }
    
    private func loadWinMusic() {
        if let url = Bundle.main.url(forResource: "win", withExtension: "mp3") {
            do {
                winPlayer = try AVAudioPlayer(contentsOf: url)
                winPlayer?.volume = backgroundVolume
                winPlayer?.prepareToPlay()
            } catch {
                print("Ошибка \(error)")
            }
        }
    }
    
    private func loadBackgroundMusic() {
        if let url = Bundle.main.url(forResource: "bg", withExtension: "wav") {
            do {
                bgPlayer = try AVAudioPlayer(contentsOf: url)
                bgPlayer?.numberOfLoops = -1
                bgPlayer?.volume = backgroundVolume
                bgPlayer?.prepareToPlay()
            } catch {
                print("Ошибка \(error)")
            }
        }
    }
    
    func playLoseMusic() {
        if isSoundEnabled {
            losePlayer?.play()
        }
    }
    
    func stopLoseMusic() {
        losePlayer?.stop()
    }
    
    func playWinMusic() {
        if isSoundEnabled {
            winPlayer?.play()
        }
    }
    
    func stopWinMusic() {
        winPlayer?.stop()
    }
    
    func playBackgroundMusic() {
        if isMusicEnabled {
            bgPlayer?.play()
        }
    }
    
    func stopBackgroundMusic() {
        bgPlayer?.stop()
    }
    
    func toggleSound() {
        isSoundEnabled.toggle()
        UserDefaultsManager().saveSoundSettings(isSoundEnabled: isSoundEnabled)
    }
    
    func toggleMusic() {
        isMusicEnabled.toggle()
        if isMusicEnabled {
            playBackgroundMusic()
        } else {
            stopBackgroundMusic()
        }
        UserDefaultsManager().saveMusicSettings(isMusicEnabled: isMusicEnabled)
    }
}
