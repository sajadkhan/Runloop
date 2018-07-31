//
//  main.swift
//  RunLoop
//
//  Created by Sajad on 7/31/18.
//  Copyright © 2018 Sajad. All rights reserved.
//

import Foundation
//Current runloop, Which is main thread's run loop. Main thread and its runloop are autmatic created by the system
let loop = RunLoop.current

//Add an event to run loop. Timer in this case.
loop.add(Timer.scheduledTimer(withTimeInterval: 0.1,
                              repeats: true,
                              block: { (timer) in
                                print("Timer executed")
}),
         forMode: .defaultRunLoopMode)

//Create an obsever on the current runloop for all activities in the run loop.
let observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault,
                                                  CFRunLoopActivity.allActivities.rawValue,
                                                  true,
                                                  0) { (observer, activity) in
                                                    switch activity {
                                                    case CFRunLoopActivity.entry:
                                                        print("Next loop")
                                                    case CFRunLoopActivity.beforeTimers:
                                                        print("Before timres")
                                                    case CFRunLoopActivity.beforeSources:
                                                        print("Before sources")
                                                    case CFRunLoopActivity.beforeWaiting:
                                                        print("Before waiting")
                                                    case CFRunLoopActivity.afterWaiting:
                                                        print("After waiting")
                                                    case CFRunLoopActivity.exit:
                                                        print("Exit RunLoop")
                                                    default:
                                                        print("Unknown")
                                                    }
                                                    
}

//Add the observer to the run loop
CFRunLoopAddObserver(loop.getCFRunLoop(), observer, CFRunLoopMode.defaultMode)

//Run the loop ten times, for one second in each iteration.
var count = 0
repeat {
    print("Run loop run = \(count)")
    loop.run(until: Date(timeIntervalSinceNow: 1))
    count += 1
} while count < 10




