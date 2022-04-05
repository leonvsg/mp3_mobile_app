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

enum Permission {
  editMerchantSettings,
  refund,
  deposit,
  sendPaymentForm,
  ofdRefund,
  bundleCatalogEdit,
  reverseHold,
  reverseDeposit,
  unknown
}
