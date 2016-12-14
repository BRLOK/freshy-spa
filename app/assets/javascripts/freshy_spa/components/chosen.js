yojs.define("components.initializeChosen", function(){
  $('select').chosen({
    allow_single_deselect: true,
    no_results_text: 'Nenhum resultado para',
    width: "100%",
    disable_search_threshold: 10
  });
})
