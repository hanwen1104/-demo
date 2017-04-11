//
//  WaterflowLayout.m
//  瀑布流
//
//  Created by 韩稳 on 16/9/28.
//  Copyright © 2016年 韩稳. All rights reserved.
//

#import "WaterflowLayout.h"

/** 列数 */
static NSInteger DefaultColumnCount = 3;
/** 每一列之间的间距 */
static  CGFloat DefaultColumnMargin = 5;
/** 每一行之间的间距 */
static  CGFloat DefaultRowMargin = 5;

/** 设置边缘间距   UIEdgeInsets 属于结构体可以大括号赋值*/
static const UIEdgeInsets DefaultEdgeInsets = {0, 5, 5, 5};



@interface WaterflowLayout()

/** 每个cell属性数组 */
@property(nonatomic, strong)NSMutableArray *attributeArray;
/** 存放所有列的当前高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;

@end


@implementation WaterflowLayout


-(NSMutableArray*)attributeArray
{
    if(!_attributeArray)
    {
        _attributeArray = [NSMutableArray array];
    }
    return _attributeArray;
}

- (NSMutableArray *)columnHeights
{
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}



-(void)prepareLayout
{
    [super prepareLayout];
     // 清除以前计算的所有高度
    [self.columnHeights removeAllObjects];
    //初始化给每一列赋值一个高度
    for (NSInteger i = 0 ; i < DefaultColumnCount; i++)
    {
        [self .columnHeights addObject:@(DefaultEdgeInsets.top)];
    }
    // 清除之前所有的布局属性
    [self.attributeArray removeAllObjects];
    
    //找出来多少个Cell 开始创建每个cell的布局
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < count; i++)
    {
        //创建位置
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        //获取每个indexPath位置cell的布局属性
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.attributeArray addObject:attribute];
        
    }
}

/*** 决定cell的排布  每次滑动Collection 一直调用这个方法*/
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attributeArray;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //每个cell的布局属性
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat collectionWidth = self.collectionView.frame.size.width;
    
    //cell 的frame
    CGFloat cellWidth = (collectionWidth - DefaultEdgeInsets.left - DefaultEdgeInsets.right - (DefaultColumnCount-1)*DefaultColumnMargin) / DefaultColumnCount;
    CGFloat cellHeight = 70 +arc4random_uniform(100);
    
    //计算高度最短的那一列
    NSInteger minColumn = 0;
    CGFloat minColumnHeight = [self.columnHeights[0] doubleValue];
    
    for (NSInteger i = 0; i < DefaultColumnCount; i++)
    {   // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (minColumnHeight > columnHeight)
        {
            minColumnHeight = columnHeight;
            minColumn = i;
        }
    }
    
    //每个cell x。y 起始点
    CGFloat x = DefaultEdgeInsets.left + minColumn *(cellWidth + DefaultColumnMargin);
    CGFloat y = minColumnHeight + DefaultRowMargin;

    attribute.frame = CGRectMake(x, y, cellWidth, cellHeight);
    
    self.columnHeights[minColumn] = @(CGRectGetMaxY(attribute.frame));
    
    return attribute;
}


///collectionView的内容尺寸
- (CGSize)collectionViewContentSize
{
    CGFloat maxColumnHeight = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < DefaultColumnCount; i++) {
        // 取得第i列的高度
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        
        if (maxColumnHeight < columnHeight) {
            maxColumnHeight = columnHeight;
        }
    }
    return CGSizeMake(0, maxColumnHeight + DefaultEdgeInsets.bottom);
}
















@end
