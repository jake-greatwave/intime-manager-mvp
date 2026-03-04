import 'package:flutter/foundation.dart';
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

    final response = await sendAndReceive(
      request: request,
    );

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

    final response = await sendAndReceive(
      request: request,
    );

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
}
