//
//	RootClass.swift
//
//	Create by admin on 20/5/2016
//	Copyright © 2016. All rights reserved.


import Foundation

struct Weather{

	var result : [Result]!
	var success : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		result = [Result]()
		if let resultArray = dictionary["result"] as? [NSDictionary]{
			for dic in resultArray{
				let value = Result(fromDictionary: dic)
				result.append(value)
			}
		}
		success = dictionary["success"] as? String
	}

}