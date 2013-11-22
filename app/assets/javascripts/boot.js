$(document).ready(function() {
    $('#timer').pietimer({
        timerSeconds: 10,
        color: '#234',
        fill: false,
        showPercentage: true,
        callback: function() {
            alert("Time up!");
            $('#timer').pietimer('reset');
            window.location.href = '/complete';
        }
    });
});
