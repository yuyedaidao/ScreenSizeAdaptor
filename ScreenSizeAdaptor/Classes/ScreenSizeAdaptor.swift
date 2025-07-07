//
//  ScreenSizeAdaptor.swift
//  Pods
//
//  Created by 王叶庆 on 2023/5/30.
//

import Foundation

public typealias ScreenSize = ScreenSizeAdaptor

public class ScreenSizeAdaptor {

    public enum Dimension {
        case none
        case width
        case height
    }
    
    /// 分享的实例 （并非单例设计，使用之前需要设置设计大小）
    public static let shared = ScreenSizeAdaptor()
    /// 设备屏幕大小 注意需要此属性需要第一时间设定
    private var mainSize: CGSize = UIScreen.main.bounds.size
    /// 设计图的大小
    private var designSize: CGSize = UIScreen.main.bounds.size
    /// 宽度缩放比例
    public private(set) var wScale: CGFloat = 1
    /// 高度缩放比例
    public private(set) var hScale: CGFloat = 1
    
    public var dimension: Dimension = .none
    
    private init() {}
    
    public init(mainSize: CGSize, designSize: CGSize? = nil) {
        self.mainSize = mainSize
        if let designSize = designSize {
            updateDisignSize(designSize)
        }
    }
    
    @available(*, deprecated, message: "请用init(mainSize: CGSize, designSize: CGSize)完成初始化")
    public init(designSize: CGSize) {
        updateDisignSize(designSize)
    }
    
    public func updateDisignSize(_ size: CGSize) {
        self.designSize = size
        wScale = mainSize.width / size.width
        hScale = mainSize.height / size.height
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
    
    public func size(_ designSize: CGSize) -> CGSize {
        CGSize(width: designSize.width * scale(.width), height: designSize.height * scale(.height))
    }
    
    public func point(_ designPoint: CGFloat) -> CGFloat {
        designPoint * scale(.none)
    }
    
    public class var size: CGSize {
        Self.shared.mainSize
    }
    
    public class var height: CGFloat {
        Self.size.height
    }
    
    public class var width: CGFloat {
        Self.size.width
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
