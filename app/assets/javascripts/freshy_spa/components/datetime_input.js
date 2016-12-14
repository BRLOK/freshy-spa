yojs.define("components.initializeDateTimeInputs", function(){
  $('.datepicker').datepicker({
    language: 'pt-BR',
    autoclose: true,
    todayHighlight: true
  });

  $('.timepicker').timepicker({
    useSelect: true,
    minTime: '8:00am',
    maxTime: '10:00pm'
  });
})
