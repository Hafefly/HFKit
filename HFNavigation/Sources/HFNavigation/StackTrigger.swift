//
//  CoordinatorViewStackTrigger.swift
//  Arbin
//
//  Created by Alexey Ternopolsky on 20.09.2021.
//
import SwiftUI

private struct GlobalNamespaceKey: EnvironmentKey {
    static var defaultValue: Namespace.ID? {
        nil
    }
}

extension EnvironmentValues {
    var globalNamespace: Namespace.ID? {
        get { self[GlobalNamespaceKey.self] }
        set { self[GlobalNamespaceKey.self] = newValue}
    }
}


public struct StackTrigger: View {
    private let coordinator: NavigationCoordinator
    @ObservedConsumer private var stack: [ScreenInfo]
    @Namespace private var globalNamespace
    @Environment(\.layoutDirection) private var layoutDirection
    
    public init(_ coordinator: NavigationCoordinator) {
        self.coordinator = coordinator
        _stack = coordinator.$curStack
    }
    
    public var body: some View {
        ForEach(Array(zip(stack.indices, stack)), id: \.0) { index, item in
            transformView(view: item.screen)
                .transition(item.animation.transition)
                .zIndex(Double(index))
                .environmentObject(item)
                .disabled(index < stack.count - 1)
        }
        .environment(\.globalNamespace, globalNamespace)
    }
    
    func transformView(view: any View) -> some View {
        return AnyView(view)
    }
}
