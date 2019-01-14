//
//  KDLockTest.m
//  kd_study
//
//  Created by hour on 2018/11/14.
//  Copyright © 2018 hour. All rights reserved.
//

#import "KDLockTest.h"

void hello(int * _Nullable);

#import <pthread.h>
/*
 
 对于 NSLock 及其子类，速度来说 NSLock < NSCondition < NSRecursiveLock < NSConditionLock 。
 */
@implementation KDLockTest

+ (void)test {
    KDLockTest *test = [[KDLockTest alloc] init];
    
//    [test testLock];
    [test testRecursiveLock];
//    [test testCondition];

}

- (void)testLock {
    
    pthread_mutex_t _lock;
    pthread_mutex_init(&_lock, NULL);

    /*
     NSLock
        为全局资源加锁
        线程不安全  lock 与 unlock 需要保证在一个thread中执行
        底层使用npthread实现
        不支持 递归 ，可能会出现死锁
     
     lock
     unlock
     tryLock
     lockBeforeDate:(NSDate *)limit
     */
    NSLock *cLock = [[NSLock alloc] init];
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cLock lock];
        NSLog(@"线程1加锁成功");
        sleep(2);
        NSLog(@"线程1睡眠2s结束");
        [cLock unlock];
    });
    
    // 这种递归 加锁  会导致死锁
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cLock lock];
        NSLog(@"线程1加锁成功");
        //线程2
        //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cLock lock];
        NSLog(@"线程2加锁成功");
        NSLog(@"线程2 执行");
        [cLock unlock];
        //        });
        sleep(2);
        NSLog(@"线程1睡眠2s结束");
        [cLock unlock];
    });
}

- (void)testRecursiveLock {
    /*
     NSRecursiveLock
     为全局资源加锁
     线程不安全  lock 与 unlock 需要保证在一个thread中执行
     底层使用npthread实现
     不支持 递归 ，可能会出现死锁
     
     lock
     unlock
     tryLock
     lockBeforeDate:(NSDate *)limit
     */
    NSRecursiveLock *cLock = [[NSRecursiveLock alloc] init];
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cLock lock];
        NSLog(@"线程1加锁成功");
        sleep(2);
        NSLog(@"线程1睡眠2s结束");
        [cLock unlock];
    });
    
    // 这种递归 加锁  会导致死锁
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cLock lock];
        NSLog(@"线程1加锁成功");
        //线程2
        //        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cLock lock];
        NSLog(@"线程2加锁成功");
        NSLog(@"线程2 执行");
        [cLock unlock];
        //        });
        sleep(2);
        NSLog(@"线程1睡眠2s结束");
        [cLock unlock];
    });
    
    // 这种递归 加锁  不会导致死锁
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [cLock lock];
        NSLog(@"===线程1加锁成功");
        
        [cLock lock];
        NSLog(@"===线程2加锁成功");
        NSLog(@"===线程2 执行");
        [cLock unlock];
        
        sleep(2);
        NSLog(@"===线程1睡眠2s结束");
        [cLock unlock];
    });
}

- (void)testCondition {
    /*
     NSCondition 有两个角色
        lock 有一个锁 在lock 和 unlock 之间执行 task 和 condition对应的操作(wait、signal等)
        checkpoint 类似于 semaphore
     
     wait：进入等待状态
     waitUntilDate:：让一个线程等待一定的时间
     signal：唤醒一个等待的线程
     broadcast：唤醒所有等待的线程
     
     // 保证原子性
     lock
     unlock
     */
    NSCondition *condition = [[NSCondition alloc] init];
    
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"start");
        [condition lock];
        [condition waitUntilDate:[NSDate dateWithTimeIntervalSinceNow: 2]];
        NSLog(@"线程1");
        [condition unlock];
    });
    
    
    NSCondition *cLock = [NSCondition new];
    //线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cLock lock];
        NSLog(@"线程1加锁成功");
        [cLock wait];
        NSLog(@"线程1");
        [cLock unlock];
    });
    
    //线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cLock lock];
        NSLog(@"线程2加锁成功");
        [cLock wait];
        NSLog(@"线程2");
        [cLock unlock];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(2);
        NSLog(@"唤醒一个等待的线程");
        [cLock signal];
//        [cLock broadcast];
    });
    
}

- (void)testConditionLock {
    // lock 多了个参数 condition
    NSConditionLock *lock = [[NSConditionLock alloc] initWithCondition:1];
    
    // 满足 condition == 1 加锁
    [lock tryLockWhenCondition:1];
    
    // 直接加锁  忽略 condition
    [lock tryLock];
    
    // 解锁 并且 设置 condition = 2
    [lock unlockWithCondition:2];
    
    
    
}

- (void)testThread {
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        //
    }];
    
    [thread start];
    
    
}


@end
