import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:mp3_mobile_app/data/data_sources/rbs_mp3_api/dto/auth/auth_response.dart';
import 'package:mp3_mobile_app/data/data_sources/rbs_mp3_api/dto/merchant_information/merchant_information_response.dart';
import 'package:mp3_mobile_app/data/data_sources/rbs_mp3_api/dto/transaction_list/range.dart';
import 'package:mp3_mobile_app/data/data_sources/rbs_mp3_api/dto/transaction_list/transaction_list_item.dart';
import 'package:mp3_mobile_app/data/data_sources/rbs_mp3_api/dto/transaction_list/transaction_search_parameters.dart';
import 'package:mp3_mobile_app/domain/models/accessible_merchant.dart';
import 'package:mp3_mobile_app/domain/models/currency.dart';
import 'package:mp3_mobile_app/domain/models/enums.dart';
import 'package:mp3_mobile_app/domain/models/merchant.dart';
import 'package:mp3_mobile_app/domain/models/orders_search_filter.dart';
import 'package:mp3_mobile_app/domain/models/session.dart';
import 'package:mp3_mobile_app/domain/models/simple_order_data.dart';

const _dateFormatPattern = 'yyyy-MM-ddTHH:mm:ss';

String _formatDateWithOffset(DateTime date) {
  String twoDigits(int n) => n >= 10 ? '$n' : '0$n';

  var hours = twoDigits(date.timeZoneOffset.inHours.abs());
  var minutes = twoDigits(date.timeZoneOffset.inMinutes.remainder(60));
  var sign = date.timeZoneOffset.inHours > 0 ? '+' : '-';
  var formattedDate = DateFormat(_dateFormatPattern).format(date);

  return '$formattedDate$sign$hours:$minutes';
}

const paymentTypeMap = {
  'UNKNOWN': PaymentType.unknown,
  'CARD': PaymentType.card,
  'APPLE': PaymentType.apple,
  'SAMSUNG': PaymentType.samsung,
  'GOOGLEPAY': PaymentType.google,
  'YANDEXPAY': PaymentType.yandex,
  'TOKEN_PAY': PaymentType.token,
  'SBERID': PaymentType.sberId,
  'SENDY': PaymentType.sendy,
  'ALFACLICK': PaymentType.alfaClick,
  'UPOP': PaymentType.upop,
  'P2P': PaymentType.p2p,
  'MTS': PaymentType.mts,
  'SBERPAY': PaymentType.sberPay,
  'SBP_C2B': PaymentType.sbpC2b,
  'SBOL': PaymentType.sbol,
  'ALFA_SBP': PaymentType.alfaSbp,
  'SBOL_BINDING': PaymentType.sbolBinding,
};

const paymentTypeExtensionMap = {
  'CARD': PaymentTypeExtension.card,
  'CARD_BINDING': PaymentTypeExtension.cardBinding,
  'ANDROID_PAY': PaymentTypeExtension.androidPay,
  'GOOGLE_PAY_TOKENIZED': PaymentTypeExtension.googlePayTokenized,
  'GOOGLE_PAY_CARD': PaymentTypeExtension.googlePayCard,
  'P2P_BINDING': PaymentTypeExtension.p2pBinding,
  'UNKNOWN': PaymentTypeExtension.unknown,
};

const userPermissionMap = {
  'EDIT_MERCHANT_SETTINGS': UserPermission.editMerchantSettings,
  'REFUND': UserPermission.refund,
  'DEPOSIT': UserPermission.deposit,
  'SEND_PAYMENT_FORM': UserPermission.sendPaymentForm,
  'OFD_REFUND': UserPermission.ofdRefund,
  'BUNDLE_CATALOG_EDIT': UserPermission.bundleCatalogEdit,
  'REVERSE_HOLD': UserPermission.reverseHold,
  'REVERSE_DEPOSIT': UserPermission.reverseDeposit,
  'OFD_CONFIGURATION': UserPermission.ofdConfiguration,
  'DOWNLOAD_EXTENDED_REPORTS_MP3': UserPermission.downloadExtendedReportsMp3,
  'CAN_UPLOAD_BO': UserPermission.canUploadBo,
  'USE_MPI_CERTIFICATES': UserPermission.useMpiCertificates,
  'UPDATE_SECURE_SETTINGS': UserPermission.updateSecureSettings,
  'VIEW_POS_OPERATION': UserPermission.viewPosOperation,
  'CHANGE_PAYS_CERTIFICATES_SETTINGS':
      UserPermission.changePaysCertificatesSettings,
  'DECLINE_CREATED_ORDER': UserPermission.declineCreatedOrder,
  'GENERAL_OPERATOR_MP3': UserPermission.generalOperatorMp3,
  'EDIT_MERCHANT_SETTINGS_MP3': UserPermission.editMerchantSettingsMp3,
  'IS_GENERATED_FROM_MP3': UserPermission.isGeneratedFromMp3,
  'MANAGE_ORDER_TEMPLATES_MP3': UserPermission.manageOrderTemplatesMp3,
  'DONT_WORK_WITH_ECOM': UserPermission.dontWorkWithEcom,
};

