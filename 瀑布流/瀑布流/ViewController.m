//
//  ViewController.m
//  瀑布流
//
//  Created by 韩稳 on 16/9/28.
//  Copyright © 2016年 韩稳. All rights reserved.
//

#import "ViewController.h"
#import "WaterflowLayout.h"

#define RANDOMCOLOR [UIColor colorWithHue:(arc4random_uniform(105)+150)/255.0 saturation:(arc4random_uniform(105)+150)/255.0 brightness:(arc4random_uniform(105)+150)/255.0 alpha:1]

@interface ViewController ()<UICollectionViewDataSource>



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    WaterflowLayout *layout = [[WaterflowLayout alloc]init];
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:layout];
    collectionView.dataSource = self;

    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"WaterflowLayout"];
    
    [self.view addSubview:collectionView];
    }



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 150;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"WaterflowLayout" forIndexPath:indexPath];
    
    UIImageView *imgView = [[UIImageView alloc]init];
    int num = indexPath.row % 11;
    
    imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",num]];
    cell.backgroundView = imgView;
    
    //cell.backgroundColor = [UIColor lightGrayColor];
    NSInteger tag = 1;
    UILabel *label = (UILabel *)[cell.contentView viewWithTag:tag];
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.tag = tag;
        [cell.contentView addSubview:label];
    }
    
    label.text = [NSString stringWithFormat:@"%zd", indexPath.item];
    [label sizeToFit];

    
    return cell;
    
}





@end
