//
//  XCZWorkDetailViewController.m
//  xcz
//
//  Created by 刘志鹏 on 14-6-30.
//  Copyright (c) 2014年 Zhipeng Liu. All rights reserved.
//

#import "XCZWorkDetailViewController.h"
#import "XCZUtils.h"

@interface XCZWorkDetailViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *authorTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *titleField;
@property (weak, nonatomic) IBOutlet UILabel *authorField;
@property (weak, nonatomic) IBOutlet UILabel *contentField;
@property (weak, nonatomic) IBOutlet UILabel *introField;

@end

@implementation XCZWorkDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    XCZWork *work = self.work;
    
    // 标题
    NSMutableParagraphStyle *titleParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    titleParagraphStyle.lineHeightMultiple = 1.1;
    titleParagraphStyle.alignment = NSTextAlignmentCenter;
    self.titleField.attributedText = [[NSAttributedString alloc] initWithString:work.title attributes:@{NSParagraphStyleAttributeName: titleParagraphStyle}];
    
    // 作者
    self.authorField.text = [[NSString alloc] initWithFormat:@"[%@] %@", work.dynasty, work.author];
    
    // 内容
    NSMutableParagraphStyle *contentParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    // 缩进排版
    if ([self.work.layout isEqual: @"indent"]) {
        contentParagraphStyle.firstLineHeadIndent = 25;
        contentParagraphStyle.paragraphSpacing = 15;
        contentParagraphStyle.lineHeightMultiple = 1.3;
        self.contentField.preferredMaxLayoutWidth = [XCZUtils currentWindowWidth] - 30;
    // 居中排版
    } else {
        contentParagraphStyle.alignment = NSTextAlignmentCenter;
        contentParagraphStyle.paragraphSpacing = 0;
        contentParagraphStyle.lineHeightMultiple = 1;
        self.authorTopConstraint.constant = 15;
        self.contentField.preferredMaxLayoutWidth = [XCZUtils currentWindowWidth] - 20;
    }
    contentParagraphStyle.paragraphSpacing = 10;
    self.contentField.attributedText = [[NSAttributedString alloc] initWithString:work.content attributes:@{NSParagraphStyleAttributeName: contentParagraphStyle}];
    
    // 题解
    NSMutableParagraphStyle *introParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    introParagraphStyle.lineHeightMultiple = 1.3;
    self.introField.attributedText = [[NSAttributedString alloc] initWithString:work.intro attributes:@{NSParagraphStyleAttributeName: introParagraphStyle}];
    
    // 设置UILabel的preferredMaxLayoutWidth，以保证正确的换行长度
    self.titleField.preferredMaxLayoutWidth = [XCZUtils currentWindowWidth] - 30;
    self.introField.preferredMaxLayoutWidth = [XCZUtils currentWindowWidth] - 30;
    NSLog(@"%lu", (unsigned long)self.view.bounds.size.width);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
