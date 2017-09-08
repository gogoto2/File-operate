//
//  PlistViewController.m
//  文件读写Demo
//
//  Created by 孙云飞 on 2017/9/8.
//  Copyright © 2017年 孙云飞. All rights reserved.
//

#import "PlistViewController.h"
#import <stdio.h>
#import <sys/stat.h>
@interface PlistViewController ()
- (IBAction)clickOneBtn:(id)sender;
- (IBAction)clickTwoBtn:(id)sender;

@end

@implementation PlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)clickOneBtn:(id)sender {
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"test2.mp4"];
    
    //NSLog(@"%@",path);
    
    //NSFileManager *manager = [NSFileManager defaultManager];
    
    NSString *str = [[NSBundle mainBundle]pathForResource:@"test.mp4" ofType:nil];
    
//    //NSURL*url=  [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"]];
//    
//    NSInteger   fileSize = [manager attributesOfItemAtPath:str error:nil].fileSize;
//    NSLog(@"大小 = %li",(long)fileSize);
//    
//    
//    NSData *data = [[NSData alloc]initWithContentsOfFile:str];
//    
//    [manager createFileAtPath:path contents:data attributes:nil];
    
    
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
        [manager createFileAtPath:path contents:nil attributes:nil];
    
        NSFileHandle *readHandle = [NSFileHandle fileHandleForReadingAtPath:str];
        NSFileHandle *writeHandle = [NSFileHandle fileHandleForWritingAtPath:path];
    
        //5 获取文件的大小
        NSDictionary *dic = [manager attributesOfItemAtPath:str error:nil];
        unsigned int sizeLength = [dic[@"NSFileSize"] intValue];
        unsigned int readLength = 0;
        BOOL isEnd = NO;
        while (!isEnd) {
    
            unsigned int subLength = sizeLength -  readLength;
    
            NSData *data = nil;
            if (subLength <= 10000) {
    
                data = [readHandle readDataToEndOfFile];
                isEnd = YES;
            }else{
    
                data = [readHandle readDataOfLength:10000];
                readLength += 10000;
    
                [readHandle seekToFileOffset:readLength];
            }
            NSLog(@"文件总大小= %u,写入数据位置 = %u",sizeLength,readLength);
            [writeHandle writeData:data];
        }
    
}

- (IBAction)clickTwoBtn:(id)sender {
    
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"test3.mp4"];
    NSLog(@"%@",path);
    const char * path2 = [path UTF8String];
    
    NSString *str = [[NSBundle mainBundle]pathForResource:@"test.mp4" ofType:nil];
    
    const char* str2 = [str UTF8String];
    
    file_copy(str2, path2);
    
//    FILE *file = fopen(str2, "r");
//    if (file == NULL) {
//        NSLog(@"file open error");
//    }
//    
//    FILE *file2 = fopen(path2, "w");
//    if (file2 == NULL) {
//        NSLog(@"file open error");
//    }
//    
//    uint8_t* buf = malloc(512*1024);
//    
//    int64_t sizeAll = (int64_t)file_size2(str2);
//    
//    int64_t read = 0;
//    
//    
//    while (read < sizeAll) {
//        
//        //读取数据
//        fseek(file, read, SEEK_CUR);
//        unsigned long curlen = fread(buf, 1, sizeof(buf), file);
//        if (curlen <= 0) {
//            
//            break;
//        }
//        
//        
//        
//        uint8_t* wbuf = buf ;
//        int32_t  wlen = 0 ;
//        int32_t  clen = 0 ;
//        
//        fseek(file2, read, SEEK_CUR);
//        
//        while (wlen < curlen && (clen = fwrite(buf, 1, wbuf+wlen
//                                               , file2)) > 0)
//            wlen += clen ;
//        
//        if(wlen != curlen)
//            break ;
//        read += curlen ;
//
//    }
//    
//    fclose(file);
//    fclose(file2);
}



//获取文件大小
int64_t file_size2(const char* filename)
{
    struct stat statbuf;
    stat(filename,&statbuf);
    int64_t size=statbuf.st_size;
    
    return size;
}


void file_copy(const char *sourceFile,const char *desFile){

    //char *buff;
    unsigned int fsize = 0;
    FILE *fp_source;
    FILE *fp_des;
    
    fp_source = fopen(sourceFile, "r+");
    
    if (fp_source == NULL) {
        printf("source open error");
        return;
    }
    
//    while (getc(fp_source) != EOF) {
//        
//        fsize ++;
//    }
    
    struct stat statbuf;
    stat(sourceFile,&statbuf);
    fsize = (unsigned int)statbuf.st_size;
    
    uint8_t* buff = malloc(fsize);
    
    if (buff == NULL) {
        printf("buff is null");
        return;
    }
    
    rewind(fp_source);
    
    fread(buff, 1, fsize, fp_source);
    
    fclose(fp_source);
    
    printf("source file size = %d bytes\n file context = %s\n",fsize,buff);
    
    fp_des = fopen(desFile, "w+");
    if (NULL == fp_des) {
        
        printf("des open error");
        return;
    }

    fwrite(buff, 1, fsize, fp_des);
    fclose(fp_des);
    free(buff);
    buff = NULL;
}
@end
