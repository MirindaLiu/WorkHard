//
//  ViewController.m
//  Blog
//
//  Created by Mirinda on 17/2/12.
//  Copyright © 2017年 Mirinda. All rights reserved.
//

#import "ViewController.h"
#import "Lock_NSLock.h"
#import "CallModel_CallBack.h"
#import "Lock_NSCondition.h"
#import "Lock_NSConditionLock.h"
#import "Lock_NSRecursiveLock.h"
#import "Lock_OSSpinLock.h"
#import "sort.h"
#import <objc/runtime.h>
#import "NSSessionDownLoad.h"
#import "ObjToLocal.h"
#import "JsonToNull.h"
#import "useBlock.h"
#import "runloopCheck.h"
#import "Aggregate.h"
#import "runloopQueue.h"
#import "AggregateFour.h"
#import "fishhook.h"
#import "RuntimeIn.h"
#import "FirstLook.h"
//#import "String.h"
#import "GCDInto.h"
#import "BitOperation.h"
#import "Link.h"
#import "stack.h"
#import "queue.h"
#import "Sort.h"
#import "BinarySearch.h"
#import "SkipList.h"
#import "BinarySearchTree.h"
#import "Heap.h"
#import "stringSearch.h"
#define about_child_description  @"aboutChildDescription"

//#define imageName(name)     @"image/"name@".jpg"
@interface ViewController ()
@property (nonatomic, strong)runloopCheck *loop;


@end


@implementation ViewController

int av_strstart(const char *str, const char *pfx, const char **ptr ) {
  int i = 0;
  bool ispfx = true;
  while ('\0' != pfx[i] && '\0' != str[i]){
    if (str[i] != pfx[i]){
      ispfx = false;
      break;
    }
    i++;
  }
  
  if (ispfx) {
    const char* addr = &(str[i]);
    ptr = &addr;
  }
  return ispfx ? 1 : 0;
  
}
- (void)viewDidAppear:(BOOL)animated {
//    NSLog(@"viewDidAppear-------------------");
}
//+ (void)setIsChildDirected:(BOOL)child {
//   NSString *state = @"NO";
//  if (child) state = @"YES";
//  dispatch_async(dispatch_get_global_queue(0, 0), ^{
//    if (child) {
//      NSLog(@"-------------------------------YES");
//    }else {
//      NSLog(@"-------------------------------NO");
//    }
//  });
//}
//static NSString *child = nil;
//+ (NSString *)getChildDescription {
//if(!child){
//   NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//  [defaults setObject:@"NO" forKey:about_child_description];
//   child = [defaults valueForKey:about_child_description];
//  }
//   return child == nil ? @"NO" : child;
//}

