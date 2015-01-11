// default value function for Act Code generation
function defaultValue(FieldContext) {
    // var letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
    // var numbers = [0123456789];
    // var symbols = '!@#$%^&*()-+';
    var RANDPW_LEN = 4; // length of genated random password
    var randpw = '';

    function randomNumber(max) {
        return Math.floor(Math.random() * (max + 1));
    }

    function randomNumberRange(min, max) {
        return Math.floor(Math.random() * (max - min + 1) + min);
    }

    function randomNumberLen(len) {
        var number = "";
        for (var i = 0; i < len; i++) {
            number += randomNumberRange(0, 9);
        }
        return number;
    }

    function randomSymbol(len) {
        var symbols = '!@#$%^&*()+';
        return symbols.charAt(randomNumber(symbols.length - 1));
    }

    function randomString(len) {
        var str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        var randomStr = '';
        var newchar = '';
        var numdup = 0;
        var i = 0;
        while (i < len) {
            newchar = str.charAt(randomNumber(str.length - 1));
            if (randomStr.indexOf(newchar) > -1) {
                numdup++;
                newchar = '';
            } else {
                randomStr += newchar;
                i++;
            }
        }
        if (numdup > 0) {
            //return randomStr + "_" + numdup;
            return randomStr;
        } else {
            return randomStr;
        }
    }

    function validpw(password) {
        // Make sure password generated meets the rules
        var containsDigits = /[0-9]/.test(password);
        var containsUpper = /[A-Z]/.test(password);
        var containsLower = /[a-z]/.test(password);
        if (containsDigits && containsUpper && containsLower) {
            return true;
        } else {
            return false;
        }
    }

    // Main code
    do {
        randpw = randomNumber(9) + randomString(RANDPW_LEN - 1) + randomSymbol(0);
    }
    while (validpw(randpw) === false);

    if (validpw(randpw)) { // Real return
        //      if (validpw("test")) {    // Test this    
        return randpw;
    } else {
        return "invalid";
    }
    // return validpw("Atest");
}
// *******************************
// output section below don't copy
// *******************************
var outputtext = "";

outputtext = '<table class="TFtable">';

for (var i = 0; i < 15; i++) {
    outputtext += "<tr>";
    outputtext += "<td>" + defaultValue() + "</td > ";
    outputtext += " <td> " + defaultValue() + " </td>";
    outputtext += " <td> " + defaultValue() + " </td>";
    outputtext += " <td> " + defaultValue() + " </td>";
    outputtext += "</tr > ";
}
outputtext += " </table>";
// Write the output table
document.getElementById('content').innerHTML = outputtext;