const merchantOptionMap = {
  'SEND_ORDER_REGISTRATION_NOTIFICATION':
      MerchantOption.sendOrderRegistrationNotification,
  'TWO_PHASE_PAYMENT_ALLOWED': MerchantOption.twoPhasePaymentAllowed,
  'BINDING_ALLOWED': MerchantOption.bindingAllowed,
  'ALTERNATIVE_SESSION_TIMEOUT': MerchantOption.alternativeSessionTimeout,
  'GENERATE_ORDERNUMBER': MerchantOption.generateOrderNumber,
  'DEPOSIT_CAN_BE_EXCEEDED': MerchantOption.depositCanBeExceeded,
  'SBERID_ALLOWED': MerchantOption.sberIdAllowed,
  'CREDIT_SERVICE_ALLOWED': MerchantOption.creditServiceAllowed,
  'SIMPLE_ORDER_REGISTRATION_ALLOWED':
      MerchantOption.simpleOrderRegistrationAllowed,
  'MP3_REDIRECT': MerchantOption.mp3Redirect,
  'APPLE_PAY_QUICK_BUTTONS': MerchantOption.applePayQuickButtons,
  'USE_APPLEPAY': MerchantOption.useApplePay,
  'USE_SAMSUNGPAY': MerchantOption.useSamsungPay,
  'GOOGLE_PAY_TOKENIZED_ALLOWED': MerchantOption.googlePayTokenizedAllowed,
  'CAN_TRANSFER_PERSONAL_DATA': MerchantOption.canTransferPersonalData,
  'WHITE_LIST_DEBIT': MerchantOption.whiteListDebit,
  'WHITE_LIST_CREDIT': MerchantOption.whiteListCredit,
  'CAN_UPLOAD_MPI_CERTIFICATES': MerchantOption.canUploadMpiCertificates,
  'DISPLAY_PAYMENT_LINK': MerchantOption.displayPaymentLink,
  'PAY_BY_CARD_QUICK_BUTTONS': MerchantOption.payByCardQuickButtons,
  'PARTIAL_REVERSE': MerchantOption.partialReverse,
  'ALLOWED_PAYMENT_METHOD_PAYMENT_CREDIT':
      MerchantOption.allowedPaymentMethodPaymentCredit,
  'AUTOCOMPLETION_ALLOWED': MerchantOption.autocompletionAllowed,
  'USE_GENERIC_FINISH_PAYMENT_PAGE': MerchantOption.useGenericFinishPaymentPage,
  'SEND_PAYER_NOTIFICATION_BY_EMAIL':
      MerchantOption.sendPayerNotificationByEmail,
  'P2P_PARTIAL_CREDIT_ALLOWED': MerchantOption.p2pPartialCreditAllowed,
  'SEND_PAYER_NOTIFICATION_BY_PHONE':
      MerchantOption.sendPayerNotificationByPhone,
  'GOOGLE_PAY_CARD_ALLOWED': MerchantOption.googlePayCardAllowed,
  'YANDEX_PAY_ALLOWED': MerchantOption.yandexPayAllowed,
  'CALLBACK_OPERATIONS': MerchantOption.callbackOperations,
  'MASTERCARD_INSTALLMENTS_ALLOWED':
      MerchantOption.mastercardInstallmentsAllowed,
  'EASY_OFD_SETUP': MerchantOption.easyOfdSetup,
};

extension MerchantMapper on MerchantInformationResponseSuccess {
  Merchant toEntity(String login) {
    var defaultCurrency = currencies.firstWhere((cur) => cur.isDefault);

    return Merchant(
      login: login,
      fullName: fullName,
      defaultCurrency: Currency(
        alphabeticCode: defaultCurrency.currencyName,
        minorUnit: defaultCurrency.minorUnit,
      ),
      currencies: currencies
          .map(
            (cur) => Currency(
              alphabeticCode: cur.currencyName,
              minorUnit: cur.minorUnit,
            ),
          )
          .toList(),
      options: options
          .map((optionName) => merchantOptionMap[optionName])
          .whereType<MerchantOption>()
          .toList(),
      sessionTimeoutMinutes: sessionTimeoutMinutes,
      locales: locales.map((local) => Locale(local)).toList(),
      mainUrl: mainUrl,
      openIdToken: openIdToken,
      merchantTerms: merchantTerms,
      knp: knp,
      email: email,
    );
  }
}

