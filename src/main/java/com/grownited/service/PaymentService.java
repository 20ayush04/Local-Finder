package com.grownited.service;

import java.math.BigDecimal;
import java.math.RoundingMode;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import net.authorize.Environment;
import net.authorize.api.contract.v1.*;
import net.authorize.api.controller.CreateTransactionController;
import net.authorize.api.controller.base.ApiOperationBase;

@Service
public class PaymentService {

    @Value("${authorizenet.api.login.id}")
    private String apiLoginId;

    @Value("${authorizenet.transaction.key}")
    private String transactionKey;

    public boolean run(Double amount, String ccNum, String expDate, String email) {

        ApiOperationBase.setEnvironment(Environment.SANDBOX);

        MerchantAuthenticationType merchantAuthenticationType = new MerchantAuthenticationType();
        merchantAuthenticationType.setName(apiLoginId);
        merchantAuthenticationType.setTransactionKey(transactionKey);

        CreditCardType creditCard = new CreditCardType();
        creditCard.setCardNumber(ccNum);
        creditCard.setExpirationDate(expDate);

        PaymentType paymentType = new PaymentType();
        paymentType.setCreditCard(creditCard);

        CustomerDataType customer = new CustomerDataType();
        customer.setEmail(email);

        TransactionRequestType txnRequest = new TransactionRequestType();
        txnRequest.setTransactionType(TransactionTypeEnum.AUTH_CAPTURE_TRANSACTION.value());
        txnRequest.setPayment(paymentType);
        txnRequest.setCustomer(customer);
        txnRequest.setAmount(new BigDecimal(amount).setScale(2, RoundingMode.CEILING));

        CreateTransactionRequest apiRequest = new CreateTransactionRequest();
        apiRequest.setMerchantAuthentication(merchantAuthenticationType);
        apiRequest.setTransactionRequest(txnRequest);

        CreateTransactionController controller = new CreateTransactionController(apiRequest);
        controller.execute();

        CreateTransactionResponse response = controller.getApiResponse();

        if (response != null) {
            if (response.getMessages().getResultCode() == MessageTypeEnum.OK) {
                TransactionResponse result = response.getTransactionResponse();
                if (result.getMessages() != null) {
                    System.out.println("✅ Transaction ID: " + result.getTransId());
                    System.out.println("🔐 Response Code: " + result.getResponseCode());
                    System.out.println("📦 Message Code: " + result.getMessages().getMessage().get(0).getCode());
                    System.out.println("📝 Description: " + result.getMessages().getMessage().get(0).getDescription());
                    System.out.println("🔑 Auth Code: " + result.getAuthCode());
                    return true;
                } else {
                    System.out.println("❌ Failed Transaction.");
                    if (response.getTransactionResponse().getErrors() != null) {
                        System.out.println("❗ Error Code: " +
                                response.getTransactionResponse().getErrors().getError().get(0).getErrorCode());
                        System.out.println("❗ Error Message: " +
                                response.getTransactionResponse().getErrors().getError().get(0).getErrorText());
                    }
                }
            } else {
                System.out.println("❌ Failed Transaction.");
                if (response.getTransactionResponse() != null &&
                    response.getTransactionResponse().getErrors() != null) {
                    System.out.println("❗ Error Code: " +
                            response.getTransactionResponse().getErrors().getError().get(0).getErrorCode());
                    System.out.println("❗ Error Message: " +
                            response.getTransactionResponse().getErrors().getError().get(0).getErrorText());
                } else {
                    System.out.println("❗ Error Code: " + response.getMessages().getMessage().get(0).getCode());
                    System.out.println("❗ Error Message: " + response.getMessages().getMessage().get(0).getText());
                }
            }
        } else {
            ANetApiResponse errorResponse = controller.getErrorResponse();
            System.out.println("❌ No response from server.");
            if (!errorResponse.getMessages().getMessage().isEmpty()) {
                System.out.println("❗ Error: " +
                        errorResponse.getMessages().getMessage().get(0).getCode() + " - " +
                        errorResponse.getMessages().getMessage().get(0).getText());
            }
        }

        return false;
    }
}
