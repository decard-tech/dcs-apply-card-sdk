//
//  DCSCard.h
//  DcsCardSdk
//
//  Created by Lph on 2023/11/2.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DCSCard : NSObject
/**
 Sdk initialize
 */
+ (instancetype)sharedInstance;

/**
 Authorization service
 
 @param orgCode Organization number
 @param orgSecretKey  Mechanism key
 @param areaCode   Area code
 @param phoneNumber   Phone number
 @param bizCode   bizCode
 @param partnerID   partnerID
 @param externalUserId externalUserId
 @param externalWorkflowId externalWorkflowId
 @param environment environment
 @param completion   callback
 responseObject includes service success and error failure messages
 */

- (void)authenSdkWithorgCode:(NSString *)orgCode
                orgSecretKey:(NSString *)orgSecretKey
                    areaCode:(NSString *)areaCode
                 phoneNumber:(NSString *)phoneNumber
                     bizCode:(NSString *)bizCode
                   partnerID:(NSString *)partnerID
              externalUserId:(NSString *)externalUserId
          externalWorkflowId:(NSString *)externalWorkflowId
                 environment:(NSString *)environment
                  completion:(void (^)(NSDictionary *responseObject, NSString *error))completion;
/**
 Card service
 
 @param bizType Invoke different services based on the bizType
 @param bizCode bizCode
 @param accessToken Token
 @param firstName firstName
 @param lastName lastName
 @param gender gender
 @param birthDate birthDate
 @param nationality nationality
 @param idType idType
 @param idNo idNo
 @param address address
 @param postCode postCode
 @param email email
 @param productInfo  Includes parameters (String Json type)[@"productCode":@"", @"cardType":@"", @"cardFace":@""@"cardFlag", @""]
 @param partnerID partnerID
 @param externalWorkflowId externalWorkflowId
 @param environment environment
 @param completion   callback
 responseObject includes service success and error failure messages
 */
- (void)goApplyforCardbizType:(NSString *)bizType
                      bizCode:(NSString *)bizCode
                  accessToken:(NSString *)accessToken
                    firstName:(NSString *)firstName
                     lastName:(NSString *)lastName
                       gender:(NSString *)gender
                    birthDate:(NSString *)birthDate
                  nationality:(NSString *)nationality
                       idType:(NSString *)idType
                         idNo:(NSString *)idNo
                      address:(NSString *)address
                     postCode:(NSString *)postCode
                        email:(NSString *)email
                  productInfo:(NSArray *)productInfo
                    partnerID:(NSString *)partnerID
           externalWorkflowId:(NSString *)externalWorkflowId
                  environment:(NSString *)environment
                   completion:(void (^)(NSDictionary *responseObject, NSString *error))completion;


/**
 Card progress service
 
 @param bizType bizType
 @param bizCode  bizCode
 @param accessToken  Token
 @param externalWorkflowId externalWorkflowId
 @param environment environment
 */
- (void)cardProgressInquirybizType:(NSString *)bizType
                           bizCode:(NSString *)bizCode
                       accessToken:(NSString *)accessToken
                externalWorkflowId:(NSString *)externalWorkflowId
                       environment:(NSString *)environment
                        completion:(void (^)(NSDictionary *responseObject, NSString *error))completion;

/**
 Rest PIN
 
 @param bizType bizType
 @param bizCode  bizCode
 @param accessToken  Token
 @param cardToken  cardToken
 @param custIdToken  custIdToken
 @param externalWorkflowId externalWorkflowId
 @param environment environment
 */
- (void)restPinForbizType:(NSString *)bizType
                           bizCode:(NSString *)bizCode
                       accessToken:(NSString *)accessToken
                         cardToken:(NSString *)cardToken
                       custIdToken:(NSString *)custIdToken
                externalWorkflowId:(NSString *)externalWorkflowId
                       environment:(NSString *)environment
                        completion:(void (^)(NSDictionary *responseObject, NSString *error))completion;

/**
 Scheme callback
 
 @param params Callback URL
 The callback needs to be set in AppDelegate.m/SceneDelegate.m
 */
- (void)setURLParams:(NSURL *)params;
@end

NS_ASSUME_NONNULL_END
