// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//=require jquery.colorbox
//= require jquery_ujs
//= require_tree .
//= require bootstrap
//= require jquery-fileupload
//=require jquery-fileupload/vendor/jquery.ui.widget
//=require jquery-fileupload/vendor/load-image
//=require jquery-fileupload/vendor/canvas-to-blob
//=require jquery-fileupload/vendor/tmpl
//=require jquery-fileupload/jquery.iframe-transport
//=require jquery-fileupload/jquery.fileupload
//=require jquery-fileupload/jquery.fileupload-fp
//=require jquery-fileupload/jquery.fileupload-ui
//=require jquery-fileupload/locale
//=require autocomplete-rails

$(function() {

    $("#folders").live("click", function() {
    $.getScript(this.href);
    return false;
  });

	$(".chk").click(function() {
		  var checked_status = this.checked;
		  if (checked_status == true) {
		     $("#btn_multiple_delete").removeAttr("disabled");
		     $("#btn_multiple_download").removeAttr("disabled");
		  } else {
		     $("#btn_multiple_download").attr("disabled", "disabled");
		     $("#btn_multiple_delete").attr("disabled", "disabled");
		  }
	});

  $("#search_folder input").keyup(function() {
    $.get($("#search_folder").attr("action"), $("#search_folder").serialize(), null, "script");
    return false;
  });

	 $(".inline").colorbox({inline:true, width:"40%"});
 	 $("#btn_share").click(function() {
	 	 $("#share_form").submit();
    });
   $("#btn_password").click(function(){
     $("#password_form").submit();
   });
   $("#btn_abc").click(function(){
     $("#password_form").submit();
   });
        $("#btn_preivew").click(function(){

      $("#preivew_form").submit();
   });


//		  $("#share_form").submit(function(){
//  	    var valuesToSubmit = $(this).serialize();
//		    $.ajax({
//		      url: $(this).attr('action'), //sumbits it to the given url of the form
//		      data: valuesToSubmit,
//		      dataType: "JSON" // you want a difference between normal and ajax-calls, and json is standard
//    		}).success(function(json){
//        //act on result.
//  		  	});
//	    	return false; // prevents normal behaviour
//		  });




});
