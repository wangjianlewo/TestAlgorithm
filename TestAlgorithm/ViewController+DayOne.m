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
@end