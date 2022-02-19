class SignUpDataModel
{
  String? name;
  String? nationalId;
  String? password;
  String ?confirmPass;
  String? phone;


  SignUpDataModel(
  { this.name,
      this.nationalId,
      this.password,
      this.confirmPass,
      this.phone,
      });
}