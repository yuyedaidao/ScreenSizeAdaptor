//
//  ScreenSizeAdaptor.swift
//  Pods
//
//  Created by 王叶庆 on 2023/5/30.
//

import Foundation

public class ScreenSizeAdaptor {
    
    
    enum Dimension {
        case none
        case width
        case height
    }
    
    /// 分享的实例 （并非单例设计，使用之前需要设置设计大小）
    public static let shared = ScreenSizeAdaptor()
    
    /// 设计图的大小
    private var designSize: CGFloat = UIScreen.main.bounds.size
    /// 宽度缩放比例
    public private(set) var wScale: CGFloat = 1
    /// 高度缩放比例
    public private(set) var hScale: CGFloat = 1
    
    public var dimension: Dimension = .none
    
    private init() {}
    
    public init(designSize: CGSize) {
        updateDisignSize(designSize)
    }
    
    public func updateDisignSize(_ size: CGSize) {
        self.designSize = size
        let screenSize = UIScreen.main.bounds.size
        wScale = screenSize.width / size.width
        hScale = screenSize.height / size.height
    }
    
    private func scale(_ dimension: Dimension) -> CGFloat {
        switch self.dimension {
        case .none:
            switch dimension {
            case .none:
                return 1
            case .width:
                return wScale
            case .height:
                return hScale
            }
        case .width:
            return wScale
        case .height:
            return hScale
        }
    }
    
    public func width(_ designWidth: CGFloat) -> CGFloat {
        designWidth * scale(.width)
    }
    
    public func height(_ designHeight: CGFloat) -> CGFloat {
        designHeight * scale(.height)
    }
    
    public func size(_ designSize: CGSize) -> CGFloat {
        CGSize(width: designSize.width * scale(.width), height: designSize.height * scale(.height))
    }
    
    public func point(_ designPoint: CGFloat) -> CGFloat {
        designPoint * scale(.none)
    }
}

public extension CGFloat {
    var h: CGFloat {
        ScreenSizeAdaptor.shared.height(self)
    }
    
    var w: CGFloat {
        ScreenSizeAdaptor.shared.width(self)
    }
    
    var pt: CGFloat {
        ScreenSizeAdaptor.shared.point(self)
    }
}

public extension CGSize {
    var s: CGSize {
        ScreenSizeAdaptor.shared.size(self)
    }
}