extension TransactionSearchParametersMapper on TransactionSearchParameters {
  static TransactionSearchParameters fromEntity(OrdersSearchFilter filter) {
    final period = Range(
      from: _formatDateWithOffset(filter.period.from.toLocal()),
      to: _formatDateWithOffset(filter.period.to.toLocal()),
    );
    Range? amountRange;
    final filterAmountRange = filter.amountRange;
    if (filterAmountRange != null) {
      amountRange = Range(
        to: filterAmountRange.maxAmount.toString(),
        from: filterAmountRange.minAmount.toString(),
      );
    }
    String? paymentType;
    if (filter.paymentType != null &&
        paymentTypeMap.containsValue(filter.paymentType)) {
      paymentType = paymentTypeMap.entries
          .firstWhere((element) => element.value == filter.paymentType)
          .key;
    }

    return TransactionSearchParameters(
      period: period,
      actionCode: filter.actionCode?.toString(),
      amountRange: amountRange,
      mdOrder: filter.mdOrder,
      merchantLogins: filter.merchantLogins,
      ofdStatuses: filter.ofdStatuses?.map((status) => status.name).toList(),
      orderNumber: filter.orderNumber,
      paymentType: paymentType,
      paymentSystems: filter.paymentSystems
          ?.map((paymentSystem) => paymentSystem.name)
          .toList(),
      states: filter.states?.map((state) => state.name).toList(),
      payerEmail: filter.payerEmail,
    );
  }
}

extension TransactionListItemMapper on TransactionListItem {
  SimpleOrderData toEntity() {
    var paymentSystemMapped = PaymentSystem.unknown;
    var itemPaymentSystem = paymentSystem.toLowerCase();
    try {
      paymentSystemMapped = PaymentSystem.values.byName(itemPaymentSystem);
    } catch (e, s) {
      //"Payment system with name $itemPaymentSystem doesn't exist."
      //TODO
    }
    var stateMapped = OrderState.created;
    var itemState = state.toLowerCase();
    try {
      stateMapped = OrderState.values.byName(itemState);
    } catch (e, s) {
      //"Order state with name $itemState doesn't exist.",
      //TODO
    }
    OfdStatus? ofdStatusMapped;
    var itemOfdStatus = ofdStatus?.toLowerCase();
    try {
      if (itemOfdStatus != null) {
        ofdStatusMapped = OfdStatus.values.byName(itemOfdStatus);
      }
    } catch (e, s) {
      //"OFD status with name $itemOfdStatus doesn't exist."
      //TODO
    }

    return SimpleOrderData(
      amount: double.tryParse(amount) ?? 0,
      createdDate: DateTime.parse(createdDate),
      currency: currency,
      feeAmount: double.tryParse(feeAmount) ?? 0,
      mdOrder: mdOrder,
      merchantLogin: merchantLogin,
      orderNumber: orderNumber,
      paymentSystem: paymentSystemMapped,
      paymentType: paymentTypeMap[paymentType] ?? PaymentType.unknown,
      paymentTypeExtension: paymentTypeExtensionMap[paymentTypeExtension] ??
          PaymentTypeExtension.unknown,
      refundedAmount: double.tryParse(refundedAmount) ?? 0,
      orderState: stateMapped,
      actionCode: actionCode == null ? null : int.tryParse(actionCode!),
      shortDescription: shortDescription,
      withLoyalty: withLoyalty,
      paymentDate: DateTime.parse(createdDate),
      ofdStatus: ofdStatusMapped,
    );
  }
}

extension AuthResponseMapper on AuthResponseSuccess {
  Session toSession(MerchantInformationResponseSuccess merchantResponse) {
    return Session(
      sessionId: sessionId,
      userLogin: userLogin,
      merchant: merchantResponse.toEntity(merchantLogin),
      accessibleMerchants: accessibleMerchants.map((merchant) {
        MerchantType merchantType = MerchantType.unknown;
        try {
          merchantType =
              MerchantType.values.byName(merchant.merchantType.toLowerCase());
        } catch (e, s) {
          //"Merchant type with name ${merchant.merchantType} doesn't exist.
          //TODO
        }

        return AccessibleMerchant(
          merchantLogin: merchant.merchantLogin,
          merchantFullName: merchant.merchantFullName,
          merchantType: merchantType,
        );
      }).toList(),
      permissions: permissions
          .map((permissionName) => userPermissionMap[permissionName])
          .whereType<UserPermission>()
          .toList(),
    );
  }
}
