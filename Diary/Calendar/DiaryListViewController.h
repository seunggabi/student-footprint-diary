//
//  DiaryListViewController.h
//  Diary
//
//  Created by mju on 2016. 7. 10..
//  Copyright © 2016년 mju12345. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../Model/Diary.h"
#import "../Model/DiaryModel.h"
#import "DiaryViewController.h"
#import "DiaryEditViewController.h"

@interface DiaryListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate >
{
    
}


@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (strong, nonatomic) IBOutlet UITextField *sDateText;
@property (strong, nonatomic) IBOutlet UITextField *eDateText;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *showDiaryList;

@property (strong, nonatomic) DiaryModel *modelDiary;
@property (strong, nonatomic) Diary *diary;
@property (weak, nonatomic) IBOutlet UITextField *startDate;
@property (weak, nonatomic) IBOutlet UITextField *endDate;
@property (strong, nonatomic) NSMutableArray *diaryList;
@property (strong, nonatomic) NSMutableArray *sticker;
@property (retain, nonatomic) IBOutlet UITableView  *table;
@property (weak, nonatomic) IBOutlet UIButton *buttonPressed;
@property (strong, nonatomic) IBOutlet UITextField *tempText;

- (IBAction)showDiaryList:(UIButton *)sender;
- (IBAction)touchSDate:(id)sender;
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;

-(NSMutableArray *)loadDiaryListData:(NSString *)sDate endDate:(NSString *)eDate;


@end
