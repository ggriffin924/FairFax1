// Default Value Field entry
// This code copies a field value from one to the other on the Identity Minder Screen
function defaultValue(FieldContext) {

var actcode = FieldContext.getFieldValue("Activation Code");

return actcode;
}

function defaultValue(FieldContext) {

var loginid = FieldContext.getFieldValue("Login ID");

return loginid;
}


Password Requirments

<p><b>When you set your Password it must meet complexity requirements:</b></p>
<p>Your password must be at least 8 characters; cannot repeat any of your previous 3 passwords; 
Type a password which meets these requirements in both text boxes.</p><br>
<p>At least one of each of the following is required:</p>
<li>English uppercase characters (A through Z)</li>
<li>English lowercase characters (a through z)</li>
<li>Numerals (0 through 9)</li>
<li>Non-alphabetic characters (such as !, $, #, %)</li>
