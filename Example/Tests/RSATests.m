//
//  RSAObjCTests.m
//  RSAObjCTests
//
//  Created by 李飞 on 08/24/2019.
//  Copyright (c) 2019 李飞. All rights reserved.
//

@import XCTest;
#import "RSAObjC.h"

static NSString *g1024Pubkey = @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDTbZ6cNH9PgdF60aQKveLz3FTalyzHQwbp601y77SzmGHX3F5NoVUZbdK7UMdoCLK4FBziTewYD9DWvAErXZo9BFuI96bAop8wfl1VkZyyHTcznxNJFGSQd/B70/ExMgMBpEwkAAdyUqIjIdVGh1FQK/4acwS39YXwbS+IlHsPSQIDAQAB";
static NSString *g1024Privkey = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBANNtnpw0f0+B0XrRpAq94vPcVNqXLMdDBunrTXLvtLOYYdfcXk2hVRlt0rtQx2gIsrgUHOJN7BgP0Na8AStdmj0EW4j3psCinzB+XVWRnLIdNzOfE0kUZJB38HvT8TEyAwGkTCQAB3JSoiMh1UaHUVAr/hpzBLf1hfBtL4iUew9JAgMBAAECgYA1tGeQmAkqofga8XtwuxEWDoaDS9k0+EKeUoXGxzqoT/GyiihuIafjILFhoUA1ndf/yCQaG973sbTDhtfpMwqFNQq13+JAownslTjWgr7Hwf7qplYW92R7CU0v7wFfjqm1t/2FKU9JkHfaHfb7qqESMIbO/VMjER9o4tEx58uXDQJBAO0O4lnWDVjr1gN02cqvxPOtTY6DgFbQDeaAZF8obb6XqvCqGW/AVms3Bh8nVlUwdQ2K/xte8tHxjW9FtBQTLd8CQQDkUncO35gAqUF9Bhsdzrs7nO1J3VjLrM0ITrepqjqtVEvdXZc+1/UrkWVaIigWAXjQCVfmQzScdbznhYXPz5fXAkEAgB3KMRkhL4yNpmKRjhw+ih+ASeRCCSj6Sjfbhx4XaakYZmbXxnChg+JB+bZNz06YBFC5nLZM7y/n61o1f5/56wJBALw+ZVzE6ly5L34114uG04W9x0HcFgau7MiJphFjgUdAtd/H9xfgE4odMRPUD3q9Me9LlMYK6MiKpfm4c2+3dzcCQQC8y37NPgpNEkd9smMwPpSEjPW41aMlfcKvP4Da3z7G5bGlmuICrva9YDAiaAyDGGCK8LxC8K6HpKrFgYrXkRtt";

