//
//  GCDInto.m
//  Blog
//
//  Created by Mirinda on 2019/6/14.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import "GCDInto.h"
static const char *serialQueueName = "com.GDC.serial";
static const char *concurrentQueueName = "com.GDC.concurrent";
@implementation GCDInto

- (void)GCDEntrance {
//    [self serialQueueUse];
//    [self serialQueueSyncBug];
//    [self mainQueuesyncBug];
//    [self concurrentQueueUse];
//    [self queueQos];
//    [self getQueueLable];
//    [self queueEventBlock];
    //group_enter 是否影响整个全局队列的测试
//    [self group_enter_global_queue];
//    [self setTargetQueue];
//    [self gcdTimer];
//    [self delayAddToQueue];
//    [self subsequentIteration];
//    [self runOnlyOnce];
    [self queueSuspendAndResume];
}

//GCD应用:
//1.串行队列的使用:实验证明串行队列中的任务是,受同一个线程的的调度,按照队列FIFO规则执行
- (void)serialQueueUse {
    dispatch_queue_t serialQueue = dispatch_queue_create(serialQueueName, DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(serialQueue, ^{
        NSLog(@"serialQueue add event: 1 --> in Thread %@ \n", [NSThread currentThread]);
    });
    
    dispatch_async(serialQueue, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"serialQueue add event 2 --> in Thread %@\n",[NSThread currentThread]);
    });
    
    dispatch_async(serialQueue, ^{
        NSLog(@"serialQueue add event 3 --> in Thread %@\n",[NSThread currentThread]);
    });
    
//    dispatch_async(serialQueue, ^{
//        NSLog(@"serialQueue add event: 4 --> in Thread %@ \n", [NSThread currentThread]);
//    });
//
//    dispatch_async(serialQueue, ^{
//
//        NSLog(@"serialQueue add event 5 --> in Thread %@\n",[NSThread currentThread]);
//    });
//
//    dispatch_async(serialQueue, ^{
//        NSLog(@"serialQueue add event 6 --> in Thread %@\n",[NSThread currentThread]);
//    });
//
//    for (int i = 7; i < 100; i++) {
//        dispatch_async(serialQueue, ^{
//            NSLog(@"serialQueue add event %d --> in Thread %@\n",i,[NSThread currentThread]);
//        });
//    }
}

//2.串行队列的误用导致死锁:在线程队列是使用同步,会导致死锁-->A,B都在串行队列S中[A,B] 在事件A中使用同步方式调用时间B: A{syn(b{})},这样
//需要执行A的过程中执行B, 但是只有执行问A后才会去队列中取B,所以执行的事件B的时候,去队列取事件B然而此时A并未完成,所以要等A完成z才能去取事件B
//所以按成时间A和去s队列中取事件B,两者相互等待.造成死锁.
- (void)serialQueueSyncBug {
    dispatch_queue_t serialQueue = dispatch_queue_create(serialQueueName, DISPATCH_QUEUE_SERIAL);
    dispatch_async(serialQueue, ^{
        NSLog(@"A event run ...\n");
        [NSThread sleepForTimeInterval:1];
        NSLog(@"Will run A event \n");
        dispatch_sync(serialQueue, ^{
            NSLog(@"B event run ...\n");
        });
        NSLog(@"A event finish \n");
    });
}

