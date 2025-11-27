enum EventType {
  loginWithPassword(value: "login_with_password"),
  loginWithPIN(value: "login_with_PIN"),
  loginWithPasswordCosigner(value: "login_with_password_cosigner"),
  newRegisteredUser(value: "new_registered_user"),
  pushButton(value: "push_button"),
  cosignerTryToSignContract(value: "cosigner_try_to_sign_contract"),
  tryToSignContract(value: "try_to_sign_contract"),
  kycCompleted(value: "kyc_completed"),
  kycCanceled(value: "kyc_canceled"),
  kycError(value: "kyc_error"),
  kycProcess(value: "kyc_process"),
  finalData(value: "final_data"),
  calculatorAmount(value: "calculator_amount"),
  calculatorData(value: "calculator_data"),
  calculatorMonths(value: "calculator_months"),
  loanFlowInitiated(value: "loan_flow_initiated"),

  //observer
  screenView(value: "screen_view");


  final String value;

  const EventType({
    required this.value,
  });
}
