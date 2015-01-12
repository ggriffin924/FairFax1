// Default Value Field entry
// This code copies a field value from one to the other on the Identity Minder Screen
function defaultValue(FieldContext) {

var actcode = FieldContext.getFieldValue("Activation Code");

return actcode;
}