- (void)viewDidLoad
{
#ifdef DEBUG
    NSLog(@"-------------------------------YES");
#else
    NSLog(@"-------------------------------NO");
#endif
  const char *a;
  int k = av_strstart("12345","123",&a);
//  [ViewController setIsChildDirected:YES];
//  [NSThread sleepForTimeInterval:1];
//  [ViewController setIsChildDirected:YES];
//  [NSThread sleepForTimeInterval:1];
//  [ViewController setIsChildDirected:NO];
    [super viewDidLoad];
//  NSDictionary *dic = ({
//    NSMutableDictionary * params = [NSMutableDictionary dictionary];
//    for (int i = 0; i<10; i++) {
//      [params setObject:[NSString stringWithFormat:@"%d",i] forKey:[NSString stringWithFormat:@"%d",i]];
//    }
//    params;
//  });
//  NSDictionary *dic1 = @{@"1":@"1",@"10":@"10",@"100":@"100"};
//  int k = 0;
    //geek ------
//    Link *link = [Link new];
//    [link linkInto];
//    stack* s = [stack new];
//    [s stackInto];
//    queue *q = [queue new];
//    [q queueInto];
//    Sort *sort= [Sort new];
//    [sort sortInto];
//    BinarySearch *bs = [BinarySearch new];
//    [bs BSearchInto];
//    SkipList *sl = [SkipList new];
//    [sl skipListInto];
//  BinarySearchTree *tree = [BinarySearchTree new];
//  [tree BSTInto];
//  Heap *heap = [Heap new];
//  [heap HeapInto];
  
  
  
  stringSearch *str = [stringSearch new];
  [str strInto];
  
    //geek end ------
    //GCD------------------------------------------------------------------------
//    GCDInto *gcd = [[GCDInto alloc]init];
//    [gcd GCDEntrance];
    //GCD end--------------------------------------------------------------------
    //TZRuntime------------------------------------------------------------------
//    RuntimeIn *ri = [RuntimeIn new];
//    [ri runtimeIn];
//    NSLog(@"test = %@",ri.test);
    //TZRuntime End--------------------------------------------------------------
    
    //FristLook-----------------------
//    FirstLook *look = [[FirstLook alloc]init];
//    [look excuteMethod];
    //FristLook End----------------
    //string------------------------
//    String * str = [[String alloc]init];
//    [str stringInto];
    //string end--------------------
    //bit operation--------------------------------
//    BitOperation *bit = [[BitOperation alloc]init];
//    [bit bitInto];
    //bit operation end----------------------------
//    self.view.backgroundColor = [UIColor yellowColor];
//    [self fishTest];
//    NSString *str = [[NSString alloc]initWithFormat:nil arguments:nil];
//    if (@available(iOS 11.0, *)) {
//        UIEdgeInsets a = self.view.safeAreaInsets;
//        NSLog(@"%f,  %f, %f, %f",a.top, a.bottom, a.left, a.right);
//    }
    //Aggregate
//    Aggregate* agg =  [[Aggregate alloc]init];
//    [agg excuteMethod];
    
    
    //AggregateFour
//    [AggregateFour excuteMethod];
//    for (int i = 0; i< 10 ; i++) {
//        uint32_t a = arc4random()%10;
//        sleep(a);
//        [runloopQueue setTaskToQueue:^{
//            NSLog(@"执行第%d个任务",i+1);
//        }];
//    }
    
    
//    useBlock* use = [[useBlock alloc]init];
//    use.eat(10).look(100);
//    NSArray* array1 = [NSArray array];
//    NSString* a = array1.firstObject;
    
//    NSString* str = imageName(@"999999");
//    NSLog(@"-----:%@:-------",str);
//    //序列化反序列化
//    ObjToLocal* obj = [ObjToLocal alloc];
//    [obj encodeArr];
//    //[obj decodeArr];
//    //end
    
/*    id nu = [JsonToNull backNullObj];
    if ([nu isKindOfClass:[NSNull null]])
    {
        NSLog(@"back NSNull");
    }
 */
    
    
    //DownLoad Url
//    NSSessionDownLoad* down = [[NSSessionDownLoad alloc]init];
//    [down downLoadFileWithUrl:@"http://pan1.9duli.com/dl.php?YzEwOC9EMVhPRU5MRWFYa2xFU0pXcUt3MHRnYWE5dGF0bFAvZW5aZnlId0JGM3lqZStSemc4RHR2WWhFclNoOFJvTU82dzZHOS9zNWtaZUlKL012U0xRMnV5OFFva01wcnBpWG9qTGxEbSttdGVuYWYxUGpxOGd0VnJXdFRBSU9oK3hONGZLaFpWT2lPUTBQdXNJdXFHejczVEl5OVh1ZHNReEtWNldRMTkzNGd0VFdETUs4R1g5TStHNk1tZE9ZSTN0dHhROEVCaFlGQ2s0OVQ3NkF3NklZYk0xOW1WblBrTWFtcWJSSFY2SFU%3D"];
    
    //取手机里安装的应用
    //Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    //NSObject *workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
    //NSLog(@"apps: %@", [workspace performSelector:@selector(allApplications)]);
    //end
    
    
    //排序
//    NSArray* arr = @[@10,@16,@100,@90,@1,@6,@30,@19,@99,@19,@26];
//    sort* insert = [[sort alloc]init];
    //NSLog(@"Sort Arr:%@ ",[insert insertSort:arr]);
    
//    NSMutableArray* array = [NSMutableArray arrayWithArray:arr];
    //[insert shellInsertSort:array];
    //[insert selectSort:array];
    //[insert twoEndsSelectSort:array];
//    [insert heapSort:array];
    //[insert bubbleSortTwo:array];
//    [insert quicklySort:array low:0 high:(int)array.count - 1];
    ;
//    NSLog(@"shell sort array: %@",[insert mergeSort:array]);
    //排序end
    
    
    
    
    //锁和多线程
    //[[[Lock_NSCondition alloc]init]useNSCondition];
    //[[[Lock_NSConditionLock alloc]init]useNSConditionLock];
    //[[[Lock_NSRecursiveLock alloc]init]useNSRecursiveLock];
    //[[[Lock_OSSpinLock alloc]init] useOSSpinLock];
    
    
    //dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    //dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    //NSMutableArray *array = [NSMutableArray array];
    
    //for (int index = 0; index < 10; index++) {
        
    //    dispatch_async(queue, ^(){
            
    //        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);//
            
    //        NSLog(@"addd :%d", index);
            
    //        [array addObject:[NSNumber numberWithInt:index]];
            
    //        dispatch_semaphore_signal(semaphore);
            
    //    });
        
    //}
//    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
//    for (int i = 0; i<20; i++)
//    {
////        dispatch_semaphore_signal(sem);
//        NSLog(@"111111111111111");
//    }
//    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
//    NSLog(@"1111111111111112");
/*    for (int j = 0; j < 3; j ++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            for (int i = 0; i<20; i++)
            {
                NSLog(@"循环开始%d %d",j,i);
                dispatch_semaphore_t sem = dispatch_semaphore_create(0);
               // dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    int k = 0;
                    k++;
                    //sleep(3);
                    NSLog(@"发信号量%d,%d",j,i);
                    dispatch_semaphore_signal(sem);
                //});
                dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
                NSLog(@"循环结束%d %d",j,i);
                NSLog(@"----------------");
            }
        });
    }
    
    return;
 */
    
    // Do any additional setup after loading the view, typically from a nib.
//    CallModel_CallBack* call = [[CallModel_CallBack alloc]init];
//    [call callStart];
//    
//    //Lock_NSLock* lock = [[Lock_NSLock alloc]init];
//    //[lock userNSLock];
//end
//}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self.loop doSomeThingInThread];
//
//
//
////    def myPow(self,x,n):
////    if n < 0:
////        x = 1/X
////        n=-n
////        pow =1
////        while n:
////            if n&1:
////                pow *= X
////                x* =x;
////                n>>1;
////    return pow;
//    //测试
//    //#define registerString              @"334fff9cfc0e777d233b40e3634c30231b3b0806fd458304cabe56c6a95299c1129e8542735d56cc9fbdb7537b40cd6e"
//    //#define unRegisterString            @"9cbe1e6ba9a9c01d8eaf74e43a5647118228689c688fae32c57e44789cc88e7e595368d574e8ac7e9c8cdcde3e7921515690b1844104ae3b6343a26719fcd7c4"
//    //#define registeClass                @"b286dc2b3bd310497e485b98b32c6b76feee73a8d0d7b4c37b7c8ce34357ef0732d80d2b173f800f3ee152ed3ee80f87"
////    NSData *data = [@"registerSchemeForCustomProtocol:" dataUsingEncoding:NSUTF8StringEncoding];
////    NSLog(@"register = %@",[[data CTAES256Encrypt]CTConvertDataToHexStr]);
////    data = [@"unregisterSchemeForCustomProtocol:" dataUsingEncoding:NSUTF8StringEncoding];
////    NSLog(@"unregister = %@",[[data CTAES256Encrypt]CTConvertDataToHexStr]);
////    data = [@"browsingContextController" dataUsingEncoding:NSUTF8StringEncoding];
////    NSLog(@"calss = %@",[[data CTAES256Encrypt]CTConvertDataToHexStr]);
////    //
////    ;
////    NSLog(@"register back = %@",   [[NSString alloc] initWithData:[[NSData CTConvertHexStrToData:registerString] CTAES256Decrypt] encoding:NSUTF8StringEncoding]);
////    NSLog(@"unregister back = %@",[[NSString alloc] initWithData:[[NSData CTConvertHexStrToData:unRegisterString] CTAES256Decrypt] encoding:NSUTF8StringEncoding]);
////    NSLog(@"class back = %@",[[NSString alloc] initWithData:[[NSData CTConvertHexStrToData:registeClass] CTAES256Decrypt] encoding:NSUTF8StringEncoding]);
//
}

