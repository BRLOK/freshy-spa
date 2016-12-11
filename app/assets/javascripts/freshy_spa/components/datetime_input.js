yojs.define("components.initializeDateTimeInputs", function(){
  $('.datepicker').datepicker({
    language: 'pt-BR',
    autoclose: true,
    todayHighlight: true
  });

  $('.clockpicker').clockpicker({
    default: "now",
    autoclose: true
  });
})
