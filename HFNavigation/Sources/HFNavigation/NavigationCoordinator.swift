import Combine
import SwiftUI
import CoreLocation

public protocol NavigationBackHandler {
    func popScreenDueToSwipe()
}

public enum TransitAnimation {
    case none
    case opacity
    case fromTraling
    case fromBottom
    case fluid
    
    var transition: AnyTransition {
        switch self {
        case .none, .opacity, .fluid: return .opacity
        case .fromTraling: return .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .trailing))
        case .fromBottom: return .asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .bottom))
        }
    }
}

public class ScreenInfo: ObservableObject {
    public let screen: any View
    public let animation: TransitAnimation
    public var backHandler: NavigationBackHandler? = nil
    
    init(screen: any View, transition: TransitAnimation) {
        self.screen = screen
        self.animation = transition
    }
}

public class NavigationCoordinator {
    
    public static let shared = NavigationCoordinator()
    
    static let defaultAnimationDuration = 0.27
    static let fluidAnimationDuration = 0.5
    @ObservedProducer public private(set) var curStack: [ScreenInfo] = []
    let topScreen = PassthroughSubject<any View, Never>()
    
    init() { }
    
    public func setStartPoint(_ start: any View) {
        let screenInfo = ScreenInfo(screen: start, transition: .none)
        curStack.append(screenInfo)
        topScreen.send(start)
    }

    public func switchStartPoint(_ point: any View) {
        print("switchStartPoint \(point)")
        let screenInfo = ScreenInfo(screen: point, transition: .opacity)
        
        let transition: () -> Void = {
            self.curStack = [screenInfo]
            self.topScreen.send(point)
        }
        makeTransition(transition, withAnimation: .opacity)
    }

    public static func popBack(count: Int = 1, home: Bool = false) {
        let coordinator = NavigationCoordinator.shared
        var popCount = 0
        if home {
            popCount = coordinator.curStack.count - 1
        } else if coordinator.curStack.count > count {
            popCount = count
        }

        let transition: () -> Void = {
            coordinator.curStack.removeLast(popCount)

            if let last = coordinator.curStack.last {
                coordinator.topScreen.send(last.screen)
            }
        }
        coordinator.makeTransition(transition, withAnimation: nil)
    }
    
    public static func pushScreen(_ screen: any View, withAnimation animation: TransitAnimation = .opacity){
        
        let transition = {
            shared.curStack.append(.init(screen: screen, transition: animation))
            shared.topScreen.send(screen)
        }
        
        shared.makeTransition(transition, withAnimation: animation)
    }
    
    public static func pushPopup(_ popup: any View, withAnimation animation: TransitAnimation = .fromBottom) {
        
        let transition = {
            shared.curStack.append(.init(screen: popup, transition: animation))
            shared.topScreen.send(popup)
        }
        
        shared.makeTransition(transition, withAnimation: animation)
    }
    
    private func makeTransition(_ transition:() -> Void, withAnimation animation: TransitAnimation?) {
        DispatchQueue.main.async {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        let currentAnimation = animation ?? .opacity
        switch currentAnimation {
        case .none: transition()
        case .opacity, .fromTraling, .fromBottom:
            withAnimation(.easeInOut(duration: Self.defaultAnimationDuration)) {
                transition()
            }
        case .fluid:
            withAnimation(.easeInOut(duration: Self.fluidAnimationDuration)) {
                transition()
            }
        }
    }
}
