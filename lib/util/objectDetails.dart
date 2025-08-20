class ObjDetails {
  String UserTypeID;
  String MobileNo;

  ObjDetails({
    required this.UserTypeID,
    required this.MobileNo,
  });

  @override
  String toString() {
    return 'ObjDetails{UserTypeID: $UserTypeID, MobileNo: $MobileNo}';
  }
}