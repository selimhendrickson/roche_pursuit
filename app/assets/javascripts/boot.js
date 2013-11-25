$(document).ready(function() {
    $('#timer').pietimer({
        timerSeconds: 90,
        color: '#234',
        fill: false,
        showPercentage: true,
        callback: function() {
          if ( window.location.pathname == '/takes/new' ) {
            alert("Time up!");
            $('#timer').pietimer('reset');
            window.location.href = '/complete';
          }
        }
    });
});