//有序主线程队列是串行队列所以,也有上面的问题
- (void)mainQueuesyncBug {
   //先异步执行主线程队列,证明主线程队列为串行, 再主线程队列中执行同步事件.
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"serialQueue add event: 1 --> in Thread %@ \n", [NSThread currentThread]);
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"event 2 sleep 3 second !\n");
        [NSThread sleepForTimeInterval:3];
        NSLog(@"serialQueue add event: 2 --> in Thread %@ \n", [NSThread currentThread]);
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"serialQueue add event: 3 --> in Thread %@ \n", [NSThread currentThread]);
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"will to main queue sync event ! \n");
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"in main Queue sync event!");
        });
    });
}
//3.并行队列的使用: 队列中的任务是在不同的线程中执行的
- (void)concurrentQueueUse {
    dispatch_queue_t concurrentQueue = dispatch_queue_create(concurrentQueueName, DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(concurrentQueue, ^{
        NSLog(@"concurrnet queue event 1: current Thread = %@", [NSThread currentThread]);
    });
    
    dispatch_async(concurrentQueue, ^{
        NSLog(@"concurrnet queue event 2: current Thread = %@", [NSThread currentThread]);
    });
    
    dispatch_async(concurrentQueue, ^{
        NSLog(@"concurrnet queue event 3: current Thread = %@", [NSThread currentThread]);
    });
    
    dispatch_async(concurrentQueue, ^{
        NSLog(@"concurrnet queue event 4: current Thread = %@", [NSThread currentThread]);
    });
    
    dispatch_async(concurrentQueue, ^{
        NSLog(@"concurrnet queue event 5: current Thread = %@", [NSThread currentThread]);
    });
    
    dispatch_async(concurrentQueue, ^{
        NSLog(@"concurrnet queue event 6: current Thread = %@", [NSThread currentThread]);
    });
    
    
}

//5.队列优先级设置
- (void)queueQos {
    
    //这些知识大致的优先级 但并不会100%按照优先执行,只是大概率但是 QOS_CLASS_BACKGROUND 永远是最低的如果搞后台同步可以用这个,不影响用户体验.
//    全局队列的优先级与QOS的等级映射关系如下：
//    DISPATCH_QUEUE_PRIORITY_HIGH  <===>  QOS_CLASS_USER_INITIATED
//
//    DISPATCH_QUEUE_PRIORITY_DEFAULT    <===> QOS_CLASS_UTILITY
//
//    DISPATCH_QUEUE_PRIORITY_LOW  <===> QOS_CLASS_UTILITY
//
//    DISPATCH_QUEUE_PRIORITY_BACKGROUND  <===>  QOS_CLASS_BACKGROUND

    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"QOS_CLASS_USER_INITIATED");
    });
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UTILITY, 0), ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"QOS_CLASS_UTILITY");
    });
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"QOS_CLASS_BACKGROUND");
    });
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"QOS_CLASS_DEFAULT");
    });
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_UNSPECIFIED, 0), ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"QOS_CLASS_UNSPECIFIED");
    });
    
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INTERACTIVE, 0), ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"QOS_CLASS_USER_INTERACTIVE");
    });
    
}
//6.队列事件的执行等待,线程堵塞等待
- (void)queueEventBlock {
    
    //这种写法居然不对,是全局队列的问题,自己创建一个队列就没问题了?
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"执行事件1: %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
//    });
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"执行事件2: %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
//    });
//
//    dispatch_barrier_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"barrier,先执行事件1和2 在执行3: %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
//    });
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"执行事件3: %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
//    });
//    2019-06-18 17:17:00.830983+0800 Blog[3515:358610] barrier,先执行事件1和2 在执行3: com.apple.root.default-qos
//    2019-06-18 17:17:00.830982+0800 Blog[3515:358611] 执行事件1: com.apple.root.default-qos
//    2019-06-18 17:17:00.830982+0800 Blog[3515:358608] 执行事件2: com.apple.root.default-qos
//    2019-06-18 17:17:00.831012+0800 Blog[3515:358609] 执行事件3: com.apple.root.default-qos
    
    //栅栏的应用
//    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //不能用全局队列,全局队列不支持,不然会拦着别的地方添加到全局队列中的事件.
    dispatch_queue_t queue = dispatch_queue_create("name", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        NSLog(@"执行事件1: %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
    });

    dispatch_async(queue, ^{
        NSLog(@"执行事件2: %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
    });

    dispatch_barrier_async(queue, ^{
        NSLog(@"barrier,先执行事件1和2 在执行3: %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
    });

    dispatch_async(queue, ^{
        NSLog(@"执行事件3: %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
    });
    
    //避免影响后面打印结果
    [NSThread sleepForTimeInterval:3];
    NSLog(@"   ");
    //group notify
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t gQueue = dispatch_get_global_queue(0, 0);
    dispatch_group_async(group, gQueue, ^{
        NSLog(@"group执行事件1:----------");
    });
    dispatch_group_async(group, gQueue, ^{
        [NSThread sleepForTimeInterval:2];
        NSLog(@"group执行事件2:----------");
    });
    
    dispatch_group_notify(group, gQueue, ^{
        NSLog(@"group notify 执行事件1和2m,再执行notify:----------");
    });
    
    //避免影响后面打印结果
    [NSThread sleepForTimeInterval:5];
    NSLog(@" ");

    //group wait
    dispatch_group_async(group, gQueue, ^{
        NSLog(@"group wait 执行事件1:----------");
    });
    dispatch_group_async(group, gQueue, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"group wait 执行事件2:----------");
    });
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    NSLog(@"group wait 执行完事件1,事件2 这是wait之后的打印:----------");
    
    //避免影响后面打印结果
    [NSThread sleepForTimeInterval:5];
    NSLog(@" ");
    
    //上面的堵塞只能达到队列时间里面不包含异步时间时的堵塞,如果队列事件里面如果还b还包含异步时间的时候,上面的方法就不起作用了
    //必须使用dispatch_group_enterdispatch_group_leave
    dispatch_group_enter(group);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self assistFunc:^{
            NSLog(@"enter:执行完事件1");
            dispatch_group_leave(group);
        }];
    });
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    NSLog(@"事件1之后的代码");
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"enter:执行完事件2");
    });
    
}

