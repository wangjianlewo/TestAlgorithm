//
//  ViewController.m
//  TestAlgorithm
//
//  Created by eunice on 2018/5/1.
//  Copyright © 2018年 eunice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str1= @"ilovechina";
    NSString *str2= @"ihatechina";
    NSLog(@"你输入的两个字符串为:%@,%@",str1,str2);
    NSString *subStr=[self findMaxSubstring:str1 andString2:str2];
    if (subStr) {
        NSLog(@"最长公共子串是:%@",subStr);
    }
    
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:@(6), @(1),@(2),@(5),@(9),@(4),@(3),@(7),nil];
    [self quickSortArray:arr withLeftIndex:0 andRightIndex:arr.count - 1];
    
    NSLog(@"%@",arr);
}
-(NSString *)findMaxSubstring:(NSString *)string1 andString2:(NSString *)string2
{
    NSInteger length1 = string1.length;
    NSInteger length2 = string2.length;
    NSMutableArray *firstArray =[NSMutableArray array];
    for (int i = 0; i <length1; i++) {
        [firstArray addObject:[string1 substringWithRange:NSMakeRange(i, 1)]];
    }
    
    NSMutableArray *secondArray =[NSMutableArray array];
    for (int i = 0; i <length2; i++) {
        [secondArray addObject:[string2 substringWithRange:NSMakeRange(i, 1)]];
    }
    
    NSMutableArray *intArray = [NSMutableArray arrayWithCapacity:2];
    for(NSUInteger i = 0;i < 2; i++) {
        NSMutableArray *arrayD2 = [NSMutableArray array];
        if (i == 0) {
            for (int i = 0; i <length1; i++) {
                [arrayD2 addObject:@0];
            }
        }
        
        if (i == 1) {
            for (int i = 0; i <length2; i++) {
                [arrayD2 addObject:@0];
            }
        }

        [intArray addObject:arrayD2];
    }
    
        int length = 0; //最长公共子串长度
        for (int i = 0; i <length1; i++) {
            for (int j = 0; j < length2; j++) {
                NSLog(@"%@,  %@",firstArray[i],secondArray[j]);


                if(firstArray[i] == secondArray[j]){
                    if(i > 0 && j > 0){
                        NSInteger value = ((NSNumber*)(intArray[i-1][j-1])).intValue +1;
                        intArray[i][j] = [NSNumber numberWithInteger:value];
                    }else{
                        intArray[i][j] = @1;
                    }
                    
                    if(((NSNumber*)(intArray[i][j])).intValue > length){ //当前元素值大于最大公共子串长度
                        length = ((NSNumber*)(intArray[i][j])).intValue;
                    }
                }else{
                    intArray[i][j] = @0;
                }  
            }  
        }  
    NSLog(@"%d",length);
    return nil;

}
/*
-(NSString *)findMaxSubstring:(NSString *)string1 andString2:(NSString *)string2{
    //    首先找到长度较小的字符串 保证string1<string2
    NSString *temp;
    if ([string1 length]>[string2 length]) {
        temp=string1;
        string1=string2;
        string2=temp;
    }
    long length1=[string1 length];
    //    然后从长到短获取string1的子字符串,去string2中找,如果包含,则返回该子字符串,否则再找
    NSRange range=NSMakeRange(0, length1);
    
    while (![string2 containsString:[string1 substringWithRange:range]]&&range.location<=length1-1&&range.length>=1) {//如果string2不包含目前的子串并且没有越界
        NSString *str = [string1 substringWithRange:range];
        NSLog(@"range string %@",str);
        //        判断下一步操作
        if (range.location<length1-range.length) {//不需要减length
            range.location++;
        }else{
            range.length--;
            range.location=0;
        }
    }
    //    最后判断并返回子串
    if (range.length==0) {
        NSLog(@"没有找到公共子字符串!");
        return nil;
    }else{
        NSLog(@"找到了");
        return [string1 substringWithRange:range];
    }
}
*/
- (void)quickSortArray:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex
{
    if (leftIndex >= rightIndex) {//如果数组长度为0或1时返回
        return ;
    }
    
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    //记录比较基准数
    NSInteger key = [array[i] integerValue];
    
//    NSLog(@"i = %ld,j = %ld,key = %ld array = %@",i,j,key,array);
    
    while (i < j) {
        /**** 首先从右边j开始查找比基准数小的值 ***/
        while (i < j && [array[j] integerValue] >= key) {//如果比基准数大，继续查找
            NSLog(@"a【j】 = %ld,j = %ld,key = %ld",[array[j] integerValue],j,key);

            j--;

        }
        //如果比基准数小，则将查找到的小值调换到i的位置
        array[i] = array[j];
        
        NSLog(@"从右边遍历之后的数组%@",array);
        
        /**** 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
        while (i < j && [array[i] integerValue] <= key) {//如果比基准数小，继续查找
            NSLog(@"a【i】 = %ld,i = %ld,key = %ld",[array[i] integerValue],i,key);

            i++;

        }
        //如果比基准数大，则将查找到的大值调换到j的位置
        array[j] = array[i];
        NSLog(@"从左边遍历之后的数组%@",array);

        
    }
    
    //将基准数放到正确位置
    array[i] = @(key);
//    NSLog(@"比较后的：%@",array);
    /**** 递归排序 ***/
    //排序基准数左边的
//    [self quickSortArray:array withLeftIndex:leftIndex andRightIndex:i - 1];
    //排序基准数右边的
//    [self quickSortArray:array withLeftIndex:i + 1 andRightIndex:rightIndex];
}


@end
