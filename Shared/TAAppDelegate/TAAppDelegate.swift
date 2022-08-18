//
//  TAAppDelegate.swift
//  TimTestVideoPlayer
//
//  Created by Timothy Adamcik on 6/10/22.
//

import Foundation

private class WeakDelegate: Equatable {
    
    weak var value: AnyObject?
    
    static func ==(lhs: WeakDelegate, rhs: WeakDelegate) -> Bool {
        return lhs.value === rhs.value
    }
    
    init(value: AnyObject) {
        self.value = value
    }
}

class TADelegateMulticast <T> {
    
    private var delegates: [WeakDelegate] = []
    
    func add(_ delegate: T) {
        guard Mirror(reflecting: delegate).subjectType is AnyClass else { return }
        let newDelegate = WeakDelegate(value: delegate as AnyObject)
        
        for delegate in delegates {
            guard newDelegate != delegate else { return }
        }
        
        delegates.append(newDelegate)
    }

    func remove(_ delegate: T) {
        guard Mirror(reflecting: delegate).subjectType is AnyClass else { return }
        let oldDelegate = WeakDelegate(value: delegate as AnyObject)
        
        for i in 0..<delegates.count {
            guard delegates[i] == oldDelegate else { continue }
            delegates.remove(at: i)
            break
        }
    }
    
    func invoke(_ invocation: (T) -> ()) {
        for delegate in delegates {
            guard let delegate = delegate.value as? T else { continue }
            invocation(delegate)
        }
    }
    
}
