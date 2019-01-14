//
//  RunLoopTest.m
//  Test111
//
//  Created by hour on 2018/10/16.
//  Copyright © 2018 hour. All rights reserved.
//

#import "RunLoopTest.h"

#import <UIKit/UIKit.h>

#import <objc/runtime.h>
#import <objc/message.h>

#include <math.h>
#include <stdio.h>
#include <limits.h>
//

void hello(void);

static CFRunLoopSourceRef _source;

@interface RunLoopTest () <NSMachPortDelegate> {
    NSThread *_thread;
    NSMachPort *_machPort;
    NSRunLoop *_runloop;
    
    NSTimer *_timer;
}

@end

@implementation RunLoopTest

#pragma mark - NSMachPortDelegate
- (void)handleMachMessage:(void *)msg {
    NSLog(@"");
}

void hello(void) {
    //
    
    
}

+ (void)test {
//    kCFRunLoopDefaultMode
    
    id obj = [[RunLoopTest alloc] init];
    [obj testThread];
}

- (void)testThread {
    _thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadRun) object:nil];
    [_thread start];
    
    __weak __typeof (self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        BOOL *executing = _thread.isExecuting;
        BOOL isMainThread = [_thread isMainThread];
        NSLog(@"=== %i", executing);
        
//        [_machPort send];
        
        // 直接发消息执行
        [self performSelector:@selector(msgReceive:) onThread:_thread withObject:@{@"key2":@"value2"} waitUntilDone:YES];
        [_machPort sendBeforeDate:NSDate.date msgid:0 components:nil from:nil reserved:0];

    });
    
    [self performSelector:@selector(msgReceive:) onThread:_thread withObject:@{@"key1":@"value1"} waitUntilDone:YES];
    
    
    _timer = [NSTimer timerWithTimeInterval:3 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"=== timer");
        
    }];
    
//    [_runloop addTimer:_timer forMode:NSDefaultRunLoopMode];
    
//        [_timer fire];
}

- (void)threadRun {
    NSLog(@"");
    BOOL *executing = _thread.isExecuting;
    BOOL isMainThread = [_thread isMainThread];
    NSLog(@"=== %i", executing);
    
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    _runloop = loop;
    
    [self setupObserver:loop];
    
    NSMachPort *port = (NSMachPort *)[NSMachPort port];
    [port setDelegate:self];
    [loop addPort:port forMode:NSDefaultRunLoopMode];
//    [port scheduleInRunLoop:loop forMode:NSRunLoopCommonModes];
    [loop runUntilDate:NSDate.distantFuture];
    
    
//    [self performSelector:@selector(msgReceive:) withObject:@{@"key1":@"value1"}];
    
//    [self performSelector:@selector(msgReceive:) onThread:_thread withObject:@{@"key1":@"value"} waitUntilDone:NO];
//    [self performSelector:@selector(msgReceive:) onThread:_thread withObject:@{@"key1":@"value1"} waitUntilDone:YES];
//    [self performSelector:@selector(msgReceive:) withObject:@{@"key1":@"value1"} afterDelay:1];
}

- (void)msgReceive:(id)obj {
    NSLog(@"=== %@", obj);
}

//static CFDataRef Callback(CFMessagePortRef port,
//                          SInt32 messageID,
//                          CFDataRef data,
//                          void *info) {
//    NSLog(@"");
//}


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

- (void)setupObserver:(NSRunLoop *)runloop {
    [self setupObserverRef:runloop.getCFRunLoop];
}

/*
 typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
 1 kCFRunLoopEntry = (1UL << 0),
 2 kCFRunLoopBeforeTimers = (1UL << 1),
 4 kCFRunLoopBeforeSources = (1UL << 2),
 18 kCFRunLoopBeforeWaiting = (1UL << 5),
 kCFRunLoopAfterWaiting = (1UL << 6),
 kCFRunLoopExit = (1UL << 7),
 kCFRunLoopAllActivities = 0x0FFFFFFFU
 };
 */
- (void)setupObserverRef:(CFRunLoopRef)runloopRef {
    CFRunLoopObserverRef observer =
        CFRunLoopObserverCreateWithHandler(NULL,
                                           kCFRunLoopEntry | kCFRunLoopBeforeTimers | kCFRunLoopBeforeSources | kCFRunLoopBeforeWaiting | kCFRunLoopAfterWaiting | kCFRunLoopExit,
                                           true,
                                           0,
                                           ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        if ((activity & 1) == 1) {
            NSLog(@"=== observer %lu kCFRunLoopEntry", activity);
        } else if (((activity >> 1) & 1) == 1) {
            NSLog(@"=== observer %lu kCFRunLoopBeforeTimers", activity);
        }  else if (((activity >> 2) & 1) == 1) {
            NSLog(@"=== observer %lu kCFRunLoopBeforeSources", activity);
        }  else if (((activity >> 5) & 1) == 1) {
            NSLog(@"=== observer %lu kCFRunLoopBeforeWaiting", activity);
        }  else if (((activity >> 6) & 1) == 1) {
            NSLog(@"=== observer %lu kCFRunLoopAfterWaiting", activity);
        }  else if (((activity >> 7) & 1) == 1) {
            NSLog(@"=== observer %lu kCFRunLoopExit", activity);
        } else {
            NSLog(@"=== observer %lu kCFRunLoopAllActivities", activity);
        }
    });
    CFRunLoopAddObserver(runloopRef, observer, kCFRunLoopCommonModes);
}

@end

