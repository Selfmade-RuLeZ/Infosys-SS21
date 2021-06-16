$("#loadBKA").click(function (){

    var name = $("#inputNameBKA").val();
    window.open(`/Betriebskostenabrechnung/${name}`);

});