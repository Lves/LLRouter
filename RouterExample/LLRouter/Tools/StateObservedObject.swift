//
//  StateObservedObject.swift
//  LLRouter
//
//  Created by lixingle on 2022/7/12.
//

import SwiftUI
import Combine

// Alternative to @StateObject in iOS13
@available(iOS 13.0, *)
@propertyWrapper
public struct StateObservedObject<T: ObservableObject>: DynamicProperty {
    @State @Lazy private var object: T
    @ObservedObject private var updater = StateObservedObjectUpdater()

    @dynamicMemberLookup public struct Wrapper {
        let value: T
        let update: () -> Void

        public subscript<Subject>(dynamicMember keyPath: ReferenceWritableKeyPath<T, Subject>) -> Binding<Subject> {
            .init(
                get: { value[keyPath: keyPath] },
                set: {
                    value[keyPath: keyPath] = $0
                    update()
                }
            )
        }
    }

    public var projectedValue: Wrapper {
        .init(value: object, update: _updater.wrappedValue.objectWillChange.send)
    }

    public var wrappedValue: T {
        get {
            object
        }
        set {
            object = newValue
        }
    }

    public init(wrappedValue: @autoclosure @escaping () -> T) {
        self._object = State(wrappedValue: Lazy(wrappedValue))
    }

    public mutating func update() {
        _object.wrappedValue.update = _updater.wrappedValue.objectWillChange.send
    }
}

@available(iOS 13.0, *)
extension StateObservedObject {
    @propertyWrapper
    private class Lazy {
        let lazyValue: () -> T
        var cached: T?
        var update: (() -> Void)?
        private var cancellableSet: Set<AnyCancellable> = []

        init(_ value: @escaping () -> T) {
            lazyValue = value
        }

        var wrappedValue: T {
            get {
                if let cached = cached {
                    return cached
                }
                cached = lazyValue()
                cached?
                    .objectWillChange
                    .sink { [weak self] _ in
                        self?.update?()
                    }
                    .store(in: &cancellableSet)

                return cached!
            }
            set {
                cached = newValue
            }
        }
    }
}

@available(iOS 13.0, *)
private class StateObservedObjectUpdater: ObservableObject {
}
