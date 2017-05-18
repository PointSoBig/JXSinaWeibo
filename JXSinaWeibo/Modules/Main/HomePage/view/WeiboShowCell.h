//
//  WeiboShowCell.h
//  JXSinaWeibo
//
//  Created by 景晓峰 on 16/9/26.
//  Copyright © 2016年 JX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WbListCellType) {
    WbBaseCellTypeMine_Text = 0,
    WbBaseCellTypeMine_TextRetweet,
    
    WbBaseCellTypeMine_Imgs,
    WbBaseCellTypeMine_ImgsRetweet,
    
    WbBaseCellTypeMine_Video,
    WbBaseCellTypeMine_VideoRetweet,
    
    WbBaseCellTypeOyher_Text,
    WbBaseCellTypeOther_TextRetweet,
    
    WbBaseCellTypeOther_Imgs,
    WbBaseCellTypeOther_ImgsRetweet,
    
    WbBaseCellTypeOther_Video,
    WbBaseCellTypeOther_VideoRetweet,
};

@interface WeiboShowCell : UITableViewCell

@property (nonatomic,assign)WbListCellType type;



@end
