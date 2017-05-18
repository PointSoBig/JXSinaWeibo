//
//  WeiboShowCell.m
//  JXSinaWeibo
//
//  Created by 景晓峰 on 16/9/26.
//  Copyright © 2016年 JX. All rights reserved.
//

#import "WeiboShowCell.h"

@implementation WeiboShowCell

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
    //自己的微博 会有顶部视图模块
    UIView *mineWbTopView= [UIView new];
    [self addSubview:mineWbTopView];
    [mineWbTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@0);
        make.height.equalTo(@40);
    }];
    
    UILabel *issueStatusLab = [UILabel new];
    issueStatusLab.text = @"公开";
    [mineWbTopView addSubview:issueStatusLab];
    [issueStatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.centerY.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(60, 17));
    }];
    
    UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [actionBtn setTitle:@"我的微博按钮" forState:UIControlStateNormal];
    [mineWbTopView addSubview:actionBtn];
    [actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.centerY.equalTo(issueStatusLab.mas_centerY);
        make.height.equalTo(issueStatusLab.mas_height);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor grayColor];
    [mineWbTopView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.bottom.equalTo(@-1);
        make.height.equalTo(@0.5);
    }];
    
    //博主头像,名字信息视图模块
    UIView *userInfoView = [UIView new];
    [self addSubview:userInfoView];
    [userInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(mineWbTopView.mas_bottom);
        make.height.equalTo(@60);
    }];
    
    UIImageView *iconImgView = [UIImageView new];
    iconImgView.backgroundColor = [UIColor greenColor];
    [userInfoView addSubview:iconImgView];
    [iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@10);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    UILabel *nameLab = [UILabel new];
    nameLab.text = @"随手赞促和谐";
    [userInfoView addSubview:nameLab];
    [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImgView.mas_right).offset(15);
        make.top.equalTo(iconImgView.mas_top);
        make.height.equalTo(@20);
    }];
    
    UILabel *htmlLab = [UILabel new];
    NSString * htmlString = @"<a href=\"http://app.weibo.com/t/feed/6vtZb0\" rel=\"nofollow\">微博 weibo.com</a>";
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    htmlLab.attributedText = attrStr;
    [userInfoView addSubview:htmlLab];
    [htmlLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLab.mas_left);
        make.top.equalTo(nameLab.mas_bottom).offset(10);
        make.height.equalTo(@10);
    }];
    
    UIButton *readedCountBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [readedCountBtn setTitle:@"阅读:60" forState:UIControlStateNormal];
    [userInfoView addSubview:readedCountBtn];
    [readedCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@-20);
        make.top.equalTo(@20);
        make.height.equalTo(@20);
    }];
    
    //微博文字内容
    CGFloat contentHeight = [self getHeightWithText:@"但我对你打底裤大大大多人让你乖乖女快女女人哦哦扣扣扣啊那啊啊啊啛啛喳喳错错寻寻啊啊啊啊啊错寻寻寻寻"];
    
    UILabel *contentLab = [UILabel new];
    contentLab.numberOfLines = 0;
    contentLab.text = @"但我对你打底裤大大大多人让你乖乖女快女女人哦哦扣扣扣啊那啊啊啊啛啛喳喳错错寻寻啊啊啊啊啊错寻寻寻寻";
    [self addSubview:contentLab];
    [contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.top.equalTo(userInfoView.mas_bottom).offset(15);
        make.height.equalTo(@(contentHeight));
    }];
    
    UIView *mediaView = [UIView new];
    [self addSubview:mediaView];
    [mediaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@-20);
        make.top.equalTo(@15);
        make.height.equalTo(@150);
    }];
    
    UIView *reTweetView = [UIView new];
    reTweetView.backgroundColor = [UIColor grayColor];
    [self addSubview:reTweetView];
    [reTweetView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(mediaView.mas_bottom).offset(15);
        make.height.equalTo(@250);
    }];
    
    //底部三个按钮视图
    UIView *btnsView = [UIView new];
    [self addSubview:btnsView];
    [btnsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(mediaView.mas_bottom).offset(15);
        make.bottom.equalTo(@0);
        make.height.equalTo(@60);
    }];
    
    UIView *bottomLineView = [UIView new];
    bottomLineView.backgroundColor = [UIColor grayColor];
    [btnsView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(@0);
        make.top.equalTo(@0);
        make.height.equalTo(@0.5);
    }];
    
    NSArray *titleArr = @[@"转发",@"评论",@"赞"];
    NSArray *imgArr = @[@"mine_select",@"msg_select",@"discover_select"];
    for (int i = 0; i<3; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn setTitle:<#(nullable NSString *)#> forState:<#(UIControlState)#>
    }
    
}

- (CGFloat)getHeightWithText:(NSString *)text
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(SCREEN_W-40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.0]} context:nil];
    return rect.size.height;
}

@end
