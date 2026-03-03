import 'package:flutter/material.dart';
import 'package:intime_manager/widgets/emp_detail/labeled_field.dart';

class EmpInfoForm extends StatelessWidget {
  final String enrollID;
  final String empName;
  final String deptName;
  final String lastAuthLog;
  final TextEditingController nameController;
  final VoidCallback? onDeptTap;

  const EmpInfoForm({
    super.key,
    required this.enrollID,
    required this.empName,
    required this.deptName,
    required this.lastAuthLog,
    required this.nameController,
    this.onDeptTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF3F4F6), width: 2.7),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(26, 26, 26, 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabeledField(
            label: 'ID (전화번호)',
            value: enrollID,
          ),
          const SizedBox(height: 24),
          LabeledField(
            label: '이름',
            value: empName,
            style: FieldStyle.editable,
            controller: nameController,
          ),
          const SizedBox(height: 24),
          LabeledField(
            label: '부서',
            value: deptName,
            style: FieldStyle.dropdown,
            onDropdownTap: onDeptTap,
          ),
          const SizedBox(height: 24),
          LabeledField(
            label: '최근 기록',
            value: lastAuthLog,
          ),
        ],
      ),
    );
  }
}
