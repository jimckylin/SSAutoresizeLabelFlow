//
//  SSAutoresizeLabelFlowLayout.h
//  SSAutoresizeLabelFlow
//
//  Created by Mrss on 16/1/25.
//  Copyright © 2016年 expai. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SSAutoresizeLabelFlowLayoutDelegate <NSObject>

- (void)layoutFinishWithNumberOfline:(NSInteger)number;

@end

@protocol SSAutoresizeLabelFlowLayoutDataSource <NSObject>

- (NSString *)titleForLabelAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface SSAutoresizeLabelFlowLayout : UICollectionViewFlowLayout

@property (nonatomic,weak) id <SSAutoresizeLabelFlowLayoutDataSource> dataSource;
@property (nonatomic,weak) id <SSAutoresizeLabelFlowLayoutDelegate> delegate;

@end
