//
//  ViewController+DayOne.m
//  TestAlgorithm
//
//  Created by eunice on 2018/7/9.
//  Copyright © 2018年 eunice. All rights reserved.
//

#import "ViewController+DayOne.h"

@implementation ViewController (DayOne)
/*
 遍历1-100，被3整除的输出a, 被5整除的输出b，被15整除的输出c。
 点评: 刚哥御用笔试题，考察点主要在于被15整除的数也可以被3和5整除，写代码的时候注意绕过这个逻辑即可，据说有50%的人写不出来，o(╯□╰)o。
 */
+(void)devided
{
    for (int i = 1 ; i < 51 ; i ++) {
//        if (i%15 == 0) {
        if (i%3 == 0 && i%5==0) {
            NSLog(@"被15整除 %ld  c ",i);
        }else if (i%3 == 0) {
            NSLog(@"被3整除 %ld  a ",i);
        }else if (i %5 == 0) {
            NSLog(@"被5整除 %ld  b ",i);
        }
    }
}
/*
 输入一个字符串，全是大写字母范围从'A'-'Z'(A,B,C,D,AA,AB,AC)，输出相应的int值. (A=1,B=2,Z=26,AA=27...) 点评: 就是考察了一下 sum = sum * 26 + curr;
 */
+(void)letterToInt:(NSString *)letter
{
    NSDictionary *keyAndValue = @{@"A":[NSNumber numberWithInt:1],@"B":[NSNumber numberWithInt:2],
                                  @"C":[NSNumber numberWithInt:3],@"D":[NSNumber numberWithInt:4],
                                  @"E":[NSNumber numberWithInt:5],@"F":[NSNumber numberWithInt:6],
                                  @"G":[NSNumber numberWithInt:7],@"H":[NSNumber numberWithInt:8],
                                  @"I":[NSNumber numberWithInt:9],@"G":[NSNumber numberWithInt:10],
                                  @"K":[NSNumber numberWithInt:11],@"L":[NSNumber numberWithInt:12],
                                  @"M":[NSNumber numberWithInt:13],@"N":[NSNumber numberWithInt:14],
                                  @"O":[NSNumber numberWithInt:16],@"P":[NSNumber numberWithInt:15],
                                  @"Q":[NSNumber numberWithInt:17],@"R":[NSNumber numberWithInt:18],
                                  @"S":[NSNumber numberWithInt:19],@"T":[NSNumber numberWithInt:20],
                                  @"U":[NSNumber numberWithInt:21],@"V":[NSNumber numberWithInt:22],
                                  @"W":[NSNumber numberWithInt:23],@"X":[NSNumber numberWithInt:24],
                                  @"Y":[NSNumber numberWithInt:25],@"Z":[NSNumber numberWithInt:26]};
    int length = letter.length;
    int sum = 0;
    for (int i= 0; i<letter.length; i++) {
        NSString *current = [letter substringWithRange:NSMakeRange(i, 1)];

        if (i == letter.length -1) {
            sum += [[keyAndValue objectForKey:current] intValue];
        }else {
            sum +=  [[keyAndValue objectForKey:current] intValue] *pow(26, letter.length - i - 1);
        }
    }
    NSLog(@"%ld",sum);
}

+(void)charToInt:(NSString *)letter
{
    int difference = 64;
    int sum = 0;
    for (int i= 0; i<letter.length; i++) {
        NSString *current = [letter substringWithRange:NSMakeRange(i, 1)];
        int realNum = [current characterAtIndex:0];
        if (i == letter.length -1) {
            sum += (realNum - difference);
        }else {
            sum += (realNum - difference) * (pow(26, letter.length - i - 1));
        }
    }
    NSLog(@"%ld",sum);
}

