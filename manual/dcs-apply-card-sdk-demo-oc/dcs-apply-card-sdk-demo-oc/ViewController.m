//
//  ViewController.m
//  dcs-apply-card-sdk-demo-oc
//
//  Created by Ran on 2025/3/18.
//

#import "ViewController.h"
#import <DcsCardSdk/DCSCard.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *orgCode;
@property (weak, nonatomic) IBOutlet UITextField *orgKey;
@property (weak, nonatomic) IBOutlet UITextField *areaCode;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (strong, nonatomic) NSString *authen;
@property (weak, nonatomic) IBOutlet UITextView *logView;
@property (nonatomic, strong) NSMutableString *logText;
@property (weak, nonatomic) IBOutlet UITextField *userId;
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *gender;
@property (weak, nonatomic) IBOutlet UITextField *birthDate;
@property (weak, nonatomic) IBOutlet UITextField *nationality;
@property (weak, nonatomic) IBOutlet UITextField *idNo;
@property (weak, nonatomic) IBOutlet UITextField *idType;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *postCode;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *productCode;
@property (weak, nonatomic) IBOutlet UITextField *cardType;
@property (weak, nonatomic) IBOutlet UITextField *cardFlag;
@property (weak, nonatomic) IBOutlet UITextField *partnerID;
@property (weak, nonatomic) IBOutlet UITextField *cardFace;
@property (weak, nonatomic) IBOutlet UITextField *externalWorkflowId;
@property (weak, nonatomic) IBOutlet UITextField *cardToken;
@property (weak, nonatomic) IBOutlet UITextField *environment;
@property (weak, nonatomic) IBOutlet UITextField *custIdToken;

@end

@implementation ViewController

// authorization
- (void)authorization {

    [[DCSCard sharedInstance] authenSdkWithorgCode:self.orgCode.text
                                      orgSecretKey:self.orgKey.text
                                          areaCode:self.areaCode.text
                                       phoneNumber:self.phone.text
                                           bizCode:@"470101"
                                         partnerID:self.partnerID.text
                                    externalUserId:self.userId.text
                                externalWorkflowId:self.externalWorkflowId.text
                                       environment:self.environment.text
                                        completion:^(NSDictionary * _Nonnull responseObject, NSString * _Nonnull error)  {
        // responseObject.code explain
        // 0x00 Submitted successfully
        // 0x01 User exit
        // 0x02 Login Failure
        // 0x03 unknown error
        // 0x04 No authorization information obtained
        // 0x05 Missing parameters
        // 0x06 API call failed
        if (![responseObject[@"data"] isKindOfClass:[NSString class]] && responseObject[@"data"] != nil) {
            NSString *authen = responseObject[@"data"][@"accessToken"];
            if (authen != nil && ![authen isEqualToString:@""]) {
                self.authen = authen;
            }
        }
        if (error != nil) {
            [self log:@{@"error":error}];
        } else {
            [self log:responseObject];
        }
        
    }];
}

// Apply Card
- (void)startApply {
        
    if (self.authen == nil) {
        [self log:@{@"tip":@"Please click on the authorization application to obtain the token first"}];
        return;
    }
    
    [[DCSCard sharedInstance] goApplyforCardbizType:@"D001"
                                            bizCode:@"470102"
                                        accessToken:self.authen
                                          firstName:self.firstName.text
                                           lastName:self.lastName.text
                                             gender:self.gender.text
                                          birthDate:self.birthDate.text
                                        nationality:self.nationality.text
                                             idType:self.idType.text
                                               idNo:self.idNo.text
                                            address:self.address.text
                                           postCode:self.postCode.text
                                              email:self.email.text
                                        productInfo:@[@{@"productCode":self.productCode.text,@"cardType":self.cardType.text,@"cardFace":self.cardFace.text, @"cardFlag":self.cardFlag.text}]
                                          partnerID:self.partnerID.text
                                 externalWorkflowId:self.externalWorkflowId.text
                                        environment:self.environment.text
                                         completion:^(NSDictionary * _Nonnull responseObject, NSString * _Nonnull error) {
        if (error != nil) {
            [self log:@{@"error":error}];
        } else {
            [self log:responseObject];
        }
    }];
}

