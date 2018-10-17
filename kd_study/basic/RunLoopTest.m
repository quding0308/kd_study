//
//  RunLoopTest.m
//  Test111
//
//  Created by hour on 2018/10/16.
//  Copyright © 2018 hour. All rights reserved.
//

#import "RunLoopTest.h"

#import <UIKit/UIKit.h>

#include <math.h>
#include <stdio.h>
#include <limits.h>
//

static CFRunLoopSourceRef _source;

@implementation RunLoopTest

+ (void)test {
    
    
    
}

//static CFDataRef Callback(CFMessagePortRef port,
//                          SInt32 messageID,
//                          CFDataRef data,
//                          void *info) {
//    NSLog(@"");
//}

- (void)test {
    
    // Do any additional setup after loading the view, typically from a nib.
    CFRunLoopRef loop = CFRunLoopGetMain();
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(NULL, kCFRunLoopBeforeSources, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"observer %lu", activity);
    });
    CFRunLoopAddObserver(loop, observer, kCFRunLoopCommonModes);
    
    
}

/**
 RunLoopMode
 
 
 
 */
- (void)sRunLoopMode {
    
    kCFRunLoopCommonModes;
    /*
     CommonMode
     一个 Mode 可以将自己标记为”Common”属性（通过将其 ModeName 添加到 RunLoop 的 “commonModes” 中）。
     每当 RunLoop 的内容发生变化时，RunLoop 都会自动将 _commonModeItems 里的 Source/Observer/Timer 同步到具有 “Common” 标记的所有Mode里。
     _commonModes存储了标记为common的mode
     
     _commonModeItems里存储的是common mode中的Set<Source/Observer/Timer>
     
     // 将mode标记为common
     CFRunLoopAddCommonMode(loop, mode);
     
     实际使用：
     main runloop中增加一个timer 如果只增加到  kCFRunLoopDefaultMode，则当页面滑动出发  mode：UITrackingRunLoopMode，改timer就无法被触发。此时可以把timer增加到  kCFRunLoopCommonModes，无论kCFRunLoopDefaultMode 或 UITrackingRunLoopMode 都可以触发timer
     
     
     iOS公开提供了两个Mode
         * UITrackingRunLoopMode
         * kCFRunLoopDefaultMode
     
     UITrackingRunLoopMode
     界面跟踪 Mode，用于 ScrollView 追踪触摸滑动，保证界面滑动时不受其他 Mode 影响
     
     kCFRunLoopDefaultMode
     默认Mode，主线程是在这个Mode运行
     */
    
}

- (void)sRunLoopObserver {
    /*
         typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
             kCFRunLoopEntry = (1UL << 0), // 即将进入Loop（执行一次）
             kCFRunLoopBeforeTimers = (1UL << 1), // 即将处理 Timer
             kCFRunLoopBeforeSources = (1UL << 2), // 即将处理 Source
             kCFRunLoopBeforeWaiting = (1UL << 5), // 即将休眠
             kCFRunLoopAfterWaiting = (1UL << 6), // 刚从休眠中被唤醒
             kCFRunLoopExit = (1UL << 7) // Loop即将退出（执行一次）
         };
     */
    
    CFRunLoopObserverRef observer1 = CFRunLoopObserverCreateWithHandler(NULL, kCFRunLoopEntry, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"kCFRunLoopEntry");
    });
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer1, kCFRunLoopCommonModes);
    
    
    
    // 即将休眠
    CFRunLoopObserverRef observer2 = CFRunLoopObserverCreateWithHandler(NULL, kCFRunLoopBeforeWaiting, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"kCFRunLoopBeforeWaiting");
    });
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer2, kCFRunLoopCommonModes);
    
    // 从休眠中被唤醒
    CFRunLoopObserverRef observer3 = CFRunLoopObserverCreateWithHandler(NULL, kCFRunLoopAfterWaiting, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"kCFRunLoopAfterWaiting");
    });
    CFRunLoopAddObserver(CFRunLoopGetMain(), observer3, kCFRunLoopCommonModes);
}

- (void)sRunLoopTimer {
    /**
     allocator
     The allocator to use to allocate memory for the new object. Pass NULL or kCFAllocatorDefault to use the current default allocator.
     fireDate
     The time at which the timer should first fire. The fine precision (sub-millisecond at most) of the fire date may be adjusted slightly by the timer if there are implementation reasons to do so.
     interval
     The firing interval of the timer. If 0 or negative, the timer fires once and then is automatically invalidated. The fine precision (sub-millisecond at most) of the interval may be adjusted slightly by the timer if implementation reasons to do so exist.
     flags
     Currently ignored. Pass 0 for future compatibility.
     order
     A priority index indicating the order in which run loop timers are processed. Run loop timers currently ignore this parameter. Pass 0.
     block
     The block invoked when the timer fires. The block takes one argument:
     timer
     The run loop timer that is firing.
     */
    CFRunLoopTimerRef timer1 = CFRunLoopTimerCreate(NULL, CFAbsoluteTimeGetCurrent() + 15, 3, 0, 0, Callback, NULL);
    CFRunLoopAddTimer(CFRunLoopGetMain(), timer1, kCFRunLoopCommonModes);
    
    CFRunLoopTimerRef timer2 = CFRunLoopTimerCreateWithHandler(NULL, 15, 3, 0, 0, ^(CFRunLoopTimerRef timer) {
            NSLog(@"timer nock");
    });
    CFRunLoopAddTimer(CFRunLoopGetMain(), timer2, kCFRunLoopCommonModes);
}

