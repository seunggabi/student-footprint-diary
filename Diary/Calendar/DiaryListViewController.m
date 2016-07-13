//
//  DiaryListViewController.m
//  Diary
//
//  Created by mju on 2016. 7. 10..
//  Copyright © 2016년 mju12345. All rights reserved.
//

#import "DiaryListViewController.h"

@interface DiaryListViewController () <UITextFieldDelegate>

@end

@implementation DiaryListViewController

@synthesize table;
@synthesize diary;
@synthesize sDateText;
@synthesize eDateText;
@synthesize tempText;
@synthesize datePicker;
@synthesize datePickerScreen;
@synthesize modelDiary;

-(void)viewDidLoad {
    [super viewDidLoad];
    
    modelDiary = [[DiaryModel alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.date = [NSDate date];
    [datePicker addTarget:self action:@selector(changeDatePicker) forControlEvents:UIControlEventValueChanged];
    datePickerScreen.hidden = YES;
    
    sDateText.delegate = self;
    eDateText.delegate = self;
}

-(void)changeDatePicker{
    tempText.text = [[HelperTool getInstance] dateToString:datePicker.date];
    [tempText setNeedsDisplay];
}
                           
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [table reloadData];
}

-(IBAction)showDiaryList:(id)sender {
    [self loadDiaryListData:sDateText.text endDate:eDateText.text];
    
}

-(IBAction)touchDate:(id)sender {
    datePickerScreen.hidden = NO;
    tempText = sender;
    tempText.text = [[HelperTool getInstance] dateToString:datePicker.date];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSMutableArray * searchModel = [self loadDiaryListData:sDateText.text endDate:eDateText.text];
    return searchModel.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableArray *diaryModel = [modelDiary select:nil];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    background.image = [UIImage imageNamed:@"cell_background.png"];
    [cell addSubview:background];
    
    UILabel *lblTitleNote = [[UILabel alloc] initWithFrame:CGRectMake(47, 7, 185, 36)];
    [lblTitleNote setFont:[UIFont boldSystemFontOfSize:13]];
 //   lblTitleNote.text = ((Diary *)[diaryModel objectAtIndex:indexPath.row]).d_content;
    [lblTitleNote setBackgroundColor:[UIColor clearColor]];
    [cell addSubview:lblTitleNote];
    
    UILabel *lblDateTime = [[UILabel alloc] initWithFrame:CGRectMake(238, 7, 80, 36)];
    [lblDateTime setFont:[UIFont systemFontOfSize:13]];
//    lblDateTime.text = ((Diary *)[diaryModel objectAtIndex:indexPath.row]).d_date;
    [lblDateTime setBackgroundColor:[UIColor clearColor]];
    lblDateTime.textAlignment = UITextAlignmentRight;
    [cell addSubview:lblDateTime];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [table deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"didSelectRowAtIndexPath");
    diary = [[Diary alloc] init];
    NSMutableArray *diaryList = [modelDiary select:nil];
    DiaryViewController *diaryView = [[DiaryViewController alloc] initWithNibName:@"DiaryViewController" bundle:nil];
    
    [self presentViewController:diaryView animated:YES completion:nil];
}

@end
