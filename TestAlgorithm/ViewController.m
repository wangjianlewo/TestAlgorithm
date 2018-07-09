//
//  ViewController.m
//  TestAlgorithm
//
//  Created by eunice on 2018/5/1.
//  Copyright © 2018年 eunice. All rights reserved.
//

#import "ViewController.h"
#import "ViewController+DayOne.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    NSMutableArray *bubbleArray = [[NSMutableArray alloc] initWithObjects:@(6), @(2),@(1),@(5),@(9),@(8),@(3),@(7),nil];
//    [self lessLeftMoreRight:bubbleArray andCompareNum:5];
//    [self mergeSortArray:bubbleArray];
    [self quickSort:bubbleArray];
//    [self partionWithArray:bubbleArray andLPosition:0 andRPosition:bubbleArray.count - 1];
    NSLog(@"%@",bubbleArray);

    [ViewController devided];
    [ViewController letterToInt:@"AAA"];
    [ViewController charToInt:@"AAA"];

}

- (void)quickSort:(NSMutableArray *)array
{
    if (array.count <2 || array == nil) {
        return;
    }
    [self quickSortWithArray:array andLPosition:0 andRPosition:array.count - 1];
}

- (void)quickSortWithArray:(NSMutableArray *)array andLPosition:(NSInteger) l andRPosition:(NSInteger )r
{
    if (l < r) {
//        [self swap:array andi:(l+r)/2 andj:r];
        NSArray *positionArray = [self partionWithArray:array andLPosition:l andRPosition:r];
        [self quickSortWithArray:array andLPosition:l andRPosition:([positionArray[0] intValue])];
        [self quickSortWithArray:array andLPosition:([positionArray[1]intValue] +1) andRPosition:r];
    }
}

- (NSArray *)partionWithArray:(NSMutableArray *)array andLPosition:(NSInteger) l andRPosition:(NSInteger )r
{
    NSMutableArray *currentArray = [NSMutableArray array];;
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > l - 1   || idx < r +1) {
            [currentArray addObject:obj];
        }
    }];
    
    NSLog(@"原始array %@ ,分区的数%@",currentArray,[currentArray lastObject]);

    int less = l -1 ;
    int more = r ;
    int current = l;
    while (current < more) {
        if ([array[current] integerValue] < [array[r] integerValue]) {
            [self swap:array andi:++less  andj:current++];
        }else if([array[current] integerValue] > [array[r] integerValue]) {
            [self swap:array andi:--more andj:current];
        }else {
            current++;
        }
    }
    NSLog(@"调整好的array %@ ",array);

    [self swap:array andi:more andj:r];
    NSLog(@"最后一个数调换 array %@ ",array);

    NSArray *positionArray  = @[[NSNumber numberWithInt:less],[NSNumber numberWithInt:more]];

    return positionArray;
}
/*问题：
 给定一个数组arr，和一个数num，请把小于等于num的数放在数 组的左边，大于num的数放在数组的右边。
 要求额外空间复杂度O(1)，时间复杂度O(N)
 */

/*
 讲解：
 假想一个比num小的区域，目前index=-1，0个元素
 从无序数组第0个数开始遍历，每遍历1个就+1，直到遍历到末尾
 如果arr[current]比num 小，则原num小于区域+1，并且将arr[current] 与 将被划进小于num区域的数值交换，则arr[current] 被记录进了小于num区域
 如果arr[current]比num 大，则不做任何操作
 */
-(void)lessLeftMoreRight:(NSMutableArray *)array andCompareNum:(int)number
{
    int current = 0;
    int less = -1;
    while (current < array.count) {
        if ([array[current] intValue]  <= number) {
            less++;
            [self swap:array andi:less andj:current];
        }
        current ++;
    }
}

/*问题：
 问题二(荷兰国旗问题)
 给定一个数组arr，和一个数num，请把小于num的数放在数组的 左边，等于num的数放在数组的中间，大于num的数放在数组的 右边。
 要求额外空间复杂度O(1)，时间复杂度O(N)
 */

/*
 讲解：
 假想一个比num小的区域在数组左边，比num大的区域在数组右边，中间是等于num区域（初始为数组count）
 如果arr[current]比num 小，则原num小于区域变大 +1，并且将arr[current] 与 将被划进小于num区域的数值交换，则arr[current] 被记录进了小于num区域,遍历下个数：current+1
 如果arr[current]比num 大，则原num大于区域变大 +1 （num区域变大，则代表在原数组上挤压，即往前挪），并且将arr[current] 与 将被划进大于num区域的数值交换，因为大于num区域往前挪时，还不知道原值是比num大还是小。所以current 不加1
 如果arr[current]等于num，则等于区域不变，遍历下个数：current+1
 从无序数组第0个数开始遍历，那什么时候结束呢？ 当遍历到大于num区域的起始位置时。

 */
