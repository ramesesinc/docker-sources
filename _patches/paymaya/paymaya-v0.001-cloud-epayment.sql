alter table cloud_epayment.payment_partner add requirecheckout int
;

update cloud_epayment.payment_partner set requirecheckout = 0 where requirecheckout = null
;


alter table cloud_epayment.paymentorder add checkoutid varchar(255)
;

alter table cloud_epayment.paymentorder_paid add checkoutid varchar(255)
;



-- PAYMAYA SETTINGS
INSERT INTO `cloud_epayment`.`payment_partner` 
(`objid`, `name`, `code`, `actionurl`, `caption`, `info`, `allowsend`, `allowpay`, `state`, `requirecheckout`) 
VALUES ('PAYMAYA', 'PAYMAYA', '103', 'https://pg-sandbox.paymaya.com/checkout/v1/checkouts', 'PAYMAYA', '\r\n[\r\n	successurl: \"http://192.168.1.10/payoptions/paymayasuccess\", \r\n	errorurl: \"http://192.168.1.10/payoptions/paymayaerror\",\r\n	cancelurl: \"http://192.168.1.10/payoptions/paymayaerror\",\r\n	header: [\r\n			\'Content-Type\': \'application/json\',\r\n			\'Authorization\': \'Basic cGstZW80c0wzOTNDV1U1S212ZUpVYVc4VjczMFRUZWkyelk4ekU0ZEhKRHhrRjo=\'\r\n		],\r\n	custom: [\r\n		url: \'https://pg-sandbox.paymaya.com/checkout/v1/customizations\',\r\n		header: [\r\n			\'Content-Type\': \'application/json\',\r\n			\'Authorization\': \'Basic c2stS2ZtZkxKWEZkVjV0MWluWU44bElPd1NydWVDMUcyN1NDQWtsQnFZQ2RyVTo=\'\r\n		],\r\n		data: [\r\n		  \"logoUrl\": \"https://www.filipizen.com/res/logo-filipizen-topnav.svg\",\r\n		  \"iconUrl\": \"https://www.filipizen.com/res/logo-filipizen-topnav.svg\",\r\n		  \"appleTouchIconUrl\": \"https://www.filipizen.com/res/logo-filipizen-topnav.svg\",\r\n		  \"customTitle\": \"Filipizen EPayment\",\r\n		  \"colorScheme\": \"#368d5c\"\r\n		]\r\n	]\r\n]\r\n\r\n', '1', '1', 'ACTIVE', '1')
;

INSERT INTO `cloud_epayment`.`payment_partner_option` 
(`objid`, `partnerid`, `paypartnerid`, `info`) 
VALUES ('00001_PAYMAYA', '00001', 'PAYMAYA', '[:]')
;



