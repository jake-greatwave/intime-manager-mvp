import 'package:flutter/foundation.dart';
import 'package:intime_manager/models/request/add_dept_request.dart';
import 'package:intime_manager/models/request/delete_dept_request.dart';
import 'package:intime_manager/models/request/update_dept_request.dart';
import 'package:intime_manager/network/socket/socket_service.dart';
import 'package:intime_manager/models/request/auth_request.dart';
import 'package:intime_manager/models/request/verify_request.dart';
import 'package:intime_manager/models/request/login_request.dart';
import 'package:intime_manager/models/request/reg_member_request.dart';
import 'package:intime_manager/models/request/work_info_request.dart';
import 'package:intime_manager/models/request/update_emp_info_request.dart';
import 'package:intime_manager/models/request/emp_info_request.dart';
import 'package:intime_manager/models/response/generic_response.dart';
import 'package:intime_manager/models/response/login_response.dart';
import 'package:intime_manager/models/response/emp_working_info_response.dart';
import 'package:intime_manager/models/response/dept_in_field_response.dart';
import 'package:intime_manager/models/request/dept_in_field_request.dart';
import 'package:intime_manager/models/request/quit_emp_request.dart';
import 'package:intime_manager/models/response/emp_info_response.dart';
import 'package:intime_manager/models/emp_detail.dart';

class AuthService extends SocketService {
  Future<GenericResponse> requestAuthCode({
    required String phoneNumber,
    required String reqTime,
  }) async {
    final request = AuthRequest(
      reqTime: reqTime,
      phoneNumber: phoneNumber,
    );

    final response = await sendAndReceive(
      request: request,
    );

    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> verifyAuthCode({
    required String phoneNumber,
    required String authCode,
    required String reqTime,
  }) async {
    final request = VerifyRequest(
      reqTime: reqTime,
      phoneNumber: phoneNumber,
      authCode: authCode,
    );

    final response = await sendAndReceive(
      request: request,
    );

    return GenericResponse.fromJson(response);
  }

  Future<LoginResponse> login({
    required String loginID,
    required String birthDay,
  }) async {
    final request = LoginRequest(
      loginID: loginID,
      birthDay: birthDay,
    );

    final response = await sendAndReceive(
      request: request,
    );

    return LoginResponse.fromJson(response);
  }

  Future<GenericResponse> registerMember({
    required String loginID,
    required String birthDay,
  }) async {
    final request = RegMemberRequest(
      loginID: loginID,
      birthDay: birthDay,
    );

    final response = await sendAndReceive(
      request: request,
    );

    return GenericResponse.fromJson(response);
  }

  Future<EmpWorkingInfoResponse> getWorkInfo({
    required int companyID,
    required int fieldID,
    required String fieldCode,
    required String workDate,
  }) async {
    final request = WorkInfoRequest(
      companyID: companyID,
      fieldID: fieldID,
      fieldCode: fieldCode,
      workDate: workDate,
    );

    debugPrint(
      '[WorkInfo REQ] CompanyID=$companyID FieldID=$fieldID '
      'FieldCode=$fieldCode WorkDate=$workDate',
    );

    final response = await sendAndReceive(
      request: request,
    );

    debugPrint(
      '[WorkInfo RES] status=${response['status']} '
      'message=${response['message']} '
      'empCount=${(response['EmpWorkingInfo'] as List?)?.length ?? 0}',
    );
    debugPrint('[WorkInfo RAW] $response');

    return EmpWorkingInfoResponse.fromJson(response);
  }

  Future<EmpInfoResponse> getEmpInfo({
    required int companyID,
    required int fieldID,
    required String enrollID,
  }) async {
    final request = EmpInfoRequest(
      companyID: companyID,
      fieldID: fieldID,
      enrollID: enrollID,
    );

    debugPrint(
      '[EmpInfo REQ] CompanyID=$companyID FieldID=$fieldID EnrollID=$enrollID',
    );

    final response = await sendAndReceive(
      request: request,
    );

    debugPrint('[EmpInfo RAW] $response');

    return EmpInfoResponse.fromJson(response);
  }

  Future<GenericResponse> updateEmpInfo({
    required EmpDetail empDetail,
  }) async {
    final request = UpdateEmpInfoRequest(empDetail: empDetail);

    final response = await sendAndReceive(
      request: request,
    );

    return GenericResponse.fromJson(response);
  }

  Future<DeptInFieldResponse> getDeptInField({
    required int companyID,
    required int fieldID,
  }) async {
    final request = DeptInFieldRequest(
      companyID: companyID,
      fieldID: fieldID,
    );

    final response = await sendAndReceive(
      request: request,
    );

    debugPrint('[DeptInField RAW] $response');

    return DeptInFieldResponse.fromJson(response);
  }

  Future<GenericResponse> quitEmp({
    required int companyID,
    required int fieldID,
    required String enrollID,
  }) async {
    final request = QuitEmpRequest(
      companyID: companyID,
      fieldID: fieldID,
      enrollID: enrollID,
    );

    final response = await sendAndReceive(
      request: request,
    );

    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> updateDept({
    required int companyID,
    required int fieldID,
    required int deptID,
    required int typeOfWorkID,
    required String deptName,
  }) async {
    final request = UpdateDeptRequest(
      companyID: companyID,
      fieldID: fieldID,
      deptID: deptID,
      typeOfWorkID: typeOfWorkID,
      deptName: deptName,
    );

    debugPrint(
      '[UpdateDept REQ] CompanyID=$companyID FieldID=$fieldID '
      'DeptID=$deptID TypeOfWorkID=$typeOfWorkID DeptName=$deptName',
    );

    final response = await sendAndReceive(request: request);

    debugPrint(
      '[UpdateDept RES] status=${response['status']} message=${response['message']}',
    );

    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> addDept({
    required int companyID,
    required int fieldID,
    required String deptName,
    required int typeOfWorkID,
  }) async {
    final request = AddDeptRequest(
      companyID: companyID,
      fieldID: fieldID,
      deptName: deptName,
      typeOfWorkID: typeOfWorkID,
    );

    debugPrint(
      '[AddDept REQ] CompanyID=$companyID FieldID=$fieldID '
      'TypeOfWorkID=$typeOfWorkID DeptName=$deptName',
    );

    final response = await sendAndReceive(request: request);

    debugPrint(
      '[AddDept RES] status=${response['status']} message=${response['message']}',
    );

    return GenericResponse.fromJson(response);
  }

  Future<GenericResponse> deleteDept({
    required int companyID,
    required int fieldID,
    required int deptID,
  }) async {
    final request = DeleteDeptRequest(
      companyID: companyID,
      fieldID: fieldID,
      deptID: deptID,
    );

    debugPrint(
      '[DeleteDept REQ] CompanyID=$companyID FieldID=$fieldID DeptID=$deptID',
    );

    final response = await sendAndReceive(request: request);

    debugPrint(
      '[DeleteDept RES] status=${response['status']} message=${response['message']}',
    );

    return GenericResponse.fromJson(response);
  }
}
