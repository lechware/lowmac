//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require turbolinks
//= require twitter/bootstrap

//= require addtohomescreen
//= require moment
//= require fullcalendar
//= require fullcalendar/scheduler.min
//= require icheck
//= require Chart
//= require pace/pace
//= require bootstrap-datepicker
//= require bootstrap-wysihtml5

// Adminlte and corresponding Plugins
//= require admin-lte
//= require daterangepicker
//= require bootstrap-timepicker
//= require bootstrap-slider

//= require users/search


// Turbolinks issue - https://github.com/almasaeed2010/AdminLTE/issues/563
$(document).ready(function() {
  $.AdminLTE.layout.activate();

  $('.wysihtml5').each(function(i, elem) {
    $(elem).wysihtml5({
      toolbar: {
        "color": true
      }
    });
  });
});

$(document).on('page:load', function() {
  var o;
  o = $.AdminLTE.options;
  if (o.sidebarPushMenu) {
    $.AdminLTE.pushMenu.activate(o.sidebarToggleSelector);
  }
  $.AdminLTE.layout.activate();
});