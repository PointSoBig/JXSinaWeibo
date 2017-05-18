//
//  WbBaseCell.h
//  JXSinaWeibo
//
//  Created by 景晓峰 on 2017/5/18.
//  Copyright © 2017年 JX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WbBaseCellType) {
    WbBaseCellTypeMine = 0,
    WbBaseCellTypeOther
};

@interface WbBaseCell : UITableViewCell

@property (nonatomic,assign) WbBaseCellType type;

@end