-(void)netherlandsFlag:(NSMutableArray *)array andCompareNum:(int)number
{
    NSUInteger current = 0;
    NSUInteger less = -1;
    NSUInteger more = array.count;
    while (current < more) {
        if ([array[current] intValue]  < number) {
            less++;
            [self swap:array andi:less andj:current];
            current ++;
        }else if ([array[current] intValue]  > number) {
            more --;
            [self swap:array andi:more andj:current];
        }else {
            current ++;
        }
    }
}

-(void)optimizeNetherlandsFlag:(NSMutableArray *)array andCompareNum:(int)number
{
    NSUInteger current = 0;
    NSUInteger less = -1;
    NSUInteger more = array.count;
    while (current < more) {
        if ([array[current] intValue]  < number) {
            [self swap:array andi:++less andj:current++];
        }else if ([array[current] intValue]  > number) {
            [self swap:array andi:--more andj:current];
        }else {
            current ++;
        }
    }
}

- (void)swap:(NSMutableArray *)array andi:(NSUInteger) i andj:(NSUInteger)j
{
    int temp = [array[i] intValue];
    array[i] = array[j];
    array[j]= [NSNumber numberWithInt:temp];
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
    //归并排序
    [self sortArray:array andL:0 andR:array.count-1];
}

- (void)sortArray:(NSMutableArray *)array andL:(NSInteger )L andR:(NSInteger)R
{
    if (L == R) {
        return;
    }
    NSInteger mid = (L + R)/2;
    NSLog(@"中间值为%ld 数组为 ",mid);
    //迭代前半部分
    [self sortArray:array andL:L andR:mid];
    //迭代后半部分
    [self sortArray:array andL:mid+1 andR:R];
    //两个有序数组合并
    [self mergeArray:array andL:L andR:R andMid:mid];
}

-(void)mergeArray :(NSMutableArray *)array andL:(NSInteger )L andR:(NSInteger)R andMid:(NSInteger)mid
{
    NSMutableArray *helpArray = [NSMutableArray arrayWithCapacity:R-L+1];
    NSInteger i = 0;
    NSInteger p1 = L;
    NSInteger p2 = mid+1;
    //防止前半部分数组和后半部分数组越界
    while (p1<=mid && p2<=R) {
        //array 按照mid分割为两个数组，并且是两个有序数组。将两数组合并，p1指向第1个数组的0位置，p2指向第二个数组的0位置。
        //比较大小后，赋值给helpArray，较小的值的位置++，并且i++
        if (array[p1] < array[p2]) {
            helpArray[i] = array[p1];
            p1++;
        }else {
            helpArray[i] = array[p2];
            p2++;
        }
        i++;
    }
    //当跳出上面的while循环时，是由于p2>r 或者p1>mid了，证明有1个数组比较完毕了。
    //将jiang剩余没比较的数，直接copy即可
    while (p1<=mid) {
        helpArray[i++]= array[p1++];
    }
    while (p2<=R) {
        helpArray[i++]=array[p2++];
    }
    //注意：我们需要按照对应的index，修改array
    for (i = 0; i < helpArray.count; i++) {
        array[L + i] = helpArray[i];
    }
    NSLog(@"当前比较的数组：%@  原始数组%@",helpArray,array);
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

//
//- (void)quickSortArray:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex
//{
//    if (leftIndex >= rightIndex) {//如果数组长度为0或1时返回
//        return ;
//    }
//
//    NSInteger i = leftIndex;
//    NSInteger j = rightIndex;
//    //记录比较基准数
//    NSInteger key = [array[i] integerValue];
//
////    NSLog(@"i = %ld,j = %ld,key = %ld array = %@",i,j,key,array);
//
//    while (i < j) {
//        /**** 首先从右边j开始查找比基准数小的值 ***/
//        while (i < j && [array[j] integerValue] >= key) {//如果比基准数大，继续查找
//            NSLog(@"a【j】 = %ld,j = %ld,key = %ld",[array[j] integerValue],j,key);
//
//            j--;
//
//        }
//        //如果比基准数小，则将查找到的小值调换到i的位置
//        array[i] = array[j];
//
//        NSLog(@"从右边遍历之后的数组%@",array);
//
//        /**** 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
//        while (i < j && [array[i] integerValue] <= key) {//如果比基准数小，继续查找
//            NSLog(@"a【i】 = %ld,i = %ld,key = %ld",[array[i] integerValue],i,key);
//
//            i++;
//
//        }
//        //如果比基准数大，则将查找到的大值调换到j的位置
//        array[j] = array[i];
//        NSLog(@"从左边遍历之后的数组%@",array);
//
//
//    }
//
//    //将基准数放到正确位置
//    array[i] = @(key);
////    NSLog(@"比较后的：%@",array);
//    /**** 递归排序 ***/
//    //排序基准数左边的
////    [self quickSortArray:array withLeftIndex:leftIndex andRightIndex:i - 1];
//    //排序基准数右边的
////    [self quickSortArray:array withLeftIndex:i + 1 andRightIndex:rightIndex];
//}


@end
