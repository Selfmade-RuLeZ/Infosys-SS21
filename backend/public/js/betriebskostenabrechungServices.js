$("#loadBKA").click(function () {
  var name = $("#inputNameBKA").val();
  var year = $("#inputYearBKA").val();
  window.open(`/api/betriebskostenabrechnung/${name}/${year}`);
});
