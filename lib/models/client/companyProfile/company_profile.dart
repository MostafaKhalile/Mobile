// import 'package:equatable/equatable.dart';

// import "company_branches.dart";
// import "company_data.dart";

// class CompanyProfile extends Equatable {
// 	final int status;
// 	final CompanyData companyData;
// 	final List<CompanyBranches> companyBranches;

// 	const CompanyProfile({
// 		this.status,
// 		this.companyData,
// 		this.companyBranches,
// 	});

// 	@override
// 	String toString() {
// 		return 'CompanyProfile(status: $status, companyData: $companyData, companyBranches: $companyBranches)';
// 	}

// 	factory CompanyProfile.fromJson(Map<String, dynamic> json) {
// 		return CompanyProfile(
// 			status: json['status'] as int,
// 			companyData: json['CompanyData'] == null
// 					? null
// 					: CompanyData.fromJson(json['CompanyData'] as Map<String, dynamic>),
// 			companyBranches: (json['CompanyBranches'] as List)
// 					?.map((e) => e == null
// 							? null
// 							: CompanyBranches.fromJson(json['CompanyBranches'] as Map<String, dynamic>))
// 					?.toList(),
// 		);
// 	}

// 	Map<String, dynamic> toJson() {
// 		return {
// 			'status': status,
// 			'CompanyData': companyData?.toJson(),
// 			'CompanyBranches': companyBranches?.map((e) => e?.toJson())?.toList(),
// 		};
// 	}

// CompanyProfile copyWith({
// 		int status,
// 		CompanyData companyData,
// 		List<CompanyBranches> companyBranches,
// 	}) {
// 		return CompanyProfile(
// 			status: status ?? this.status,
// 			companyData: companyData ?? this.companyData,
// 			companyBranches: companyBranches ?? this.companyBranches,
// 		);
// 	}

// 	@override
// 	List<Object> get props => [status, companyData, companyBranches];
// }