- (void)sRunLoopSource {
    /*
     CFRunLoopSourceRef 是事件产生的地方。
     Source有两个版本：Source0 和 Source1。
     • Source0 只包含了一个回调（函数指针），它并不能主动触发事件。使用时，你需要先调用 CFRunLoopSourceSignal(source)，将这个 Source 标记为待处理，然后手动调用 CFRunLoopWakeUp(runloop) 来唤醒 RunLoop，让其处理这个事件。
     • Source1 包含了一个 mach_port 和一个回调（函数指针），被用于通过内核和其他线程相互发送消息。这种 Source 能主动唤醒 RunLoop 的线程。
     
     */
    
    // source0
    CFRunLoopSourceContext context = {0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL};
    //    CFRunLoopSourceContext1 context = {0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL};
    _source = CFRunLoopSourceCreate(NULL, 0, &context);
    CFRunLoopAddSource(CFRunLoopGetMain(), _source, kCFRunLoopCommonModes);
    
//    CFRunLoopSourceSignal(_source);
//    CFRunLoopWakeUp(CFRunLoopGetMain());
    NSLog(@"");
}

static void Callback() {
    // send source
    CFRunLoopSourceSignal(_source);
    // source0 需要主动触发
    Boolean isValid = CFRunLoopSourceIsValid(_source);
    NSLog(@"callback %i", isValid);
}

- (void)runLoopInstance {
    CFRunLoopRef mainRunLoop = CFRunLoopGetMain();
    
    CFRunLoopRef curRunLoop = CFRunLoopGetCurrent();
    
//    [self performSelector:<#(nonnull SEL)#> withObject:<#(nullable id)#> afterDelay:<#(NSTimeInterval)#>];
    
//    NSDefaultRunLoopMode;
//    NSRunLoopCommonModes;
//
//    kCFRunLoopDefaultMode;
//    kCFRunLoopCommonModes;
    
    CFRunLoopRun();
    
//    CFMessagePortRef localPort = CFMessagePortCreateLocal(nil, CFSTR("com.hello.apple"), Callback, nil, nil);
//    CFRunLoopSourceRef sourceRef = CFMessagePortCreateRunLoopSource(nil, localPort, 0);
    
    [[NSMachPort alloc] init];
    
//    CFRunLoopRunInMode(<#CFRunLoopMode mode#>, <#CFTimeInterval seconds#>, <#Boolean returnAfterSourceHandled#>)
//
//    mach_msg_header_t *head =
//
//    mach_msg_send(<#mach_msg_header_t *#>);
//
//    cfrunloopaddcomm
//    CFRunLoopRunInMode(<#CFRunLoopMode mode#>, <#CFTimeInterval seconds#>, <#Boolean returnAfterSourceHandled#>)
//
//
//    CFAllocatorRef alloc = CFAllocatorGetDefault();
//    [CFRunLoopTimerCreateWithHandler(<#CFAllocatorRef allocator#>, <#CFAbsoluteTime fireDate#>, <#CFTimeInterval interval#>, <#CFOptionFlags flags#>, <#CFIndex order#>, <#^(CFRunLoopTimerRef timer)block#>)]
//
//
//    CFRunLoopSourceSignal(<#CFRunLoopSourceRef source#>)
//
//    CFRunLoopSourceRef source0 =
//    CFRunLoopSourceCreate(<#CFAllocatorRef allocator#>, <#CFIndex order#>, <#CFRunLoopSourceContext *context#>)
    
    
//    CFRunLoopMode mode = kCFRunLoopDefaultMode;
//    CFRunLoopTimerRef timer = CFRunLoopTimerCreate(<#CFAllocatorRef allocator#>, <#CFAbsoluteTime fireDate#>, <#CFTimeInterval interval#>, <#CFOptionFlags flags#>, <#CFIndex order#>, <#CFRunLoopTimerCallBack callout#>, <#CFRunLoopTimerContext *context#>)
//    CFRunLoopAddTimer(curRunLoop, <#CFRunLoopTimerRef timer#>, mode);
//
//    CFRunLoopGetMain()
//
//    CFRunLoopRemoveTimer(<#CFRunLoopRef rl#>, <#CFRunLoopTimerRef timer#>, <#CFRunLoopMode mode#>)
//    CFRunLoopRemoveSource(<#CFRunLoopRef rl#>, <#CFRunLoopSourceRef source#>, <#CFRunLoopMode mode#>)
//    CFRunLoopRemoveObserver(<#CFRunLoopRef rl#>, <#CFRunLoopObserverRef observer#>, <#CFRunLoopMode mode#>)
//
    
    
}

@end

