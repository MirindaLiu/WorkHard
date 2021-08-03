//
//  RuntimeIn.m
//  Blog
//
//  Created by Mirinda on 2019/5/23.
//  Copyright © 2019 Mirinda. All rights reserved.
//

#import "RuntimeIn.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "RPerson.h"
#import "RDog.h"
#import "RDogErHa.h"
typedef void(*same_msgSend)(id, SEL ,NSString*);

@interface RuntimeIn()
{
    RPerson *Per;
}
+ (void)messageRun:(NSString*)str;
- (void)runMessage:(NSString*)str;
@property(nonatomic, strong) NSString *test;


@end

@implementation RuntimeIn
- (void)runtimeIn {
    
    //替换方法实现
//    [self changeIMP];
//    [self exchangeMethod];
//    [self runCheckMethodByExchange];
//    [self msgSendCallMethod];
//    [self changClassoOfObj];
//    [self classRelation];
    //下面是消息转发相关
//    [RuntimeIn messageRun:@"没有实现的函数"];
//    [self runMessage:@"没有实现的函数"];
//    Per =  [RPerson new];
//    [self performSelector:@selector(walk)];
    //消息转发 end
    self.test = @"qqqq";
    
}

void changeMeToRun() {
    NSLog(@"Run method: %s", __func__);
}
//runtime 的动态体现 调用person的walk方法时 执行一个其他方法
- (void)changeIMP {
    RPerson *person = [RPerson new];
    Method walk = class_getInstanceMethod([RPerson class], @selector(walk));
    method_setImplementation(walk, (IMP)changeMeToRun);
    [person walk];
}

//交换两个已经存在的方法
- (void)exchangeMethod {
    Method walk = class_getInstanceMethod([RPerson class], @selector(walk));
    Method eat = class_getInstanceMethod([RPerson class], @selector(eat));
    method_exchangeImplementations(walk, eat);
    [[RPerson new]walk];
}

void methodExchange(Class aClass, SEL orig_sel, SEL alt_sel)
{
    Method orig_method = nil, alt_method = nil;
    orig_method = class_getInstanceMethod(aClass, orig_sel);//从指定类中获取指定方法
    alt_method = class_getInstanceMethod(aClass, alt_sel);
    if ((orig_method != nil) && (alt_method != nil))
    {
        IMP originIMP = method_getImplementation(orig_method);//获取方法指针
        IMP altIMP = method_setImplementation(alt_method, originIMP);//重新设置方法指针，并返回方法之前的指针
        method_setImplementation(orig_method, altIMP);
    }
}

//执行反方法被置换
- (void)runCheckMethodByExchange {
        Method changeIMP = class_getInstanceMethod([self class], @selector(changeIMP));
        Method checkMethodByExchange = class_getInstanceMethod([self class], @selector(checkMethodByExchange));
        method_exchangeImplementations(changeIMP, checkMethodByExchange);
        [self changeIMP];
}

//反方法被置换
- (void)checkMethodByExchange {
    NSString *funcName  = [NSString stringWithUTF8String:__func__];
    NSString *calledMethodName = [NSString stringWithFormat:@"-[%@ %@]",[self class],NSStringFromSelector(_cmd)];
    if (![funcName isEqualToString:calledMethodName]) {
        NSLog(@"method by changed, NO run");
        return;
    }
    NSLog(@"method runing");
}

