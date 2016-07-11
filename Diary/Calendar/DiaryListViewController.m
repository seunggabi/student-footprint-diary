//
//  DairyListViewController.m
//  Diary
//
//  Created by mju on 2016. 7. 10..
//  Copyright © 2016년 mju12345. All rights reserved.
//

#import "DiaryListViewController.h"

@interface DiaryListViewController ()

@end

@implementation DiaryListViewController
@synthesize table;
@synthesize diary;
@synthesize modelDiary;
@synthesize sDateText;
@synthesize eDateText;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    modelDiary = [[DiaryModel alloc] init];
    [modelDiary create];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [table reloadData];
}

- (IBAction)showDiaryList:(id)sender {
    [self loadDiaryListData:sDateText.text endDate:eDateText.text];
}

-(NSMutableArray *)loadDiaryListData:(NSString *)sDate endDate:(NSString *)eDate{
    diary = [[Diary alloc] init];
    int startDate = 0;
    int endDate = 0;
    NSMutableArray *diaryModel = [modelDiary select:nil];
    NSMutableArray *searchModel = [[NSMutableArray alloc] init];
 
    for(int i = 0; i<diaryModel.count; i++){
        if([[diaryModel objectAtIndex:i] d_date] == sDate){
           startDate = i;
        }
    }
    for(int i = 0; i<diaryModel.count; i++){
        if([[diaryModel objectAtIndex:i] d_date] == eDate){
            endDate = i;
        }
    }
    for(int i = startDate; i<endDate; i++){
       searchModel = [[diaryModel objectAtIndex:i] copy];
    }
    return searchModel;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

//Return number row in table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray * searchModel = [self loadDiaryListData:sDateText.text endDate:eDateText.text];
    //Count object of array
    return searchModel.count;
}

//Return height of row
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

//Load note to table view
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableArray *diaryModel = [modelDiary select:nil];
    NSLog(@"content %@", [[diaryModel objectAtIndex:1] d_content]);
    //New cell
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //Load image for background cell
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    background.image = [UIImage imageNamed:@"cell_background.png"];
    [cell addSubview:background];//Add background to cell
    
    //Set icon note on every cell
    UIImageView *iconNote = [[UIImageView alloc] initWithFrame:CGRectMake(12, 10, 30, 30)];
    iconNote.image = [UIImage imageNamed:@"icon_file.png"];
    [cell addSubview:iconNote];//Add incon note to cell
    
    //Set title note on cell
    UILabel *lblTitleNote = [[UILabel alloc] initWithFrame:CGRectMake(47, 7, 185, 36)];
    [lblTitleNote setFont:[UIFont boldSystemFontOfSize:13]];
    cell.textLabel.text = [[diaryModel objectAtIndex:indexPath.row] d_content];//@"My Note sample for this";
    [lblTitleNote setBackgroundColor:[UIColor clearColor]];
    [cell addSubview:lblTitleNote];//Add title note to cell
    
    //Set time string for note
    UILabel *lblDateTime = [[UILabel alloc] initWithFrame:CGRectMake(238, 7, 80, 36)];
    [lblDateTime setFont:[UIFont systemFontOfSize:13]];
    cell.detailTextLabel.text = [[diaryModel objectAtIndex:indexPath.row] d_date];//@"2013.09.14";
    [lblDateTime setBackgroundColor:[UIColor clearColor]];
    lblDateTime.textAlignment = UITextAlignmentRight;
    [cell addSubview:lblDateTime];//Add time to cell
    
    //Return a cell
    return cell;
}

//Go to detail current note
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Set status can select for cell of table
    [table deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"didSelectRowAtIndexPath");
    //Get array of note
    diary = [[Diary alloc] init];
    NSMutableArray *diaryModel = [modelDiary select:nil];
    //create new view
    DiaryViewController *diaryView =  [[DiaryViewController alloc] initWithNibName:@"DiaryViewController" bundle:nil];
    NSMutableArray *dataMutableArray = [[NSUserDefaults standardUserDefaults]mutableArrayValueForKey:@"diary"];
    //create new view
    
    //set object of current note
    diaryView.dicArray = [dataMutableArray objectAtIndex:indexPath.row];
    diaryView.indexNumber = indexPath.row;
   
//    diaryView.diary = [diaryModel objectAtIndex:indexPath.row];
//    diaryView.indexNumber = indexPath.row;
    //Go to new view
    [self presentViewController:diaryView animated:YES completion:nil];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
