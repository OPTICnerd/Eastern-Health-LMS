<?php

$S3_KEY = 'AKIAJIHDATIAMD6U2WWA';
$S3_SECRET = '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';
$S3_BUCKET = '/toddpardy/images'; // bucket needs / on the front
$S3_URL = 'http://s3.amazonaws.com';

// expiration date of query
$EXPIRE_TIME = (60 * 5); // 5 minutes
$objectName = '/' . $_GET['name'];
$mimeType = $_GET['type'];
$expires = time() + $EXPIRE_TIME;
$amzHeaders = "x-amz-acl:public-read";
$stringToSign = "PUT\n\n$mimeType\n$expires\n$amzHeaders\n$S3_BUCKET$objectName";

$sig = urlencode(base64_encode(hash_hmac('sha1', $stringToSign, $S3_SECRET, true)));
$url = urlencode("$S3_URL$S3_BUCKET$objectName?AWSAccessKeyId=$S3_KEY&Expires=$expires&Signature=$sig");

echo $url;
