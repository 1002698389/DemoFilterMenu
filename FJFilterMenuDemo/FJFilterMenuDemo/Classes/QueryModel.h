//
//  QueryModel.h
//  FJFilterMenuDemo
//

@interface QueryModel : JSONModel

@property (copy, nonatomic) NSString<Optional> *query;
@property (copy, nonatomic) NSString<Optional> *brand;
@property (copy, nonatomic) NSString<Optional> *seller;
@property (copy, nonatomic) NSString<Optional> *category;

@end