static NSString *g2048Pubkey = @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAwrdbN5s9g+xH0s4HeKWQjdFqc0q0tNToKilzGGm/fL/wtbhXRKSdcWsS1OVr7U6fzlMwgerPIbXJQsgrAZTgMzryaHGTOnH5gTNeB6gcSNYCr0E57w9RnX9010NkJPzHGl375QiqyVs20d5rk3dcQTCPopDqF72cu6Vysbi9ShOeu1HaLC4Yrh8LX5Qo2ytLMMEIXR6/y6yc9X1PZ3INfUqMkleukILif6g1v/KaChXBWUtPkAUiRojPpU+E0YfZSTP/3+iCmUhFimoGnDCyP9OUe1MC3hSVCtg0cSV0oT5BZZvo5rOZzbzMtmLVhjKClgwGzAONZ+VlRLhSUtLiBwIDAQAB";
static NSString *g2048Privkey = @"MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDCt1s3mz2D7EfSzgd4pZCN0WpzSrS01OgqKXMYab98v/C1uFdEpJ1xaxLU5WvtTp/OUzCB6s8htclCyCsBlOAzOvJocZM6cfmBM14HqBxI1gKvQTnvD1Gdf3TXQ2Qk/McaXfvlCKrJWzbR3muTd1xBMI+ikOoXvZy7pXKxuL1KE567UdosLhiuHwtflCjbK0swwQhdHr/LrJz1fU9ncg19SoySV66QguJ/qDW/8poKFcFZS0+QBSJGiM+lT4TRh9lJM//f6IKZSEWKagacMLI/05R7UwLeFJUK2DRxJXShPkFlm+jms5nNvMy2YtWGMoKWDAbMA41n5WVEuFJS0uIHAgMBAAECggEATtHsMdE8kId394SBD7xtjIrl/W+TQNQieta2iX5dDkGgTd8mLFo6hWvjfpy0GKbIF7wjGaQUXr/4jXj7t7MtIm/NKqw2/eSfLEa/3HeXo4BGK+1KZ1QbJJcwk+bqxfIxIqJC0k6027d5tHDFuTcK+DSRICxrJlsR8/+gMwLmVPJxDZdicw9O1S3p3DQfaXEL1IpHgqIVZkAMZDy+WuOKKmQUhc/HwkT3ZBPodNgig1GOiAyduOe/Ema8SuaYsBI3SNetuPUx6uiCI0xQVnC2ocgEa7pUg9Lg9m4GPym7JUOrtGHdnb+D94BTO3cA062ev2rLVKn+Q5LJDCc2P8xf+QKBgQDvjGYfLWeNBg6dv+2+g5OLdgG8E4Zfkgx1FDGCKZXjOkkqHlkijMWZOnjZdBik9UM1eMcnTrxDaYlQDSjBNDBHYM6BusvE0O4F61cpnK2znllpK+z8+cx1kRaCg6+mQ1DeF5mkgmB/TNiZa+24dG8x8FIKXDyrOpUFuT9KVJzRMwKBgQDQFr5qHaXOA3q1/wJ87pHDcGJ8Tkn4hmK1jlDmmGLO9ypFjY3DlmFzwgqFo3TVXh8tUn+a0AelzW9LZHBqXd3TDZtEBxK8VYtnfJS0gAv5Ha7zpI+BVyFLTVaw+ucQI925/4fyMs9lW2E3X++JuEGvVzXag1puDid7H+Tkm2aT3QKBgQDqAdg8+qjejZ03oydHZdd7dDLrnJM2x0BeGvTmN2ORzv1sJKtkYeoh7onhu1TbyC/4i1zZXEPzAqS9y60VV7sV706sUmL+iC8NH0JNhx30imrDn8JpukhuTOaVZrjvDXFxE9Lmbup/UP2CmnlmKG/7c81hC4vEpXywU6+tGAz9GwKBgFUFRe2jiXBAGa4ssD6NVz8sNwElF7IUblZR/JoLHywC7uGWMZr9YXnjiVsK6xyWpVRmRb7iSo2i/1slgYzkJ1MpVwwXe785kIjK7RNG0h2J1Ea2MPAewnq68bXD/g6pKNnrHweFXRnDmVf/uaZig2v5zQYn7xXScK0s3d/N4r59AoGAWIuKd/S1GPmlD8YUba6PZRTQXZqBhdGukawibWwqOla9lki2vXeYslnK70iiEkTH4q7nWswwZylpCdzBi6QkqrMFPf159ChkL0lC5L6pIxPOUMhrlGzKEidIAgqpY40fLzInCrqrnPUyqMAw+HGLxlH7SxtK9BA98KSu06Eec1o=";

@interface Tests : XCTestCase

@property (nonatomic, copy) NSString *derPubKey;         // 1024 位 der 格式公钥
@property (nonatomic, copy) NSString *p12PricKey;        // 1024 位 p12 格式私钥
@property (nonatomic, copy) NSString *g1024PubKeyPath;   // 1024 位公钥文件
@property (nonatomic, copy) NSString *g1024PrivKeyPath;  // 1024 位私钥文件
@property (nonatomic, copy) NSString *g2048PubKeyPath;   // 2048 位公钥文件
@property (nonatomic, copy) NSString *g2048PrivKeyPath;  // 2048 位私钥文件

@end

@implementation Tests

