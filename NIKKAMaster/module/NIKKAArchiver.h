


/*
 
 iOS学习笔记系列 - OC如何正确重写copyWithZone
 144  作者 Ryan王 关注
 2017.04.03 17:46* 字数 402 阅读 125评论 1喜欢 0
 今日碰到一个很有意思的问题：OC如何重写（override）
 
 - (id)copyWithZone:(NSZone *)zone
 （P.S. 对原因不感兴趣的读者可以直接跳到文章最后看正确实现方法。）
 
 1. 问题
 
 举个栗子：
 TL;DR
 简单来说我们有Person，Student两个类，其中后者是前者的子类，都需要实现NSCopying。
 
 @interface Person : NSObject <NSCopying>
 @property (nonatomic, strong) NSString *userId;
 @end
 
 @implementation Person
 - (id)copyWithZone:(NSZone *)zone
 {
 Person *p = [[Person alloc] init];
 p.userId = self.userId;
 return p;
 }
 @end
 
 @interface Student : Person <NSCopying>
 @property (nonatomic, strong) NSString *studentId;
 @end
 2. 错误实现
 
 大部分人首先想到的实现会是下面这样的：
 
 @implementation Student
 - (id)copyWithZone:(NSZone *)zone
 {
 Student *s = [super copyWithZone:zone];
 s.studentId = self.studentId;
 return s;
 }
 @end
 但如果此时运行代码，Runtime将会报错：
 Unrecognized selector setStudentId sent to instance xxx ...
 
 问题出在哪里了呢？
 
 这里：Student *s = [super copyWithZone:zone];
 
 由于右边的返回值是一个父类Person的实例，s便不是Student。所以当调用 s.studentId = self.studentId这个setter时，便返回了以上错误。
 
 3. 正解
 
 理解了上面的错误之后，正确的解法应该是让[super copyWithZone:zone]返回一个Student实例。如下：
 
 @implementation Person
 - (id)copyWithZone:(NSZone *)zone
 {
 Person *p = [[[self class] alloc] init]; // <== 注意这里
 p.userId = self.userId;
 return p;
 }
 @end
 
 @implementation Student
 - (id)copyWithZone:(NSZone *)zone
 {
 Student *s = [super copyWithZone:zone];
 s.studentId = self.studentId;
 return s;
 }
 @end
 4. 讨论
 
 这个问题的根源在于对OC Runtime的理解不深，是个从其他OO编程语言过来的程序员常踩的坑。而且由于修正的地方在父类，一旦父类的源码不能或者很难被更改时，将会对子类造成很大的限制。其实要怪只能怪OC，OC这个语言本身对inheritance支持就很鸡肋。。。想要了解更多关于OC语言设计的读者，可以直接搜OC动态语言或者OC Runtime相关的文章，笔者就不赘述了。
 
 */



/*
 使用方法
 
 NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"NIKKA.archiver"];
 BOOL success = [NSKeyedArchiver archiveRootObject:archiver toFile:path];
 if (success) {
 NSLog(@"archiver success");
 }
 
 NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"NIKKA.archiver"];
 NIKKAArchiver *person = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
 NSLog(@"nikka archiver:%@",person);
 
 */
#import <Foundation/Foundation.h>
@class ArTest;


static NSString *archiver_path = @"";

@interface NIKKAArchiver : NSObject<NSCoding>

//@property (nonatomic, assign) int age;
//
//@property (nonatomic, copy) NSString *name;
//
//@property (nonatomic, copy) NSString *device;
//
//@property (nonatomic,strong) ArTest *test;


//用户总数
@property (nonatomic,strong) NSDictionary *userCounts;

//剩余积分总数
@property (nonatomic,strong) NSDictionary *points;

//当天用户登录数量
@property (nonatomic,strong) NSDictionary *dayLogins;

//当月用户登录数量
@property (nonatomic,strong) NSDictionary *monthLogins;

- (BOOL)archiver;
+ (NIKKAArchiver *)unarchiver;

@end

@interface BaseArchiver : NSObject<NSCopying>

@end

@interface ArTest : BaseArchiver<NSCoding>

@property (nonatomic,copy) NSString *arTest;
@end
