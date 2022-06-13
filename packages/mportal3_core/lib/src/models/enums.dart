enum MerchantType {
  parent,
  child,
  viewable,
  unknown,
}

enum OfdStatus {
  error,
  sent,
  delivered,
}

enum PaymentType {
  unknown,
  card,
  apple,
  samsung,
  google,
  yandex,
  token,
  sberId,
  sendy,
  alfaClick,
  upop,
  p2p,
  mts,
  sberPay,
  sbpC2b,
  sbol,
  alfaSbp,
  sbolBinding,
}

enum PaymentTypeExtension {
  card,
  cardBinding,
  androidPay,
  googlePayTokenized,
  googlePayCard,
  p2pBinding,
  unknown,
}

enum OrderState {
  created,
  approved,
  refunded,
  deposited,
  reversed,
  declined,
}

enum PaymentSystem {
  unknown,
  visa,
  mastercard,
  amex,
  jcb,
  cup,
  mir,
}

enum UserPermission {
  editMerchantSettings,
  refund,
  deposit,
  sendPaymentForm,
  ofdRefund,
  bundleCatalogEdit,
  reverseHold,
  reverseDeposit,
  editMerchantSettingsMp3,
  ofdConfiguration,
  downloadExtendedReportsMp3,
  canUploadBo,
  useMpiCertificates,
  updateSecureSettings,
  viewPosOperation,
  changePaysCertificatesSettings,
  declineCreatedOrder,
  generalOperatorMp3,
  isGeneratedFromMp3,
  manageOrderTemplatesMp3,
  dontWorkWithEcom,
  unknown,
}

enum MerchantOption {
  sendOrderRegistrationNotification,
  twoPhasePaymentAllowed,
  bindingAllowed,
  alternativeSessionTimeout,
  generateOrderNumber,
  depositCanBeExceeded,
  sberIdAllowed,
  creditServiceAllowed,
  simpleOrderRegistrationAllowed,
  mp3Redirect,
  applePayQuickButtons,
  useApplePay,
  useSamsungPay,
  googlePayTokenizedAllowed,
  canTransferPersonalData,
  whiteListDebit,
  whiteListCredit,
  canUploadMpiCertificates,
  displayPaymentLink,
  payByCardQuickButtons,
  partialReverse,
  allowedPaymentMethodPaymentCredit,
  autocompletionAllowed,
  useGenericFinishPaymentPage,
  sendPayerNotificationByEmail,
  p2pPartialCreditAllowed,
  sendPayerNotificationByPhone,
  googlePayCardAllowed,
  yandexPayAllowed,
  callbackOperations,
  mastercardInstallmentsAllowed,
  easyOfdSetup,
  unknown,
}

enum FraudStatus {
  noFraud,
  fraudDetected,
}

enum HistoryItemType {
  //TODO: add history item types
  unknown,
}

enum LoyaltyService {
  sbrfSpasibo,
  sbrfSbermiles,
}

enum PaymentMethod {
  //TODO: add payment methods
  unknown,
}