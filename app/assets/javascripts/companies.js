$(document).on('ready page:change', function() {
    $('input.file-path').click(function(e){
        e.preventDefault();
        e.stopPropagation();
        $("#company_avatar").trigger("click");
    });
});