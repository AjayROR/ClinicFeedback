

$(document).ready(function() {
  // $('#test_table').dataTable
  //   sPaginationType: "full_numbers"    
    $('#test_table').dataTable({
  		"sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
  		"sPaginationType": "bootstrap"
	}); 
});