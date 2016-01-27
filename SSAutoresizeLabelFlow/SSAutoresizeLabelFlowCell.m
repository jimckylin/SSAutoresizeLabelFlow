//
//  SSAutoresizeLabelFlowCell.m
//  SSAutoresizeLabelFlow
//
//  Created by Mrss on 16/1/25.
//  Copyright © 2016年 expai. All rights reserved.
//

#import "SSAutoresizeLabelFlowCell.h"
#import "SSAutoresizeLabelFlowConfig.h"

@interface SSAutoresizeLabelFlowCell ()

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation SSAutoresizeLabelFlowCell

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.backgroundColor = [SSAutoresizeLabelFlowConfig shareConfig].itemColor;
        _titleLabel.textColor = [SSAutoresizeLabelFlowConfig shareConfig].textColor;
        _titleLabel.font = [SSAutoresizeLabelFlowConfig shareConfig].textFont;
        _titleLabel.layer.cornerRadius = [SSAutoresizeLabelFlowConfig shareConfig].itemCornerRaius;
        _titleLabel.layer.masksToBounds = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)configCellWithTitle:(NSString *)title {
    self.titleLabel.frame = self.bounds;
    self.titleLabel.text = title;
}

@end
