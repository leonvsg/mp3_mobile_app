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

const permissionMap = {
  'EDIT_MERCHANT_SETTINGS': Permission.editMerchantSettings,
  'REFUND': Permission.refund,
  'DEPOSIT': Permission.deposit,
  'SEND_PAYMENT_FORM': Permission.sendPaymentForm,
  'OFD_REFUND': Permission.ofdRefund,
  'BUNDLE_CATALOG_EDIT': Permission.bundleCatalogEdit,
  'REVERSE_HOLD': Permission.reverseHold,
  'REVERSE_DEPOSIT': Permission.reverseDeposit,
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
      permissions: options
          .map((permissionName) => permissionMap[permissionName])
          .whereType<Permission>()
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
          merchantType = MerchantType.values.byName(merchant.merchantType.toLowerCase());
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
    );
  }
}