//对象转化类类型(A类的对象转成对象)
- (void)changClassoOfObj {
    RPerson *p = [RPerson new];
    NSLog(@"p is class: %@",object_getClass(p));
    Class pp = object_setClass(p, [RDog class]);
    [p walk];
    
    NSLog(@"pp is person: %@",pp);
}
//SEL 是为函数生成的一个唯一ID 最为标记,IMP 是函数实现
//类关系
- (void)classRelation {
    NSLog(@"ErHa 对象:%@",[RDogErHa new]);
    NSLog(@"ErHa 类对象:%p",[RDogErHa class]);
    NSLog(@"ErHa 元类对象:%p",object_getClass([RDogErHa class]));
    NSLog(@"ErHa 类对象superclass:%p",[[RDogErHa class]superclass]);
    NSLog(@"ErHa 元类对象superclass:%p",[object_getClass([RDogErHa class]) superclass]);
    NSLog(@"dog 对象:%@",[RDog new]);
    NSLog(@"dog 类对象:%p",[RDog class]);
    NSLog(@"dog 元类对象:%p",object_getClass([RDog class]));
    NSLog(@"dog 类对象superclass:%p",[[RDog class] superclass]);
    NSLog(@"dog 元类对象superclass:%p",[object_getClass([RDog class])superclass]);
    NSLog(@"NSObject 对象:%@",[NSObject new]);
    NSLog(@"NSObject 类对象:%p",[NSObject class]);
    NSLog(@"NSObject 元类对象:%p",object_getClass([NSObject class]));
    NSLog(@"NSObject 类对象superclass:%p",[[NSObject class] superclass]);
    NSLog(@"NSObject 元类对象superclass:%p",[object_getClass([NSObject class])superclass]);
}

//消息转发
//1.函数调用的底层实现 用clang命令协助查看 系统是怎么调用的  命令: clang -rewrite-objc xxx.m 会生成 一个xxx.cpp 从xxx.cpp里查看
// 函数调用的底层函数是 : ((void (*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("RPerson"), sel_registerName("walk"));

