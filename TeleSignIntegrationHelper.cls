/* Class Name : TeleSignIntegrationHelper
   Developer Name : Anupam Shrivastava
*/
public with sharing class TeleSignIntegrationHelper {

    //Wrapper class to hold response body of the TeleSign
    public TeleSignResponseWrapper objWrapper = new TeleSignResponseWrapper();

    public TeleSignResponseWrapper sendSMS() {

        /* I have created a map to store the body but I would suggest you to store the JSON request
        body in the CustomMetada or Custom Setting and fetch it the code for best practices */
        Map<String, String> bodyMap = new Map<String, String>();
        bodyMap.put('message', 'Hello World');
        bodyMap.put('message_type', 'ARN');
        bodyMap.put('phone_number', '0845449343');
        String body = JSON.serialize(bodyMap);
        /* Please store request parameters and other attributes in custom setting, custom metadata or Named Credential for
        best practices */
        String username = '09700CD9-E640-4023-8587-D3A60F990ACF70';
        String password = 'sWgGxW99oiy5gSjhyMt7k2NL9G61idL6bn7lBxzUf6PlV+L4C9xg0Tl/dkB/ds+uBX+qnnozId1Xnpw==';
        Blob headerValue = Blob.valueOf(username + ':' + password);
        String authenticationHeader = 'basic '+ EncodingUtil.base64Encode(headerValue);
        System.debug(body);
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        request.setHeader('Authorization', authenticationHeader);
        request.setEndpoint('https://rest-api.telesign.com/v1/messaging');
        request.setBody(body);
        HttpResponse response = new HttpResponse();
        response = http.send(request);
        if(response.getStatusCode() == 200) {
            objWrapper =  (TeleSignResponseWrapper)JSON.deserialize(response.getBody(), TeleSignResponseWrapper.class);
            String referenceId = objWrapper.reference_id; //Reference Id is used to get current status of the SMS. Store it somewhere for future reference.
        }
        else {
            /* Write logic for error handling */
        }
        return objWrapper;
    }

}