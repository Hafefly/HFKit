//
//  File.swift
//  
//
//  Created by Samy Mehdid on 27/9/2023.
//

import Combine
import SwiftUI

@propertyWrapper public class ObservedProducer<Type>: ObservableObject {
    @Published private var value: Type

    public init(wrappedValue: Type) {
        value = wrappedValue
    }

    public var wrappedValue: Type {
        get { return value }
        set { DispatchQueue.main.async { self.value = newValue } }
    }

    public var projectedValue: ObservedConsumer<Type> {
        ObservedConsumer(producer: self)
    }
    
    public var publisher: Published<Type>.Publisher {
        get { return $value }
        set { $value = newValue }
    }
    
    public var binding: Binding<Type> {
        Binding(
            get: { self.value },
            set: { self.value = $0 }
        )
    }
}

@propertyWrapper public struct ObservedConsumer<Type>: DynamicProperty {
    @ObservedObject private var value: ObservedProducer<Type>
    
    public init(producer: ObservedProducer<Type>) {
        value = producer
    }
    
    public var wrappedValue: Type {
        get { return value.wrappedValue }
        nonmutating set { value.wrappedValue = newValue }
    }
    
    public var projectedValue: Binding<Type> {
        value.binding
    }
    
    public var publisher : Published<Type>.Publisher {
        value.publisher
    }
}
