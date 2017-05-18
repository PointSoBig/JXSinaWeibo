//
//  WbBaseCell.m
//  JXSinaWeibo
//
//  Created by 景晓峰 on 2017/5/18.
//  Copyright © 2017年 JX. All rights reserved.
//

#import "WbBaseCell.h"

@implementation WbBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
