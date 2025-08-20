import 'dart:convert';

class EndPoints {
  static const String username = "indiat20";
  static const String password = "2024";
  static var auth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';

  static const String baseUrl = "https://newappapi.decorainfotech.in/api/school";
  static const String baseDownloadUrl = "https://online.decorainfotech.in/";

  static const String login = "$baseUrl/get_school_auth";
  static const String dashboard = "$baseUrl/get_SchoolDashboard";
  static const String switchBranch = "$baseUrl/SwitchBranch";

  static const String signUp = "$baseUrl/AuthEmpST";
  static const String forgetPassword = "$baseUrl/ForgetEmpST";
  static const String validateOTP = "$baseUrl/ValidateOTP";
  static const String updatePassword = "$baseUrl/UpdatePassword";

  static const String classList = "$baseUrl/get_ClassList";
  static const String activityList = "$baseUrl/get_ActivityList";
  static const String activityUpdate = "$baseUrl/Update_Activity";

  static const String noticeList = "$baseUrl/get_NoticeList";
  static const String noticeUpdate = "$baseUrl/Update_Notice";

  static const String HomeWorkList = "$baseUrl/get_HomeWorkList";
  static const String HomeWorkUpdate = "$baseUrl/Update_HomeWork";

  static const String SyllabusList = "$baseUrl/get_SyllabusList";
  static const String SyllabusUpdate = "$baseUrl/Update_Syllabus";

  static const String OnlineClassList = "$baseUrl/get_OnlineClassList";
  static const String OnlineClassUpdate = "$baseUrl/Update_OnlineClass";

  static const String AssignmentList = "$baseUrl/get_AssignmentList";
  static const String AssignmentUpdate = "$baseUrl/Update_Assignment";

  static const String InstallmentList = "$baseUrl/get_InstallmentList";
  static const String SearchStudentList = "$baseUrl/get_SeachStudent";

  static const String FeeList = "$baseUrl/get_SchoolFeeList";

  static const String UpdateMessage = "$baseUrl/Update_Message";
  static const String MessageTitle = "$baseUrl/get_MessageTitle";
  static const String EmpList = "$baseUrl/get_EmpList";
  static const String StudentByClass = "$baseUrl/get_StudentByClass";

  static const String MarksInfo = "$baseUrl/get_MarksInfo";
  static const String MarksList = "$baseUrl/get_MarksList";
  static const String MarksUpdate = "$baseUrl/Update_Marks";

  static const String ExamList = "$baseUrl/get_ExamList";
  static const String UpdateExam = "$baseUrl/Update_Exam";
  static const String QuestionList = "$baseUrl/get_QuestionList";
  static const String UpdatePaper = "$baseUrl/Update_Question";

  static const String BulletinUpdate = "$baseUrl/Update_Bulletin";
  static const String NotificationList= "$baseUrl/get_BulletinList";

  static const String AttendanceList= "$baseUrl/get_AttendanceInfo";
  static const String EmpAttendanceList= "$baseUrl/get_EMPAttendanceInfo";
  static const String AttendanceUpdate= "$baseUrl/Update_Attendance";
  static const String EmpAttendanceUpdate= "$baseUrl/EMP_Update_Attendance";

  static const String AttendanceEmp= "$baseUrl/get_EMP_AttendaceList";
  static const String todayEmpAttendance= "$baseUrl/get_EMPAttendanceInfo";
  static const String UpdateAttendanceEmp= "$baseUrl/EMP_Update_Attendance";
  static const String UpdateLocation= "$baseUrl/Update_LocationSettings";

  static const String ChatEmpList = "$baseUrl/get_Parent_Emp_List";
  static const String EditChat= "$baseUrl/Edit_Chat";




}
