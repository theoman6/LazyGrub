$(document).ready(function(){
	$("#order_cost").change(change_total);
	$("#order_tip").change(change_total);
});


function change_total(){
   var total = Number($('#order_cost').val()) + Number($('#order_tip').val());
   $('#order_total').val(total);
};