- (void)msgSendCallMethod {
    //调用RPerson的sleep函数
    ((void (*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("RPerson"), sel_registerName("sleep"));
    // ((void (*)(id, SEL))(void *)objc_msgSend) 中的 void (*)(id, SEL))(void *) 是对objc_msgSend函数做严格类型匹配, 例如下面不匹配类型的objc_msgSend函数就会报错
    // ((void (*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("RPerson"), sel_registerName("sleep"),6);
    
    //如果去工程 building Setting  关闭 msgSend的类型检查(Enable Strict Checking of objc_msgSend Calls 置为NO) 就不应写前面的(void (*)(id, SEL))(void *),多传入参数也不会报警告,运行时会找不到方法崩溃,就可以如下调用:.
    objc_msgSend(objc_getClass("RPerson"), sel_registerName("sleep"));
    
//    objc_msgSend(objc_getClass("RPerson"), sel_registerName("sleep"),@"100",10); 不crash,说明后面多余的参数是不会影响的.
//    objc_msgSend(objc_getClass("RPerson"), sel_registerName("sleep:"),@"100",10); 会crash 因为找不到对应的函数实现

    //调用实例的方法
        ((void (*)(id, SEL))(void *)objc_msgSend)((id)((RPerson *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("RPerson"), sel_registerName("new")), sel_registerName("walk"));
    //去掉类型检查
    objc_msgSend(objc_msgSend(objc_getClass("RPerson"), sel_registerName("new")), sel_registerName("walk"));
    
    //调用带参数的实例的方法
    ((void (*)(id, SEL ,NSString*))(void *)objc_msgSend)((id)((RPerson *(*)(id, SEL))(void *)objc_msgSend)((id)objc_getClass("RPerson"), sel_registerName("new")), sel_registerName("drink:"), @"water");
    //去掉类型检查
//    objc_msgSend(objc_msgSend(objc_getClass("RPerson"), sel_registerName("new")), sel_registerName("drink:"), @"water"); //这样会崩溃,暂时不知道原因 而下面这种调用不会, 可能sel_registerName("drink:")导致的,但是如果先调用上面的带类型检查的magSend 在调用下面的也会崩溃.
    
//    objc_msgSend(objc_msgSend(objc_getClass("RPerson"), sel_registerName("new")), @selector(drink:), @"water");
    
    //上面直接使用objc_msgSend 发送带参数的方法出错的原因是:随着64位操作系统的出现runtime出现了历史变更，objc_msgSend也出现了变化。所谓老版本也就是苹果在未推出新版runtime之前，此时可以肆意的使用objc_msgSend()函数，系统中就默认许可了这样函数的存在,看系统API发现只剩下一个不带参数的objc_msgSend函数，objc_msgSend不带参数我用它干什么，但我们知道这个函数是关键不可能不能调用。于是发现将这个函数看成c语言的函数声明就可以通过强制转化解决这个问题，比如这样((void ()(id, SEL , NSString))objc_msgSend)((id)p, @selector(setName:),@"33")；返回结构体时，不能使用objc_msgSend，而是要使用objc_msgSend_stret，否则会crash  用objc_msgSend_stret 来发送返回值类型为结构体的消息，使用objc_msgSend_fpret 来发送返回值类型为浮点类型的消息，而又在一些处理器上，还得使用objc_msgSend_fp2ret 来发送返回值类型为浮点类型的消息。
    //头部就是将这个函数转化成了合适的函数指针即((void ()(id, SEL , NSString))，不清楚可以Google函数指针，这样就可以解决掉不能调用objc_msgSend函数问题，其它变更后续更新！
    
    //如果是大量调用可以使用下面的方式
    same_msgSend myMsgSend = (same_msgSend)objc_msgSend;
 myMsgSend(objc_msgSend((id)objc_getClass("RPerson"),sel_registerName("new")),sel_registerName("drink:"), @"water");
}
//objc_msgSend 的汇编代码研究暂时跳过

// 消息转发相关:系统会提供三次补救的机会

//机会一: 可以重新对类方法进行绑定(动态方法解析)
void myMessage(id self, SEL _cmd, NSString* message) {
    NSLog(@"message = %@", message);
}
+ (BOOL)resolveClassMethod:(SEL)sel {
    if (sel == @selector(messageRun:)) {
        class_addMethod(object_getClass([self class]), sel, (IMP)myMessage, "v@:@");
        return YES;
    }
    return [super resolveClassMethod:sel];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(runMessage:)) {
        //这里必须用添加方法的方式解决,如果不添加一个方法的话,还会进入下面的函数继续走消息传递,测出不用给sel 添加函数实现的方式 因为
        class_addMethod([self class], sel, (IMP)myMessage, "v@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

//机会二:可以修改类对象(快速消息转发)
- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(runMessage:)) {
        return [RPerson new];
    }
    return [super forwardingTargetForSelector:aSelector];
}

//机会三:(标准消息转发)第一个要求返回一个方法签名，第二个方法转发具体的实现。二者相互依赖，只有返回了正确的方法签名，才会执行第二个方法。这次的转发作用和第二次的比较类似，都是将 A 类的某个方法，转发到 B 类的实现中去。不同的是，第三次的转发相对于第二次更加灵活，forwardingTargetForSelector: 只能固定的转发到一个对象；forwardInvocation:  可以让我们转发到多个对象中去
//快速消息转发：简单、快速、但仅能转发给一个对象。
//标准消息转发：稍复杂、较慢、但转发操作实现可控，可以实现多对象转发
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature * sig = [super methodSignatureForSelector:aSelector];
    if (!sig) {
        sig = [Per methodSignatureForSelector:aSelector];
    }
    return sig;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([Per respondsToSelector:[anInvocation selector]]) {
        [anInvocation invokeWithTarget:Per];
        [anInvocation invokeWithTarget:[RDog new]];
    }else {
        [super forwardInvocation:anInvocation];
    }
    
}

//IMP impOfCallingMethod(id lookupObject, SEL selector){
//    NSUInteger returnAddress = (NSUInteger)__builtin_return_address(0);
//    NSUInteger closest = 0;
//    // Iterate over the class and all superclasses
//    Class currentClass = object_getClass(lookupObject);
//    while (currentClass) {
//        // Iterate over all instance methods for this class
//        unsigned int methodCount;
//        Method *methodList = class_copyMethodList(currentClass, &methodCount);
//        unsigned int i;
//        for (i = 0; i < methodCount; i++) {
//        // Ignore methods with different selectors
//            if (method_getName(methodList[i]) != selector) {
//                continue;
//             }
//            // If this address is closer, use it instead
//            NSUInteger address = (NSUInteger)method_getImplementation(methodList[i]);
//            if (address < returnAddress && address > closest){
//                closest = address;
//            }
//        }
//        free(methodList);
//        currentClass = class_getSuperclass(currentClass);
//   }
//   return (IMP)closest;
//
//}

@end