///group_enter 是否影响整个全局队列的测试
- (void)group_enter_global_queue {
     dispatch_group_t group = dispatch_group_create();
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_group_enter(group);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [self assistFunc:^{
                NSLog(@"enter:执行完事件1");
                dispatch_group_leave(group);
            }];
        });
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        NSLog(@"事件1之后的代码");
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"enter:执行完事件2");
        });
    });
    [NSThread sleepForTimeInterval:1];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        NSLog(@"group_enter 添加wait的 操作的并行队列执行");
    });
    
    [NSThread sleepForTimeInterval:1];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"group_enter 操作的并行队列执行");
    });
}


- (void)assistFunc:(void(^)(void))block {
    //模拟网络请求
    [NSThread sleepForTimeInterval:3];
    block();
}

//7.获取队列标签(名称)
- (void)getQueueLable {
    dispatch_queue_t serialQueue = dispatch_queue_create(serialQueueName, DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(serialQueue, ^{
        NSLog(@"queue lable = %s", dispatch_queue_get_label(serialQueue));
    });
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
    });
}

//8.dispatch_set_target_queue 设置目标队列
- (void)setTargetQueue {
    //设置目标队列,获取目标队列的优先级
    dispatch_queue_t queue1 = dispatch_queue_create("com.queue.one", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue2 = dispatch_queue_create("com.queue.two", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue1, ^{
        NSLog(@"com.queue.one event run!");
    });
    
    dispatch_async(queue2, ^{
        NSLog(@"com.queue.two event run!");
    });
    
    dispatch_set_target_queue(queue1, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0));
    
    dispatch_async(queue1, ^{
        NSLog(@"target com.queue.one event run!");
    });
    
    dispatch_async(queue2, ^{
        NSLog(@"target com.queue.two event run!");
    });
    //避免影响后面打印结果
    [NSThread sleepForTimeInterval:3];
    NSLog(@"   ");
    //设置执行阶层
    dispatch_queue_t queue3 = dispatch_queue_create("com.queue.3", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue4 = dispatch_queue_create("com.queue.4", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue5 = dispatch_queue_create("com.queue.5", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue6 = dispatch_queue_create("com.queue.6", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue7 = dispatch_queue_create("com.queue.7", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue3, ^{
        NSLog(@"com.queue.3 event run!");
    });
    dispatch_async(queue4, ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"com.queue.4 event run!");
    });
    dispatch_async(queue5, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"com.queue.5 event run!");
    });
    dispatch_async(queue6, ^{
        NSLog(@"com.queue.6 event run!");
    });
    dispatch_async(queue7, ^{
        NSLog(@"com.queue.7 event run!");
    });
    
    //避免影响后面打印结果
    [NSThread sleepForTimeInterval:5];
    NSLog(@"   ");
    //设置执行阶层后会使队列串行执行
    dispatch_queue_t target = dispatch_queue_create("com.queue.target", DISPATCH_QUEUE_SERIAL);
    dispatch_set_target_queue(queue3, target);
    dispatch_set_target_queue(queue4, target);
    dispatch_set_target_queue(queue5, target);
    dispatch_set_target_queue(queue6, target);
    dispatch_set_target_queue(queue7, target);
    
    dispatch_async(queue3, ^{
        NSLog(@"target com.queue.3 event run!");
        NSLog(@"%s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
    });
    dispatch_async(queue4, ^{
        NSLog(@"target com.queue.4 event run!");
    });
    dispatch_async(queue5, ^{
        NSLog(@"target com.queue.5 event run!");
        NSLog(@"%s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
    });
    dispatch_async(queue6, ^{
        NSLog(@"target com.queue.6 event run!");
    });
    dispatch_async(queue7, ^{
        NSLog(@"target com.queue.7 event run!");
    });
    dispatch_async(queue3, ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"sleep target com.queue.3 event run!");
    });
    
}

