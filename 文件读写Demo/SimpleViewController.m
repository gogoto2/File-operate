//
//  SimpleViewController.m
//  文件读写Demo
//
//  Created by 孙云飞 on 2017/9/4.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "SimpleViewController.h"

@interface SimpleViewController ()
- (IBAction)clickOneBtn:(id)sender;
- (IBAction)clicktwoBtn:(id)sender;
- (IBAction)clickThreeBtn:(id)sender;
- (IBAction)clickFoureBtn:(id)sender;
- (IBAction)clickFiveBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageShow;

@end

@implementation SimpleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//字符串读写
- (IBAction)clickOneBtn:(id)sender {
    
    //1 首先找到需要存放的位置
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"test1.txt"];//此时文件存在路径，但是文件没有真实存在
    //2 写入字符串
    NSString *testStr = @"我是测试的字符串";
    
    //3 字符串写入
    [testStr writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"文件路径:%@",path);
    
    //4 读取字符串
    NSString *resultStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"读取到的字符串---%@",resultStr);
    
    
    /**********数组读写***********/
    //1 存储位置
    NSString *path2 = [NSHomeDirectory() stringByAppendingPathComponent:@"array1.txt"];
    //2 写入数组
    NSArray *array1 = @[@"张三",@"历史",@"万物"];
    [array1 writeToFile:path2 atomically:YES];
    NSLog(@"文件路径-%@",path2);
    
    //3 读写数组
    NSArray *resultArray = [NSArray arrayWithContentsOfFile:path2];
    
    NSLog(@"读到的数组数据---%@",resultArray);
    
    
    /*******字典读写******/
    //1 文件存储路径
    NSString *path3 = [NSHomeDirectory() stringByAppendingPathComponent:@"dic1.txt"];
    //2 存入字典数据
    NSDictionary *dic1 = @{@"名字":@"张三",@"性别":@"女"};
    [dic1 writeToFile:path3 atomically:YES];
    NSLog(@"字典数据存储路径- %@",path3);
    //3读取字典数据
    NSDictionary *resultDic = [NSDictionary dictionaryWithContentsOfFile:path3];
    NSLog(@"读取到的字典数据--- %@",resultDic);
    
    
    /******data读写*********/
    //1 存储位置
    NSString *path4 = [NSHomeDirectory() stringByAppendingPathComponent:@"data1.txt"];
    //2 图片存储
    UIImage *originImage = [UIImage imageNamed:@"test.png"];
    NSData *originData = UIImagePNGRepresentation(originImage);
    [originData writeToFile:path4 atomically:YES];
    NSLog(@"data存储位置--%@",path4);
    
    //3 取出存储的data
    NSData *resultData = [NSData dataWithContentsOfFile:path4];
    UIImage *resultImage = [UIImage imageWithData:resultData];
    self.imageShow.image= resultImage;
}

/*******************************************************************************/
//文件管理器的操作    文件管理器主要是对文件进行的操作(创建、删除、改名等)以及文件信息的获取
- (IBAction)clicktwoBtn:(id)sender {
    
    //1 存储路径的获取
    NSString *path1 = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/file_test1.txt"];
    
    //2 创建文件需要一个文件管理对象
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //3 创建文件
    NSString *testStr = @"这是一个文件测试";
    [manager createFileAtPath:path1 contents:[testStr dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    
    NSLog(@"存储路径---%@",path1);
    
    //获取文件信息
    NSDictionary *dic = [manager attributesOfItemAtPath:path1 error:nil];
    
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSLog(@"key = %@,value = %@",key,obj);
    }];
    
    
    
    
    /*************文件目录的读写***************/
    //1 目录所在的路径
    NSString *path2 = [NSHomeDirectory() stringByAppendingPathComponent:@"file_test2"];
    //2 创建文件管理对象
    NSFileManager *manager2 = [NSFileManager defaultManager];
    //3创建文件夹
    [manager2 createDirectoryAtPath:path2 withIntermediateDirectories:YES attributes:nil error:nil];
    NSLog(@"文件夹路径 - %@",path2);
    
    
    
    /***********操作实例************/
    /*
     在Documents文件夹下,创建一个文件夹(path),在该文件夹下创建一个文件(test.txt),将一个图片对象存入到该文件中,
     然后在Caches文件夹下创建一个文件夹名为"testDirectroy",将test.txt文件移动到这个文件夹下.
     */
    
    //1 创建文件路径
    NSString *path3 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"path"];
    NSString *path4 = [path3 stringByAppendingPathComponent:@"test.txt"];
    
    //2 文件管理对象生成
    NSFileManager *manager3 = [NSFileManager defaultManager];
    
    //3 创建文件夹
    [manager3 createDirectoryAtPath:path3 withIntermediateDirectories:YES attributes:nil error:nil];
    
    //写入图片数据
    UIImage *originImage = [UIImage imageNamed:@"test.png"];
    NSData *originData = UIImagePNGRepresentation(originImage);
   // [originData writeToFile:path4 atomically:YES];
    
    [manager3 createFileAtPath:path4 contents:originData attributes:nil];
    
    NSLog(@"完成路径显示- %@",path4);
    
    //4 caches创建文件夹
    NSString *cachesPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"testDirectroy"];
    
    //5 创建文件
    [manager3 createDirectoryAtPath:cachesPath withIntermediateDirectories:YES attributes:nil error:nil];
    
    //6 移动后的文件路径位置
    NSString *resultPath = [cachesPath stringByAppendingPathComponent:[path4 lastPathComponent]];
    
    //7 移动文件
    [manager3 moveItemAtPath:path4 toPath:resultPath error:nil];
}