- (void)fishTest {
    NSLog(@"bind");
    struct rebinding NSLogRebind;
    NSLogRebind.name = "NSLog";
    NSLogRebind.replacement = bindNSLog;
    NSLogRebind.replaced = (void *)&old_nslog;
    
    struct rebinding binds[] ={NSLogRebind};
    rebind_symbols(binds, 1);
}

//函数指针，用来保存原始的函数地址
static void (*old_nslog)(NSString *format, ...);

void bindNSLog(NSString *format, ...){
    
//    old_nslog(@"执行了bindNSLog");
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"点击屏幕");
}


- (void)viewSafeAreaInsetsDidChange {
//    [super viewSafeAreaInsetsDidChange];
//
//    NSLog(@"viewSafeAreaInsetsDidChange-%@",NSStringFromUIEdgeInsets(self.view.safeAreaInsets));
//
//    [self updateOrientation];
}

- (void)updateOrientation {
//    if (@available(iOS 11.0, *)) {
//        UIView *view = [[UIView alloc]init];
//        CGRect frame = self.view.frame;
//        //        frame.origin.x = self.view.safeAreaInsets.left;
//        frame.origin.y = self.view.safeAreaInsets.top;
//        //        frame.size.width = self.view.frame.size.width - self.view.safeAreaInsets.left - self.view.safeAreaInsets.right;
//        frame.size.height = self.view.frame.size.height - self.view.safeAreaInsets.bottom - self.view.safeAreaInsets.top;
//        view.frame = frame;
//        [self.view addSubview:view];
//        view.backgroundColor = [UIColor blueColor];
//    } else {
//        // Fallback on earlier versions
//    }
}





//- (void)viewDidAppear:(BOOL)animated {
//    UIView *a = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    UIView *b = [[UIView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
//    [b addSubview:a];
//    [self.view addSubview:b];
//    if (a.window.keyWindow) {
//        NSLog(@"------------------------");
//    }
//    self.view.backgroundColor = [UIColor yellowColor];
////    UIEdgeInsets a = self.view.safeAreaInsets;
////
////    int k = 0;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


