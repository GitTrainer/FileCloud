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

$(document).on("click", ".open-addMembers", function () {
     var myFileId = $(this).data('params[:file_id]');
     $(".modal-body #fileId").val( myFileId );
    $('#myModal').modal('show');
});


  $("#search_folder input").keyup(function() {
    $.get($("#search_folder").attr("action"), $("#search_folder").serialize(), null, "script");
    return false;
  });
});



$('.table-hove').each(function() {
    $(this).table-hove({
        timeout: 0.1
        url:     "folders/show.html.erb"
    });
});


function changeproject(folder_id,user_id){
  window.location.href = url+"/?templateid=" +$("#templateid").val()
}