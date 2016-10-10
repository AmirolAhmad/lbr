var ready;
ready = function() {

  // datatable
  (function( $ ) {
    'use strict';

    var datatableInit = function() {
      $('#datatable-lbr').dataTable();
    };
    $(function() {
      datatableInit();
    });

  }).apply( this, [ jQuery ]);

  // datepicker
  $('.datepicker').datepicker({
    format:"yyyy-mm-dd",
    todayBtn: "linked",
    weekStart: 1,
    todayHighlight: true,
    autoclose: true
  });

  // timepicker
  $('.timepicker').timepicker({
    minuteStep: 5
  });

  // Modal
  (function( $ ) {
  	'use strict';

  	$('.modal-basic').magnificPopup({
  		type: 'inline',
  		preloader: false,
  		modal: true
  	});

    $(document).on('click', '.modal-dismiss', function (e) {
  		e.preventDefault();
  		$.magnificPopup.close();
  	});

  }).apply( this, [ jQuery ]);

};

$(document).ready(ready);
$(document).on('page:load', ready);
