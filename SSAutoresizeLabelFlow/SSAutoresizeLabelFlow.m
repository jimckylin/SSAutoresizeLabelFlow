//
//  SSAutoresizeLabelFlow.m
//  SSAutoresizeLabelFlow
//
//  Created by Mrss on 16/1/25.
//  Copyright © 2016年 expai. All rights reserved.
//

#import "SSAutoresizeLabelFlow.h"
#import "SSAutoresizeLabelFlowConfig.h"
#import "SSAutoresizeLabelFlowCell.h"
#import "SSAutoresizeLabelFlowLayout.h"

static NSString *const cellId = @"cellId";

@interface SSAutoresizeLabelFlow () <UICollectionViewDataSource,UICollectionViewDelegate,SSAutoresizeLabelFlowLayoutDelegate,SSAutoresizeLabelFlowLayoutDataSource>

@property (nonatomic,strong) UICollectionView *collection;
@property (nonatomic,strong) NSMutableArray   *data;
@property (nonatomic,  copy) selectedHandler  handler;

@end

@implementation SSAutoresizeLabelFlow


- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles selectedHandler:(selectedHandler)handler {
    CGRect newFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 1);
    self = [super initWithFrame:newFrame];
    if (!titles.count) {
        return self;
    }
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.data = [titles mutableCopy];
        self.handler = handler;
        [self setup];
    }
    return self;
}

- (void)setup {
    SSAutoresizeLabelFlowLayout *layout = [[SSAutoresizeLabelFlowLayout alloc]init];
    layout.delegate = self;
    layout.dataSource = self;
    self.collection = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    self.collection.backgroundColor = [SSAutoresizeLabelFlowConfig shareConfig].backgroundColor;
    self.collection.allowsMultipleSelection = YES;
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.collection registerClass:[SSAutoresizeLabelFlowCell class] forCellWithReuseIdentifier:cellId];
    [self addSubview:self.collection];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SSAutoresizeLabelFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
    [cell configCellWithTitle:self.data[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.handler) {
        NSUInteger index = indexPath.item;
        NSString *title = self.data[index];
        self.handler(index,title);
    }
}

- (NSString *)titleForLabelAtIndexPath:(NSIndexPath *)indexPath {
    return self.data[indexPath.item];
}

- (void)layoutFinishWithNumberOfline:(NSInteger)number {
    static NSInteger numberCount;
    if (numberCount == number) {
        return;
    }
    numberCount = number;
    SSAutoresizeLabelFlowConfig*config = [SSAutoresizeLabelFlowConfig shareConfig];
    CGFloat h = config.contentInsets.top+config.contentInsets.bottom+config.itemHeight*number+config.lineSpace*(number-1);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, h);
    [UIView animateWithDuration:0.2 animations:^{
        self.collection.frame = self.bounds;
    }];
}

- (void)insertLabelWithTitle:(NSString *)title atIndex:(NSUInteger)index animated:(BOOL)animated {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.data insertObject:title atIndex:index];
    [self performBatchUpdatesWithAction:UICollectionUpdateActionInsert indexPaths:@[indexPath] animated:animated];
}

- (void)insertLabelsWithTitles:(NSArray *)titles atIndexes:(NSIndexSet *)indexes animated:(BOOL)animated {
    NSArray *indexPaths = [self indexPathsWithIndexes:indexes];
    [self.data insertObjects:titles atIndexes:indexes];
    [self performBatchUpdatesWithAction:UICollectionUpdateActionInsert indexPaths:indexPaths animated:animated];
}

- (void)deleteLabelAtIndex:(NSUInteger)index animated:(BOOL)animated {
    [self deleteLabelsAtIndexes:[NSIndexSet indexSetWithIndex:index] animated:animated];
}

- (void)deleteLabelsAtIndexes:(NSIndexSet *)indexes animated:(BOOL)animated {
    NSArray *indexPaths = [self indexPathsWithIndexes:indexes];
    [self.data removeObjectsAtIndexes:indexes];
    [self performBatchUpdatesWithAction:UICollectionUpdateActionDelete indexPaths:indexPaths animated:animated];
}

- (void)reloadAllWithTitles:(NSArray *)titles {
    self.data = [titles mutableCopy];
    [self.collection reloadData];
}

- (void)performBatchUpdatesWithAction:(UICollectionUpdateAction)action indexPaths:(NSArray *)indexPaths animated:(BOOL)animated {
    if (!animated) {
        [UIView setAnimationsEnabled:NO];
    }
    [self.collection performBatchUpdates:^{
        switch (action) {
            case UICollectionUpdateActionInsert:
                [self.collection insertItemsAtIndexPaths:indexPaths];
                break;
            case UICollectionUpdateActionDelete:
                [self.collection deleteItemsAtIndexPaths:indexPaths];
            default:
                break;
        }
    } completion:^(BOOL finished) {
        if (!animated) {
            [UIView setAnimationsEnabled:YES];
        }
    }];
}

- (NSArray *)indexPathsWithIndexes:(NSIndexSet *)set {
    NSMutableArray *indexPaths = [NSMutableArray arrayWithCapacity:set.count];
    [set enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:idx inSection:0];
        [indexPaths addObject:indexPath];
    }];
    return [indexPaths copy];
}

@end
