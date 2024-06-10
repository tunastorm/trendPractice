//
//  UIResource.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import UIKit


struct UIResource {
    let text: Text?
    static var image = SystemImage()
    static var opacity = Opacity()
    static var fontSize = FontSize()
    
    enum Text {
        case tagSign
        case mainViewDate
        case mainViewRate
        case mainViewShowDetail
        
        case mainTableViewCell
        case mainCellOverView
        case mainCellCast
        
        var navigationTitle: String {
            switch self {
            case .mainTableViewCell: return "출연/제작"
            default: return "\(self) is Wrong Case for title"
            }
        }
        
        var label: String {
            switch self {
            case .tagSign: return "#"
            case .mainViewRate: return "평점"
            case .mainViewShowDetail: return "자세히 보기"
            case .mainCellOverView: return "OverView"
            case .mainCellCast: return "Cast"
            default: return "\(self) is Wrong Case for rateTitle"
            }
        }
        
        var dateFormatString: String {
            switch self {
            case .mainViewDate: return "MM/dd/yyyy"
            default: return "\(self) is Wrong Case for dateFormatString"
            }
        }
    }
}

struct SystemImage {
//    let eatRice = UIImage(systemName: "leaf.circle")
//    let eatWater = UIImage(systemName: "drop.circle")
//    let writeName = UIImage(systemName: "pencil")
//    let changeTamagochi = UIImage(systemName: "moon.fill")
//    let resetData = UIImage(systemName: "arrow.clockwise")
//    let personCircle = UIImage(systemName: "person.circle")
    let listTriangl = UIImage(systemName: "list.triangle")
    let magnifyingGlass = UIImage(systemName: "magnifyingglass")
    let paperClip = UIImage(systemName: "paperclip")
    let chevronRight = UIImage(systemName: "chevron.right")
    let chevronLeft = UIImage(systemName: "chevron.left")
    let chevronDown = UIImage(systemName: "chevron.down")
}

struct Opacity {
    let full = Float(1.0)
    let half = Float(0.5)
    let clear = Float(0)
}

struct FontSize {
    let thinest = CGFloat(10)
    let thin = CGFloat(12)
    let middle = CGFloat(15)
    let thick  = CGFloat(18)
}
