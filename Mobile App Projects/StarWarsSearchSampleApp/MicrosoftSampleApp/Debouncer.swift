//
//  Debouncer.swift
//  MicrosoftSampleApp
//
//  Created by Abhay Curam on 12/12/25.
//

import Foundation

public class Debouncer {
    
    private var timer: Timer = Timer()
    private var delay: TimeInterval
    
    public init(_ delay: TimeInterval) {
        self.delay = delay
    }
    
    public func perform(_ performBlock: @escaping (() -> Void)) {
        timer.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false, block: { timer in
            performBlock()
            timer.invalidate()
        })
    }
    
}
