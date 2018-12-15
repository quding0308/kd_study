//
//  DispatchTest.m
//  kd_study
//
//  Created by hour on 2018/10/17.
//  Copyright © 2018 hour. All rights reserved.
//

#import "DispatchTest.h"

#import <UIKit/UIKit.h>

@implementation DispatchTest

+ (void)test {
    DispatchTest *test = [[DispatchTest alloc] init];
    
//    [test qdSemaphore];
    [test qdGroup];
}

/*
 A dispatch group is a mechanism for monitoring a set of blocks. Your application can monitor the blocks in the group synchronously or asynchronously depending on your needs. By extension, a group can be useful for synchronizing for code that depends on the completion of other tasks.
 
 Note that the blocks in a group may be run on different queues, and each individual block can add more blocks to the group.
 
 The dispatch group keeps track of how many blocks are outstanding, and GCD retains the group until all its associated blocks complete execution.
 */
- (void)qdGroup {
    /**
     dispatch_group_create
     dispatch_group_enter
     dispatch_group_leave
     dispatch_group_wait
     dispatch_group_notify
     dispatch_group_async
     */
    
    dispatch_group_t group = dispatch_group_create();
    
// 为group内增加task
// 方法1：
    // 使group中的task 数量加1
    dispatch_group_enter(group);
        // do sth  做的任务
    // 使group中的task 数量减1   dispatch_group_enter和dispatch_group_leave要匹配，否则系统会认为group任务没有执行完毕
    dispatch_async(dispatch_get_global_queue(0, 0), ^{

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"dispatch_group_leave 222");
            dispatch_group_leave(group);
        });
    });

// 方法2：
    // 把异步任务添加到group 相当于增加一个task    queue为 block任务执行的线程队列

    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"dispatch_group_async ;;;");
    });


    // 当group中的所有task 执行完毕时调用，不会阻塞当前线程
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"dispatch_group_notify");
    });

    // 等待组任务完成，会阻塞当前线程  当group中的所有task执行完，才会解除阻塞当前线程

    dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
        dispatch_group_wait(group, 30);
        NSLog(@"111 end");
    });

}

- (void)qdSemaphore {
    dispatch_semaphore_t _semaphoer;
    _semaphoer = dispatch_semaphore_create(0);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"=== dispatch_semaphore_signal");
        dispatch_semaphore_signal(_semaphoer);

    });
    
    dispatch_semaphore_wait(_semaphoer, DISPATCH_TIME_FOREVER);
    [UIView animateWithDuration:5 animations:^{
        NSLog(@"animations");
    } completion:^(BOOL finished) {
        NSLog(@"animations finished");
    }];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 1), ^{
//    });
    
    
}

@end
