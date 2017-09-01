//
//  SendComTableViewCell.h
//  NearBusiness
//
//  Created by lingnet on 2017/9/1.
//  Copyright © 2017年 YouCanCallMeAndy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XRQTextview.h"
@protocol AdvancedExpandableTableViewDelegate <UITableViewDelegate, UITextViewDelegate>

@required
- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath;

@optional
- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(UITableView *)tableView textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)tableView:(UITableView *)tableView textViewDidChangeSelection:(UITextView*)textView;
- (void)tableView:(UITableView *)tableView textViewDidEndEditing:(UITextView*)textView;
@end
@interface SendComTableViewCell : UITableViewCell
@property (nonatomic) XRQTextview *textView;
@property (nonatomic, weak) UITableView *expandableTableView;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *placeholder;

@property (nonatomic) CGFloat cellHeight;

@property (nonatomic) int  maxCharacter;

@property(nonatomic,weak)id<AdvancedExpandableTableViewDelegate>DailyNew0TableViewCellDelegate;

- (void)setText:(NSString*)text;

@end
@interface UITableView (AdvancedExpandableTextCell)

- (SendComTableViewCell *)advancedExpandableTextCellWithId:(NSString*)cellId;
@end
