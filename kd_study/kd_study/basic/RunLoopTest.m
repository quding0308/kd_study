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
//    NSRunLoop *_runloop;
    
    NSTimer *_timer;
}

@property (nonatomic, strong) NSMachPort *machPort;


@end

@implementation RunLoopTest

#pragma mark - NSMachPortDelegate
- (void)handleMachMessage:(void *)msg {
    NSLog(@"handleMachMessage");
}

void hello(void) {
    //
}

+ (void)test {
    id obj = [[RunLoopTest alloc] init];
    [obj testThread];
    
    
    
    return;
    
    NSRunLoop *loop = NSRunLoop.mainRunLoop;
    [obj setupObserver:loop];
    
    /*
     observers = (
     // kCFRunLoopEntry
     "<CFRunLoopObserver 0x2815d8500 [0x241acd610]>{valid = Yes, activities = 0x1, repeats = Yes, order = -2147483647, callout = <redacted> (0x23eb9dec0), context = <CFArray 0x282a94e70 [0x241acd610]>{type = mutable-small, count = 1, values = (\n\t0 : <0x1063b8058>\n)}}",
     
     // kCFRunLoopBeforeWaiting
     "<CFRunLoopObserver 0x2815dc5a0 [0x241acd610]>{valid = Yes, activities = 0x20, repeats = Yes, order = 0, callout = <redacted> (0x23e7b2f28), context = <CFRunLoopObserver context 0x280fddea0>}",
    
     // kCFRunLoopBeforeWaiting || kCFRunLoopExit
     "<CFRunLoopObserver 0x2815d8640 [0x241acd610]>{valid = Yes, activities = 0xa0, repeats = Yes, order = 1999000, callout = <redacted> (0x23ebcd77c), context = <CFRunLoopObserver context 0x106403e80>}",
     "<CFRunLoopObserver 0x2815d81e0 [0x241acd610]>{valid = Yes, activities = 0xa0, repeats = Yes, order = 2000000, callout = <redacted> (0x215f94cd4), context = <CFRunLoopObserver context 0x0>}",
     "<CFRunLoopObserver 0x2815d85a0 [0x241acd610]>{valid = Yes, activities = 0xa0, repeats = Yes, order = 2001000, callout = <redacted> (0x23ebcd7fc), context = <CFRunLoopObserver context 0x106403e80>}",
     "<CFRunLoopObserver 0x2815d8460 [0x241acd610]>{valid = Yes, activities = 0xa0, repeats = Yes, order = 2147483647, callout = <redacted> (0x23eb9dec0), context = <CFArray 0x282a94e70 [0x241acd610]>{type = mutable-small, count = 1, values = (\n\t0 : <0x1063b8058>\n)}}"
     ),
     */
    
    /*
     
     typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
     1 kCFRunLoopEntry = (1UL << 0),
     2 kCFRunLoopBeforeTimers = (1UL << 1),
     4 kCFRunLoopBeforeSources = (1UL << 2),
     32 kCFRunLoopBeforeWaiting = (1UL << 5),
     64 kCFRunLoopAfterWaiting = (1UL << 6),
     128 kCFRunLoopExit = (1UL << 7),
     kCFRunLoopAllActivities = 0x0FFFFFFFU
     */
}

- (void)testThread {
    //    _timer = [NSTimer timerWithTimeInterval:0.2 repeats:YES block:^(NSTimer * _Nonnull timer) {
    //        NSLog(@"=== timer %@", [NSDate date]);
    //    }];
    //    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    //    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
    
    _thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadRun) object:nil];
    [_thread start];
    
    __weak __typeof (self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"=== %@", [NSThread currentThread]);
        
        // 直接发消息执行
        [weakSelf.machPort sendBeforeDate:NSDate.date msgid:0 components:nil from:nil reserved:0];
    });
}

- (void)test111 {
    NSThread *thread = [NSThread currentThread];
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
    NSRunLoopMode mode = [loop currentMode];

    NSLog(@"=== test111");
}

- (void)threadRun {
//    while (YES) {
//        NSLog(@"123");
//    }

    [self setupObserver:[NSRunLoop currentRunLoop]];

    NSMachPort *port = (NSMachPort *)[NSMachPort port];
    [port setDelegate:self];
    self.machPort = port;
    [[NSRunLoop currentRunLoop] addPort:port forMode:NSDefaultRunLoopMode];
    
//    [[NSRunLoop currentRunLoop] performSelector:@selector(test111) target:self argument:nil order:1 modes:@[NSDefaultRunLoopMode]];

//    [self performSelector:@selector(test111) withObject:nil afterDelay:3];

    
    NSTimer *timer = [NSTimer timerWithTimeInterval:5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        NSLog(@"=== timer %@", [NSDate date]);
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    [[NSRunLoop currentRunLoop] runUntilDate:NSDate.distantFuture];

    NSLog(@"mode: %@", [[NSRunLoop currentRunLoop] currentMode]);
    
    
//    [self performSelector:@selector(msgReceive:) withObject:@{@"key1":@"value1"}];
//    [self performSelector:@selector(msgReceive:) onThread:_thread withObject:@{@"key1":@"value"} waitUntilDone:NO];
//    [self performSelector:@selector(msgReceive:) onThread:_thread withObject:@{@"key1":@"value1"} waitUntilDone:YES];
//    [self performSelector:@selector(msgReceive:) withObject:@{@"key1":@"value1"} afterDelay:1];
}

- (void)setupObserver:(NSRunLoop *)runloop {
    [self setupObserverRef:runloop.getCFRunLoop];
}

/*
 typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
 1 kCFRunLoopEntry = (1UL << 0),
 2 kCFRunLoopBeforeTimers = (1UL << 1),
 4 kCFRunLoopBeforeSources = (1UL << 2),
 32 kCFRunLoopBeforeWaiting = (1UL << 5),
 64 kCFRunLoopAfterWaiting = (1UL << 6),
 128 kCFRunLoopExit = (1UL << 7),
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
//    CFRunLoopAddObserver(runloopRef, observer, kCFRunLoopCommonModes);
    CFRunLoopAddObserver(runloopRef, observer, kCFRunLoopDefaultMode);
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

@end

