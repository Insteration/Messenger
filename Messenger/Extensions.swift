//
//  Extensions.swift
//  Messenger
//
//  Created by Art Karma on 5/6/19.
//  Copyright © 2019 Art Karma. All rights reserved.
//

import Foundation
import UIKit

extension String {
    static var randomName: String {
        let adjectives = ["autumn", "hidden", "bitter", "misty", "silent", "empty", "dry", "dark", "summer", "icy", "delicate", "quiet", "white", "cool", "spring", "winter", "patient", "twilight", "dawn", "crimson", "wispy", "weathered", "blue", "billowing", "broken", "cold", "damp", "falling", "frosty", "green", "long", "late", "lingering", "bold", "little", "morning", "muddy", "old", "red", "rough", "still", "small", "sparkling", "throbbing", "shy", "wandering", "withered", "wild", "black", "young", "holy", "solitary", "fragrant", "aged", "snowy", "proud", "floral", "restless", "divine", "polished", "ancient", "purple", "lively", "nameless"]
        let nouns = ["waterfall", "river", "breeze", "moon", "rain", "wind", "sea", "morning", "snow", "lake", "sunset", "pine", "shadow", "leaf", "dawn", "glitter", "forest", "hill", "cloud", "meadow", "sun", "glade", "bird", "brook", "butterfly", "bush", "dew", "dust", "field", "fire", "flower", "firefly", "feather", "grass", "haze", "mountain", "night", "pond", "darkness", "snowflake", "silence", "sound", "sky", "shape", "surf", "thunder", "violet", "water", "wildflower", "wave", "water", "resonance", "sun", "wood", "dream", "cherry", "tree", "fog", "frost", "voice", "paper", "frog", "smoke", "star"]
        
        return adjectives.randomElement()! + nouns.randomElement()!
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: 1)
    }
}

//
//Прежде чем мы это сделаем, у нас есть одна проблема. Memberимеет UIColorсвойство, которое не может быть легко представлено в виде значения JSON. Итак, мы будем использовать шестнадцатеричные цветовые коды для представления цвета. Код шестнадцатеричного цвета выглядит следующим образом : #FF5733. В нем шесть цифр. Первые два представляют значение красного между 0 и 255 в шестнадцатеричном формате. Вторые два представляют зеленый , в то время как последние два представляют синий .
//
//Зная это, мы можем конвертировать UIColorтуда и обратно в шестнадцатеричные коды с простым расширением. Добавьте это расширение в Extensions.swift :

//Суть в том, что мы берем шестнадцатеричный код как одно число и отфильтровываем только те две цифры, которые нам нужны для цвета (красный, зеленый или синий). Затем мы конвертируем это число в число от 0 до 1, так как это то, что UIColorиспользуется.

extension UIColor {
    convenience init(hex: String) {
        var hex = hex
        if hex.hasPrefix("#") {
            hex.remove(at: hex.startIndex)
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)
        
        let r = (rgb & 0xff0000) >> 16
        let g = (rgb & 0xff00) >> 8
        let b = rgb & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff,
            alpha: 1
        )
    }
    
    var hexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(
            format: "#%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
}