- (void)setUp
{
    [super setUp];
    self.derPubKey = [[NSBundle mainBundle] pathForResource:@"rsa_1024_public_key.der" ofType:nil];
    self.p12PricKey = [[NSBundle mainBundle] pathForResource:@"rsa_1024_private_key.p12" ofType:nil];
    self.g1024PubKeyPath = [[NSBundle mainBundle] pathForResource:@"rsa_1024_public_key.pem" ofType:nil];
    self.g1024PrivKeyPath = [[NSBundle mainBundle] pathForResource:@"rsa_1024_private_key_pkcs8.pem" ofType:nil];
    self.g2048PubKeyPath = [[NSBundle mainBundle] pathForResource:@"rsa_2048_public_key.pem" ofType:nil];
    self.g2048PrivKeyPath = [[NSBundle mainBundle] pathForResource:@"rsa_2048_private_key_pkcs8.pem" ofType:nil];
    XCTAssertNotNil(self.derPubKey, @"秘钥字符串不为空");
    XCTAssertNotNil(self.p12PricKey, @"秘钥字符串不为空");
    XCTAssertNotNil(self.g1024PubKeyPath, @"秘钥字符串不为空");
    XCTAssertNotNil(self.g1024PrivKeyPath, @"秘钥字符串不为空");
    XCTAssertNotNil(self.g2048PubKeyPath, @"秘钥字符串不为空");
    XCTAssertNotNil(self.g2048PrivKeyPath, @"秘钥字符串不为空");
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

/**
 * 测试 RSA 加解密出现空的情况
 */
- (void)testRSANull {
    NSString *strNull = nil;
    NSString *strZero = @"";
    NSString *plaintext = @"123321";
    NSString *enWithStr = [RSAObjC encrypt:plaintext PublicKey:g1024Pubkey];
    XCTAssertNotNil(enWithStr, @"公钥字符串加密结果不为空");
    NSString *enWithFile = [RSAObjC encrypt:plaintext KeyFilePath:self.g1024PubKeyPath];
    XCTAssertNotNil(enWithFile, @"公钥文件加密结果不为空");
    
    // 加密
    NSString *enNullStr = [RSAObjC encrypt:strNull PublicKey:g1024Pubkey];
    XCTAssertNil(enNullStr, @"加密字符串应为空");
    NSString *enNullStrWithFile = [RSAObjC encrypt:strNull KeyFilePath:self.g1024PubKeyPath];
    XCTAssertNil(enNullStrWithFile, @"加密字符串应为空");
    NSString *enZeroStr = [RSAObjC encrypt:strZero PublicKey:g1024Pubkey];
    XCTAssertNil(enZeroStr, @"加密字符串应为空");
    NSString *enZeroStrWithFile = [RSAObjC encrypt:strZero KeyFilePath:self.g1024PubKeyPath];
    XCTAssertNil(enZeroStrWithFile, @"加密字符串应为空");
    NSString *enNullKey = [RSAObjC encrypt:plaintext PublicKey:strNull];
    XCTAssertNil(enNullKey, @"加密字符串应为空");
    NSString *enZeroKey = [RSAObjC encrypt:plaintext PublicKey:strZero];
    XCTAssertNil(enZeroKey, @"加密字符串应为空");
    NSString *enNullPath = [RSAObjC encrypt:plaintext KeyFilePath:strNull];
    XCTAssertNil(enNullPath, @"加密字符串应为空");
    NSString *enZeroPath = [RSAObjC encrypt:plaintext KeyFilePath:strZero];
    XCTAssertNil(enZeroPath, @"加密字符串应为空");
    
    // 解密
    NSString *deNullStr = [RSAObjC decrypt:strNull PrivateKey:g1024Privkey];
    XCTAssertNil(deNullStr, @"解密结果为空");
    NSString *deNullStrWithFile = [RSAObjC decrypt:strNull KeyFilePath:self.g1024PubKeyPath FilePwd:nil];
    XCTAssertNil(deNullStrWithFile, @"解密结果为空");
    NSString *deZeroStr = [RSAObjC decrypt:strZero PrivateKey:g1024Privkey];
    XCTAssertNil(deZeroStr, @"解密结果为空");
    NSString *deZeroStrWithFile = [RSAObjC decrypt:strZero KeyFilePath:self.g1024PubKeyPath FilePwd:nil];
    XCTAssertNil(deZeroStrWithFile, @"解密结果为空");
    NSString *deNullKey = [RSAObjC decrypt:enWithStr PrivateKey:strNull];
    XCTAssertNil(deNullKey, @"解密结果为空");
    NSString *deZeroKey = [RSAObjC decrypt:enWithStr PrivateKey:strZero];
    XCTAssertNil(deZeroKey, @"解密结果为空");
    NSString *deNullPath = [RSAObjC decrypt:enWithFile KeyFilePath:strNull FilePwd:nil];
    XCTAssertNil(deNullPath, @"解密结果为空");
    NSString *deZeroPath = [RSAObjC decrypt:enWithFile KeyFilePath:strZero FilePwd:nil];
    XCTAssertNil(deZeroPath, @"解密结果为空");
}

/**
 * 测试标准字符串格式公私钥加解密
 */
- (void)testRSAString {
    for (NSInteger i = 0; i < 1000; i++) {
        int randLen = arc4random_uniform((int)1000);
        NSString *plaintext = [self randomZhEnString:randLen];
        XCTAssertNotNil(plaintext, @"生成字符串不为空");
        
        NSString *enStr1024 = [RSAObjC encrypt:plaintext PublicKey:g1024Pubkey];
        XCTAssertNotNil(enStr1024, @"加密字符串不为空");
        NSString *enStr2048 = [RSAObjC encrypt:plaintext PublicKey:g2048Pubkey];
        XCTAssertNotNil(enStr2048, @"加密字符串不为空");
        
        NSString *deStr1024 = [RSAObjC decrypt:enStr1024 PrivateKey:g1024Privkey];
        XCTAssertNotNil(deStr1024, @"解密结果不为空");
        NSString *deStr2048 = [RSAObjC decrypt:enStr2048 PrivateKey:g2048Privkey];
        XCTAssertNotNil(deStr2048, @"解密结果不为空");
        
        BOOL isSame1024 = [deStr1024 isEqualToString:plaintext];
        XCTAssertTrue(isSame1024, @"加解密结果应该相同");
        BOOL isSame2048 = [deStr2048 isEqualToString:plaintext];
        XCTAssertTrue(isSame2048, @"加解密结果应该相同");
    }
}

/**
 * 测试标准 der 公钥，p12 私钥加解密
 */
- (void)testStandardRSAFile {
    for (NSInteger i = 0; i < 1000; i++) {
        int randLen = arc4random_uniform((int)1000);
        NSString *plaintext = [self randomZhEnString:randLen];
        XCTAssertNotNil(plaintext, @"生成字符串不为空");
        
        NSString *enStrWithDer = [RSAObjC encrypt:plaintext KeyFilePath:self.derPubKey];
        XCTAssertNotNil(enStrWithDer, @"加密字符串不为空");
        
        NSString *deStrWithP12 = [RSAObjC decrypt:enStrWithDer KeyFilePath:self.p12PricKey FilePwd:nil];
        XCTAssertNotNil(deStrWithP12, @"解密结果不为空");
        
        BOOL isSameText = [deStrWithP12 isEqualToString:plaintext];
        XCTAssertTrue(isSameText, @"加解密结果应该相同");
    }
}

/**
 * 测试标准 Pem 文本格式公私钥加解密
 */
- (void)testPemRSAFile {
    for (NSInteger i = 0; i < 1000; i++) {
        int randLen = arc4random_uniform((int)1000);
        NSString *plaintext = [self randomZhEnString:randLen];
        XCTAssertNotNil(plaintext, @"生成字符串不为空");
        
        NSString *enStr1024 = [RSAObjC encrypt:plaintext KeyFilePath:self.g1024PubKeyPath];
        XCTAssertNotNil(enStr1024, @"加密字符串不为空");
        NSString *enStr2048 = [RSAObjC encrypt:plaintext KeyFilePath:self.g2048PubKeyPath];
        XCTAssertNotNil(enStr2048, @"加密字符串不为空");
        
        NSString *deStr1024 = [RSAObjC decrypt:enStr1024 KeyFilePath:self.g1024PrivKeyPath FilePwd:nil];
        XCTAssertNotNil(deStr1024, @"解密结果不为空");
        NSString *deStr2048 = [RSAObjC decrypt:enStr2048 KeyFilePath:self.g2048PrivKeyPath FilePwd:nil];
        XCTAssertNotNil(deStr2048, @"解密结果不为空");
        
        BOOL isSame1024 = [deStr1024 isEqualToString:plaintext];
        XCTAssertTrue(isSame1024, @"加解密结果应该相同");
        BOOL isSame2048 = [deStr2048 isEqualToString:plaintext];
        XCTAssertTrue(isSame2048, @"加解密结果应该相同");
    }
}

///MARK: - 生成随机字符串

// 生成中英文混合字符串
- (NSString *)randomZhEnString:(NSInteger)maxLength{
    int randLen = arc4random_uniform((int)maxLength);
    randLen = randLen > 1 ? randLen : 10;
    NSMutableString *mstr = [NSMutableString stringWithCapacity:randLen];
    for (NSInteger i = 0; i < randLen - 1; i+=2) {
        int randZhEn = arc4random_uniform(2);
        if (randZhEn % 2 == 0) {
            NSString *zh = [self randomZh:2];
            [mstr appendString:zh];
        }else{
            NSString *en = [self randomEn:2];
            [mstr appendString:en];
        }
    }
    return mstr.copy;
}

// 随机生成ascii符串(由大小写字母、数字组成)
- (NSString *)randomEn:(NSInteger)len {
    len = len > 1 ? len : 10;
    // 33 至 126
    char ch[len];
    for (NSInteger index=0; index<len; index++) {
        int num = arc4random_uniform(93)+33;
        ch[index] = num;
    }
    return [[NSString alloc] initWithBytes:ch length:len encoding:NSUTF8StringEncoding];
}

// 随机生成汉字字符串
-(NSString *)randomZh:(NSInteger)len{
    len = len > 1 ? len : 10;
    NSMutableString *mStr = [NSMutableString string];
    for (NSInteger i = 0; i < len; i++) {
        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        
        NSInteger randomH = 0xA1+arc4random()%(0xFE - 0xA1+1);
        
        NSInteger randomL = 0xB0+arc4random()%(0xF7 - 0xB0+1);
        
        NSInteger number = (randomH<<8)+randomL;
        NSData *data = [NSData dataWithBytes:&number length:2];
        
        NSString *string = [[NSString alloc] initWithData:data encoding:gbkEncoding];
        [mStr appendString:string];
    }
    return mStr.copy;
}

@end

