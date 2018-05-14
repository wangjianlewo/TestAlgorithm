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
    
//    NSString *str1= @"ilovechina";
//    NSString *str2= @"ihatechina";
//    NSLog(@"你输入的两个字符串为:%@,%@",str1,str2);
//    NSString *subStr=[self findMaxSubstring:str1 andString2:str2];
//    if (subStr) {
//        NSLog(@"最长公共子串是:%@",subStr);
//    }
    
    
//    NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:@(6), @(1),@(2),@(5),@(9),@(4),@(3),@(7),nil];
//    [self quickSortArray:arr withLeftIndex:0 andRightIndex:arr.count - 1];
    
    
    NSMutableArray *bubbleArray = [[NSMutableArray alloc] initWithObjects:@(6), @(3),@(4),@(7),@(1),@(2),nil];
    [self mergeSortArray:bubbleArray];
    NSLog(@"%@",bubbleArray);
}

- (void)bubbleSortArray:(NSMutableArray *)array
{
    if (array.count < 2 || array == nil) {
        return;
    }
    //该for循环代表：遍历1次找到1个最大的数，需要遍历n次
    for (NSUInteger i = array.count - 1; i >0 ; i--) {
        //该for循环为，数组按照0~n-1开始遍历，两个数比较，较大的放在后面，则找到了最大的数，放在最后位置了。
        //由于n-1 位置已经确认为最大的了，则不参与下次遍历。故下次遍历则从0~遍历到n-2
        for (int j = 0; j < i; j++) {
            if ([array[j] intValue] > [array[j +1] intValue]) {
                int temp = [array[j+1] intValue];
                array[j + 1] = array[j];
                array[j]= [NSNumber numberWithInt:temp];
            }
        }
    }
}

- (void)selectSortArray:(NSMutableArray *)array
{
    if (array.count < 2 || array == nil) {
        return;
    }
    int count = 0;
    //最外层，依然代表要遍历n次
    for (int i =0; i < array.count; i ++) {
        int minIndex = i ;
        count++;
        //通过遍历j~n-1个数，找到最小的数的index，并记录
        for (int j = i+1 ; j<array.count ; j++) {
            if ([array[j] intValue] < [array[minIndex] intValue]) {
                minIndex = j;
            }
            count++;
        }
        //将当前找到的最小数，与遍历的第一个数进行交换。 因为要和第i个数交换，所以从j = i+1,即下一个数开始遍历
        //则下次从第j~n-1个数，遍历即可
        int temp = [array[i] intValue];
        array[i] = array[minIndex];
        array[minIndex] =  [NSNumber numberWithInt:temp];
    }
    NSLog(@"%d",count);
}

- (void)insertSortArray:(NSMutableArray *)array
{
    if (array.count < 2 || array == nil) {
        return;
    }
    //最外层，代表要插入第i个数。i=0 的时候，数组里面没有数据，所以应从1开始
    for (int i = 1; i < array.count; i ++) {
        //通过比较i的值 与  i 的前一个数 的大小，来判断是否需要交换
        //如果i的值比较大，则无需交换，跳出此次循环
        //如果i的值比较小，交换。 交换后继续比较 i-1 的前一个数，与 i-1 的大小
        //注意：内层循环会执行j--，故arry[i]， 要写成arry[j+1]
        for (int j = i - 1 ; j>=0  ; j--) {
            if ([array[j+1] intValue] < [array[j] intValue]) {
                int temp = [array[j] intValue];
                array[j]= array[j+1];
                array[j+1] = [NSNumber numberWithInt:temp];
                NSLog(@"%@",array);

            }else {
                break;
            }
        }
    }
}

- (void)mergeSortArray:(NSMutableArray *)array
{
    if (array.count < 2 || array == nil) {
        return;
    }
    [self sortArray:array andL:0 andR:array.count - 1];
}

- (void)sortArray:(NSArray *)array andL:(NSInteger )L andR:(NSInteger)R
{
    if (L == R) {
        return;
    }
    int mid = (L+R)/2;
    NSLog(@"中间值为%d 数组为 ",mid);
    [self sortArray:array andL:L andR:mid];
    [self sortArray:array andL:mid+1 andR:R];
//    [self mergeArray:array andL:L andR:R andMid:mid];
}

-(void)mergeArray :(NSArray *)array andL:(NSInteger )L andR:(NSInteger)R andMid:(NSInteger)mid
{
    NSMutableArray *helpArray = [NSMutableArray arrayWithCapacity:R-L+1];
    int i = 0;
    int p1 = L;
    int p2 = mid+1;
    while (p1<=mid || p2<=R-1) {
        if (array[p1] < array[p2]) {
           helpArray[i ++ ] = array[p1 ++];
        }else {
            helpArray[i ++ ] = array[p2++];
        }
        
    }
    
    while (p1<=mid) {
        helpArray[i++]= array[p1++];
    }
    while (p2<=R) {
        helpArray[i++]=array[p2++];
    }
    
    NSLog(@"helparray %@",helpArray);
    
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