/*******************************************************************************/
//NSFilehandle 文件对接器   NSFileHandle是非常基础的只针对文件内容的操作(写入、读取、根性)，是把NSData通过连接器一个字节一个字节的写入/读取文件(NSData <——> NSFileHandle <——> 文件)
/*
 
 使用场景：对文件内容进行局部的修改、追加内容。
 使用步骤：1). 文件对接并获取一个NSFileHandle对象； 读写操作   关闭对接
 
 注：NSFileHandle类并没有提供创建文件的功能，必须使用NSFileManager的方法来创建文件，因此，在使用NSFileHandle的特有方法时，到要保证文件已经存在，否则返回nil。
 */
- (IBAction)clickThreeBtn:(id)sender {
    
    /*
     练习要求：从一个文件中指定的位置开始追加内容
     提示:
     　　1、在documents目录下创建一个test.txt文件,文件中的内容为"abcdefg"
     　　2、从文件偏移量为3那个位置开始追加内容"1234"
     */
    
    //1 文件路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"test.txt"];
    //2 创建文件管理对象
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //3创建文件
    NSString *str = @"abcdefg";
    [manager createFileAtPath:path contents:[str dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    NSLog(@"路径 = %@",path);
    
    //4 文件内容操作 创建文件对接器
    NSFileHandle *handle = [NSFileHandle fileHandleForUpdatingAtPath:path];
    
    //5 偏移插入位置
    [handle seekToFileOffset:3];
    
    NSData *resultData = [handle readDataToEndOfFile];
    NSString *str2 = [[NSString alloc]initWithData:resultData encoding:NSUTF8StringEncoding];
    NSLog(@"str2  = %@",str2);
    
    [handle seekToFileOffset:3];
    //6写入数据
    NSString *str3 = [NSString stringWithFormat:@"你好哈%@",str2];
    [handle writeData:[str3 dataUsingEncoding:NSUTF8StringEncoding]];
    
    //7 关闭文件
    [handle closeFile];
    
}


/*******************************************************************************/
//大文件的复制
- (IBAction)clickFoureBtn:(id)sender {
    
    /*******************直接方法。缺点，不能控制文件操作的速度*************************/
    //1 原始文件路径
    NSString *path1 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"testcopy.pdf"];
    //复制后的文件路径
    NSString *path2 = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"copy.pdf"];
    
    //2 创建文件管理对象
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //3 copy
    [manager copyItemAtPath:path1 toPath:path2 error:nil];
    
    
}


/*******************************************************************************/
//大文件的复制
- (IBAction)clickFiveBtn:(id)sender {
    
    //1  存储路径
    NSString *path1 = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"testcopy.pdf"];
    //复制后的文件路径
    NSString *path2 = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"copy2.pdf"];
    
    // 2 创建文件，不然无法复制
    NSFileManager *manager = [NSFileManager defaultManager];
    
    [manager createFileAtPath:path2 contents:nil attributes:nil];
    
    //2 文件操作对象
    NSFileHandle *readPath = [NSFileHandle fileHandleForReadingAtPath:path1];
    NSFileHandle *writePath = [NSFileHandle fileHandleForWritingAtPath:path2];
    
    //3 获取读入文件的数据
    NSDictionary *dic = [manager attributesOfItemAtPath:path1 error:nil];
    //文件大小
    unsigned int sizeLength = [dic[@"NSFileSize"] intValue];
    
    //4 文件的读取进度
    unsigned int readLength = 0;
    
    BOOL isEnd = NO;
    
    //5 开始读取
    while (!isEnd) {
        
        //6 剩余需要读取的数据
        unsigned int subLength = sizeLength - readLength;
        
        //7 判断是否是最后一段数据
        NSData *data = nil;
        if (subLength <= 5000) {
            
            isEnd = YES;
            data = [readPath readDataToEndOfFile];
        }else{
        
            data = [readPath readDataOfLength:5000];
            readLength += 5000;
            [readPath seekToFileOffset:readLength];
        }
        
        NSLog(@"文件总大小= %u,写入数据位置 = %u",sizeLength,readLength);
        //8 写入
        [writePath writeData:data];
    }
    
    //9 关闭
    [readPath closeFile];
    [writePath closeFile];
}
@end