+ (void)isPalindrome:(NSString *)string
{
    NSLog(@"input string %@",string);

    NSInteger index = string.length/2;//除数
    NSInteger addition = string.length%2;//余数。 主要是传入的字符串有奇数有偶数。奇数时，中间那个数就不算了。
    NSString *frontString = [string substringWithRange:NSMakeRange(0, index)];
    NSString *backString = [string substringWithRange:NSMakeRange(index+addition, index)];//分成两部分
    NSMutableString *newFrontString = [[NSMutableString alloc] init];//反转前一部分
    for (int i = frontString.length -1 ; i>-1; i--) {
        [newFrontString appendFormat:[frontString substringWithRange:NSMakeRange(i, 1)] ];
    }
    NSLog(@"manager string %d,%@,%@",[newFrontString isEqualToString:backString],newFrontString,backString);
}
//更相减损法。1.先将偶数约成最简数 2.更相减损，直至所得的减数和差相等
+ (void)greatestCommonDivisor:(int)left andRight:(int)right
{
    int count = 1;
    while  (left %2 == 0 && right %2 ==0) {
        left = left/2;
        right = right/2;
        count ++;
    }
    while (left != right) {
        if (left>right) {
            left = left -right;
        }else {
            right = right - left;
        }
    }
    NSLog(@"%ld",left*count);
}
//两个数相余，然后小数再余上次的余数，辗转，直至余数为0，则上次的余数为其公约数
+ (void)greatestCommonDivisorSecond:(int)left andRight:(int)right
{
    while (right != 0 && left % right != 0) {
       int temp  =  left % right ;
        left = right;
        right = temp;
    }
    NSLog(@"%ld",right);
}
//有两个已经排好序的数组(升序)，现在把这两个数组合成一个按升序排列的数组
+ (void)mergeArray
{
    NSArray *array1 = @[@"1",@"3",@"7",@"9"];
    NSArray *array2 = @[@"2",@"5",@"6"];
    NSMutableArray *array3 = [NSMutableArray array];
    int a = 0;
    int b = 0;
    while (a < array1.count && b < array2.count) {
        if ([array1[a] intValue] > [array2[b] intValue]) {
            [array3 addObject:array2[b]];
            b ++;
        }else {
            [array3 addObject:array1[a]];
            a ++;
        }
    }
    if (a == array1.count) {
        for (int j = b ; j < array2.count; j++) {
            [array3 addObject:array2[j]];
        }
    }
    if (b == array2.count) {
        for (int j = a ; j < array1.count; j++) {
            [array3 addObject:array1[j]];
        }
    }
    NSLog(@"%@",array3);
}

//输入两个字符串表示version，"1.1.2", "1.1.1", 判断两个version那个是最新的
+(void)compareVersion
{
    NSString *version1 = @"1.2.2";
    NSString *version2 = @"1.2.1";
    NSArray *array1 = [version1 componentsSeparatedByString:@"."];
    NSArray *array2 = [version2 componentsSeparatedByString:@"."];
    NSUInteger min = array1.count > array2.count ? array2.count : array1.count;
    for (int i = 0; i <min; i ++) {
        if ([array1 [i] integerValue] >[array2 [i] integerValue] ) {
            NSLog(@"version1 较新");
            return;
        }else if ([array1 [i] integerValue] <[array2 [i] integerValue] ) {
            NSLog(@"version2 较新");
            return;
        }else {
            i++;
        }
    }
}
//给定两个区间，判断这两个区间是否重合
+ (void)rangeCoincide
{
    NSString *version1 = @"4,8";
    NSString *version2 = @"2,6";
    NSArray *array1 = [version1 componentsSeparatedByString:@","];
    NSArray *array2 = [version2 componentsSeparatedByString:@","];
    if (array2[0] > array1[1] || array1[0] > array2[1] ) {
        NSLog(@"无重合部分");
    }else {
        NSLog(@"有重合部分");
    }
}

+ (void)statisticsSameWord
{
    NSArray *array = @[@"abc",@"boy",@"girl",@"boy",@"abcd",@"abcd"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [array enumerateObjectsUsingBlock:^(NSString *string, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([dict objectForKey:string]) {
            NSInteger num = [[dict objectForKey:string] integerValue];
            num ++;
            [dict setObject:[NSNumber numberWithInteger:num] forKey:string];
        }else {
            [dict setObject:@"1" forKey:string];
        }
    }];
    NSLog(@"%@",dict);
}
@end
