/*
 * Translated default messages for the jQuery validation plugin.
 * Locale: KO
 */
jQuery.extend(jQuery.validator.messages, {
    required: "Required Field",
    remote: "Please modify the input",
    email: "Input email correctly",
    url: "Input URL correctly",
    date: "Input date correctly",
    dateISO: "Input date by ISO format",
    number: "Input number",
    digits: "Input digits",
    equalTo: "Values are different",
    accept: "Please accept",
    maxlength: jQuery.validator.format("Can not input more than {0} words."),
    minlength: jQuery.validator.format("Input at least {0} words."),
    rangelength: jQuery.validator.format("Input more than {0} words and less than {1} words."),
    range: jQuery.validator.format("Input between {0} ~ {1} words."),
    max: jQuery.validator.format("Input {0} or less"),
    min: jQuery.validator.format("Input {0} or more")
});

jQuery.validator.addMethod("alphanumeric", function(value, element) {
    return this.optional(element) || /^[a-z\d\{\}\(\)\.\s]+$/i.test(value) ;
}, "Only letters and numbers");