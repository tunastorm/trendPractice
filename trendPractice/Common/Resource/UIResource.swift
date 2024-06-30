//
//  UIResource.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import UIKit


struct UIResource {
    let number: Number
    static var image = SystemImage()
    static var opacity = Opacity()
    static var fontSize = FontSize()
    
    enum Text {
        static let imageBaseURL = "https://image.tmdb.org/t/p/w780"
        
        case tag
        case mainViewDate
        case mainViewRate
        case mainViewShowDetail
        case mainTableViewCell
        case mainCellOverView
        case mainCellCast
        case mainDetailView
        case searchCollectionView
        case detailView
        case detailViewSimilar
        case detailViewRecommand
        case detailViewPoster
        
        
        var sign: String {
            switch self {
            case .tag: return "#"
            default: return "\(self) is Wrong Case for sign"
            }
        }
        
        var navigationTitle: String {
            switch self {
            case .mainDetailView: return "출연/제작"
            case .searchCollectionView: return  "콘텐츠 검색"
            case .detailView: return  "추천 콘텐츠"
            default: return "\(self) is Wrong Case for title"
            }
        }
        
        var label: String {
            switch self {
            case .mainViewRate: return "평점"
            case .mainViewShowDetail: return "자세히 보기"
            case .mainCellOverView: return "OverView"
            case .mainCellCast: return "Cast"
            case .detailViewSimilar: return "비슷한 "
            case .detailViewRecommand: return "추천 "
            case .detailViewPoster: return "포스터"
            default: return "\(self) is Wrong Case for rateTitle"
            }
        }
        
        var dateFormatString: String {
            switch self {
            case .mainViewDate: return "MM/dd/yyyy"
            default: return "\(self) is Wrong Case for dateFormatString"
            }
        }
        
        var placeHolder: String {
            switch self {
            case .searchCollectionView: return "영화 제목을 검색해 보세요"
            default: return "\(self) is Wrong Case for placeHolder"
            }
        }
    }
    
    enum Number {
        case mainViewVideoUIView
        
        var cornerRadious: CGFloat {
            switch self {
            case .mainViewVideoUIView: return CGFloat(20)
            default: return CGFloat(0)
            }
        }
        
        var shadowCornerRadious: CGFloat {
            switch self {
            case .mainViewVideoUIView: return CGFloat(30)
            default: return CGFloat(0)
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
    let person = UIImage(systemName: "person")
    let listTriangl = UIImage(systemName: "list.triangle")
    let magnifyingGlass = UIImage(systemName: "magnifyingglass")
    let paperClip = UIImage(systemName: "paperclip")
    let chevronRight = UIImage(systemName: "chevron.right")
    let chevronLeft = UIImage(systemName: "chevron.left")
    let chevronDown = UIImage(systemName: "chevron.down")
    let chevronUp = UIImage(systemName: "chevron.up")
    let wifiExclamationmark = UIImage(systemName: "wifi.exclamationmark")!.withTintColor(.white, renderingMode: .alwaysOriginal)
}

struct Opacity {
    let full = Float(1.0)
    let half = Float(0.5)
    let quater = Float(0.25)
    let clear = Float(0)
}

struct FontSize {
    let thinest = CGFloat(10)
    let thin = CGFloat(12)
    let middle = CGFloat(15)
    let thick  = CGFloat(18)
}
