//
//  FileViewController.m
//  文件读写Demo
//
//  Created by 孙云飞 on 2017/9/4.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "FileViewController.h"
#import <stdio.h>

struct record{

    char name[10];
    int age;
};

@interface FileViewController ()
- (IBAction)clickOneBtn:(id)sender;
- (IBAction)clicktwoBtn:(id)sender;
- (IBAction)clickThreeBtn:(id)sender;

@end

@implementation FileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

/*
 fopen() 打开流
 fclose() 关闭流
 fputc() 写一个字符到流中
 fgetc() 从流中读一个字符
 fseek() 在流中定位到指定的字符
 fputs() 写字符串到流
 fgets() 从流中读一行或指定个字符
 fprintf() 按格式输出到流
 fscanf() 从流中按格式读取
 feof() 到达文件尾时返回真值
 ferror() 发生错误时返回其值
 rewind() 复位文件定位器到文件开始处
 remove() 删除文件
 fread() 从流中读指定个数的字符
 fwrite() 向流中写指定个数的字符
 tmpfile() 生成一个临时文件流
 tmpnam() 生成一个唯一的文件名
 */



//fopen fclose
- (IBAction)clickOneBtn:(id)sender {
    
    //1 获取文件的路径
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"test1.txt"];
    //2 转换为char
    const char *a = [path UTF8String];
    //3 创建FILE
    FILE *fp = fopen(a, "rb");
    int i;
    //4 判断是否打开
    if (fp == NULL)
        puts("File open error");
    //5 关闭文件
    i = fclose(fp);
    if (i == 0)printf("close success");
    else
        puts("File close error");
}


//fopen fputs
- (IBAction)clicktwoBtn:(id)sender {
    
    //1 路径
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"data.txt"];
    
    int i = 617;
    //2 打开文件（没有创建）
    const char *file = [path UTF8String];
    FILE *fp = fopen(file, "w");
    //3 fp是否为null
    if (fp != NULL) {
        //4 插入数据
        fputs("your score of toefils", fp);
        fputc(':', fp);
        fprintf(fp, "%d\n",i);
        char *s = "this is input";
        fprintf(fp, "%s",s);
    }else
        printf("file open error");
    fclose(fp);
}


//fread fwrite
- (IBAction)clickThreeBtn:(id)sender {
    
    /******* 存储一个结构体********/
    struct record array[2] = {{"zhangsan",23},{"lisi",30}};
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"fuck.txt"];
    NSLog(@"%@",path);
    const char * path2 = [path UTF8String];
    FILE *fp = fopen(path2, "w");
    if (fp == NULL)
        printf("file open error");
    fwrite(array, sizeof(struct record), 2, fp);
    fclose(fp);
    
    
    
    //fread读取数据
    
    struct record array2[2];
    FILE *fp2 = fopen(path2, "r");
    if (fp == NULL) {
        
        printf("file open error");
        exit(1);
    }
    
    fread(array2, sizeof(struct record), 2, fp2);
    
    for(int i = 0;i < 2;i ++){
    
        printf("name = %s,age = %d\n",array2[i].name,array2[i].age);
    }
    fclose(fp2);
    
    
    
    /*******存取字符串**********/
    //1 存储位置
    NSString *path3 = [NSHomeDirectory() stringByAppendingPathComponent:@"w1.txt"];
    const char *path3s = [path3 UTF8String];
    
    //2 创建file
    FILE *fp3 = fopen(path3s, "w");
    
    if (fp3 == NULL) {
        
        printf("open error");
        exit(1);
    }
    //3 写入字符
    NSString *str = @"这是我写入的字符";
    char *c = [str UTF8String];
    printf("%s\n",c);
    fwrite(c, sizeof(char), strlen(c), fp3);
    
    //4 关闭
    fclose(fp3);
    
    /*******读取字符串**********/
    
    //1 读取字符串的文件路径
    
    //2 创建file
    FILE *fp4 = fopen(path3s, "r");
    
    // 3 判断file是否成功
    if (fp4 == NULL) {
        
        printf("open error");
        exit(1);
    }
    
    //4 开始读取
    char c2[256];
    fread(c2, 1, sizeof(c2), fp4);
    fclose(fp4);
    printf("c2 = %s\n",c2);
}



@end