// Card progress query
- (void)cardProgress {
    
    if (self.authen == nil) {
        [self log:@{@"tip":@"Please click on the authorization application to obtain the token first"}];
        return;
    }
    [[DCSCard sharedInstance] cardProgressInquirybizType:@"D002"
                                                 bizCode:@"470102"
                                             accessToken:self.authen
                                      externalWorkflowId:self.externalWorkflowId.text        environment:self.environment.text
                                           completion:^(NSDictionary * _Nonnull responseObject, NSString * _Nonnull error) {
        
        if (error != nil) {
            [self log:@{@"error":error}];
        } else {
            [self log:responseObject];
        }
    }];
}

// Rest PIN
- (void)goToRestPIN {
    
    if (self.authen == nil) {
        [self log:@{@"tip":@"Please click on the authorization application to obtain the token first"}];
        return;
    }
    
    [[DCSCard sharedInstance] restPinForbizType:@"D007"
                                        bizCode:@"470102"
                                    accessToken:self.authen
                                      cardToken:self.cardToken.text
                                    custIdToken:self.custIdToken.text
                             externalWorkflowId:self.externalWorkflowId.text
                                    environment:self.environment.text
                                     completion:^(NSDictionary * _Nonnull responseObject, NSString * _Nonnull error) {
            
        if (error != nil) {
            [self log:@{@"error":error}];
        } else {
            [self log:responseObject];
        }
        }];
}

- (IBAction)selectTypeClick:(id)sender {
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"please select the type" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *authorization = [UIAlertAction actionWithTitle:@"Authorization" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self authorization];
    }];
    
    UIAlertAction *application = [UIAlertAction actionWithTitle:@"Apply Card" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self startApply];
    }];
    
    UIAlertAction *cardProgress = [UIAlertAction actionWithTitle:@"Card Progress" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cardProgress];
    }];
    
    UIAlertAction *restPin = [UIAlertAction actionWithTitle:@"Rest Pin" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self goToRestPIN];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alertVc addAction:authorization];
    [alertVc addAction:application];
    [alertVc addAction:cardProgress];
    [alertVc addAction:restPin];
    [alertVc addAction:cancel];
    [self presentViewController:alertVc animated:YES completion:nil];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.logText = [NSMutableString string];
    self.userId.text = [NSString stringWithFormat:@"%@-01",self.orgCode.text];
    [self.orgCode addTarget:self action:@selector(userIdChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(assignKeyboard)]];
}

-(void)userIdChange:(UITextField *)textField{
    self.userId.text = [NSString stringWithFormat:@"%@-01",textField.text];
}

- (void)log:(NSDictionary *)res {
    
    NSString *JSONString;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:res
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    if (!jsonData) {
        JSONString = @"Error converting to jsonString";
    } else {
        JSONString  = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    [_logText appendString:@"=======================\n"];
    [_logText appendString:JSONString];
    [_logText appendString:@"\n\n"];
    
    [_logView setText:_logText];
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.logView setText:self.logText];
        CGFloat originY = self.logView.contentSize.height > self.logView.bounds.size.height ? self.logView.contentSize.height - self.logView.bounds.size.height : 0;
        [self.logView setContentOffset:CGPointMake(0, originY) animated:YES];
    }];
    
}

- (IBAction)clearLog:(id)sender {
    
    [_logText setString:@""];
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self.logView setText:self.logText];
        CGFloat originY = self.logView.contentSize.height > self.logView.bounds.size.height ? self.logView.contentSize.height - self.logView.bounds.size.height : 0;
        [self.logView setContentOffset:CGPointMake(0, originY) animated:YES];
    }];
}

- (void)assignKeyboard {
    [self.view endEditing:YES];
}

@end
