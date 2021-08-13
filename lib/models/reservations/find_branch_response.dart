import 'package:equatable/equatable.dart';

class FindBranchResponse extends Equatable {
  final int? status;
  final List<dynamic>? branchId;
  final String? message;

  const FindBranchResponse({this.status, this.branchId, this.message});

  factory FindBranchResponse.fromJson(Map<String, dynamic> json) =>
      FindBranchResponse(
        status: json['status'] as int?,
        branchId: json['BranchID'] as List<dynamic>?,
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'BranchID': branchId,
        'message': message,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [status, branchId, message];
}