//9.dispatch_Timer
static dispatch_source_t timer;//此处必须使用一个全局或者对象持有的timer 不能用局部变量,不然会被释放掉.
- (void)gcdTimer {
    //获取全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    //创建timer
   timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //设置首次执行事件、执行间隔和精确度
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC), 1*NSEC_PER_SEC, 0);// 最后一个参数是容忍的精度误差
    
    //设置timer事件
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"GCD timer running");
    });
    
    //启动timer
    dispatch_resume(timer);
    
    [NSThread sleepForTimeInterval:6];
    
    //关闭timer
    dispatch_cancel(timer);
    
    //还有一个dispatch_time_t dispatch_walltime(const struct timespec *_Nullable when, int64_t delta);第一个参数是用于指定一个时间点,如2019年6月11日9点10分10秒,然后按照后面传入多长在事件进行执行. 注意 int64_t delta是纳秒,如果传入1就是一纳秒,想要传入一秒应该是1*NSEC_PER_SEC;
}

//10.GCD 延时执行功能,线程从主线程延时操作 打印可以看出,dispatch_after是延时添加到队列,并不是直接添加到队列延时执行
- (void)delayAddToQueue {
    
    NSLog(@"延时添加");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"主线程延时加到队列 ");
    });
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW , 5*NSEC_PER_SEC),dispatch_get_global_queue(0,0),^{
        NSLog(@"五秒后添加到队列中");
    });
    
    //耗时操作
    NSLog(@"主线程第一个耗时操作");
    for (long long i = 0; i < 3000000000; i++) {
        int k = 0;
        k++;
    }
    NSLog(@"主线程第二个耗时操作");
    for (long long i = 0; i < 3000000000; i++) {
        int k = 0;
        k++;
    }
//    2019-06-20 11:26:50.538242+0800 Blog[24192:1246838] 延时添加
//    2019-06-20 11:26:50.538488+0800 Blog[24192:1246838] 主线程第一个耗时操作
//    2019-06-20 11:26:56.036523+0800 Blog[24192:1246931] 五秒后添加到队列中
//    2019-06-20 11:26:57.481526+0800 Blog[24192:1246838] 主线程第二个耗时操作
//    2019-06-20 11:27:04.466338+0800 Blog[24192:1246838] 主线程延时加到队列
}


//11.GCD连续迭代 dispatch_apply 是线程堵塞的
- (void)subsequentIteration {
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        [NSThread sleepForTimeInterval:1];
        NSLog(@"NSTread globla------------");
    });
    
    dispatch_queue_t queue = dispatch_queue_create("com.qu.cn", DISPATCH_QUEUE_CONCURRENT);
    dispatch_apply(10, queue, ^(size_t index){
        [NSThread sleepForTimeInterval:1];
        NSLog(@"run in thread = %@", [NSThread currentThread]);
    });
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        NSLog(@"NSTread globla2------------");
    });
    
    
}

//12.dispatch_once 只执行一次
- (void)runOnlyOnce {
    for (int i = 0 ; i < 10; i++) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            NSLog(@"----------onceToken---------");
        });
    }
    //dispatch_once_t 嵌套调用会造成死锁的问题, 其内部时间block内代码并不是只被添加了一次.
}

//13.队列暂停和开启
- (void)queueSuspendAndResume {
    dispatch_queue_t queue = dispatch_queue_create("com.queue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_suspend(queue);
    dispatch_async(queue, ^{
        NSLog(@"queue event one ");
    });
    dispatch_async(queue, ^{
        NSLog(@"queue event two ");
    });
    dispatch_async(queue, ^{
        NSLog(@"queue event three ");
    });
    NSLog(@"----------------------");
    dispatch_resume(queue);
    
    [NSThread sleepForTimeInterval:3];
    
    dispatch_queue_t queue1 = dispatch_get_global_queue(0, 0);
    dispatch_suspend(queue1);
    dispatch_async(queue1, ^{
        NSLog(@"queue1 event one ");
    });
    dispatch_async(queue1, ^{
        NSLog(@"queue1 event two ");
    });
    dispatch_async(queue1, ^{
        NSLog(@"queue1 event three ");
    });
    NSLog(@"----------------------");
    dispatch_resume(queue1);
}

@end


