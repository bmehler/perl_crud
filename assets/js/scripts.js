$( document ).ready(function() {
  $("#searchInput").keyup(function () {
    var rows = $("#fbody").find("tr").hide();
    if (this.value.length) {
        var data = this.value.split(" ");
        $.each(data, function (i, v) {
            rows.filter(":contains('" + v + "')").show();
        });
    } else rows.show();
  });

  $(".alert-success").fadeTo(5000, 1000).fadeOut(2000, function(){
    $(".alert-success").alert('close');
  });

  $(".alert-warning").fadeTo(5000, 1000).fadeOut(2000, function(){
    $(".alert-warning").alert('close');
  });

  $(".alert-danger").fadeTo(5000, 1000).fadeOut(2000, function(){
    $(".alert-danger").alert('close');
  });

});