
jQuery.extend({
    "Encrypt": function (word) {
        var key = CryptoJS.enc.Utf8.parse("tJjwxDz4WF0Sf9JT");
        var srcs = CryptoJS.enc.Utf8.parse(word);
        var encrypted = CryptoJS.AES.encrypt(srcs, key, {mode:CryptoJS.mode.ECB,padding: CryptoJS.pad.Pkcs7});
        return encrypted.toString();
    },
    "Decrypt": function (word) {
        var key = CryptoJS.enc.Utf8.parse("tJjwxDz4WF0Sf9JT");
        var decrypt = CryptoJS.AES.decrypt(word, key, {mode:CryptoJS.mode.ECB,padding: CryptoJS.pad.Pkcs7});
        return CryptoJS.enc.Utf8.stringify(decrypt).toString();
    }
});