// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
// rails auth token enabled in jquery
$(document).ajaxSend(function(event, request, settings) {
  if (typeof(AUTH_TOKEN) == "undefined") return;
    settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});

// add javascript request type
jQuery.ajaxSetup({
  'beforeSend': function(xhr) { xhr.setRequestHeader("Accept", "application/json"); }
});

function displayErrors(errors) {
  var errorText = "Errors were reported: <br /><ul>";
  for (var item in errors) {
    var error = errors[item][1];
    errorText += "<li>";
    var field = errors[item][0].split("_");
    for (var i=0; i<field.length; i++) {
      errorText += field[i].substring(0,1).toUpperCase() + field[i].substring(1) + " ";
    }
    errorText += " " + error + "</li>";
  }
  errorText += "</ul><br /><a href=\"#\" onclick=\"$.unblockUI(); return false;\">Close</a>";
  $.unblockUI();
  $.blockUI({ message: errorText, 
    css: { 
      color: '#ff0000', 
      borderColor: '#ff0000', 
      fontWeight: 'bold',
      textAlign: 'left' 
    }, 
    overlayCSS: { opacity: 0 } 
  });
}

function displayUpdate(message) {
  if (message == null) {
    message = "Updating the database...<br />Please wait";
  }
  $.blockUI({message: message, overlayCSS: { opacity: 0 } });
}

function doAjax(url, values, notify, callback) {
  $.ajax({
    url: url,
    type: 'POST',
    dataType: 'json',
    data: values,
    timeout: 60000,
    error: function(request, stat, error){
    /*alert(dump(request));*/
    if (typeof(request.responseText)=="unknown") {
      errors = {"general": ["General Error", "An Error Has Occurred!  Please take a screen shot and email it to filters@lists.verizonbusiness.com.  Thanks!"], "headers": ["Headers", request.getAllResponseHeaders()], "text": ["Text", request.responseText()]};
    } else {
      try {
        errors = eval(request.responseText);
      } catch (e) {
        errors = {"general": ["Eval Error", "An Error Has Occurred!"]};
      }
      //alert("Errors: " + errors);
    }
    if (errors == undefined) {
      //top.location.href = request.getResponseHeader('Location');
      top.location.href = top.location.href;
    } else if (notify) {
      //alert(request.responseText);
      displayErrors(errors);
    }
  },
  success: callback
  });
}

