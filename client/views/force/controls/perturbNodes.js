Template.perturbNodes.events({
    'click button#perturbNodes': function(e, t) {
        perturbNodes();
    }
});

perturbNodes = function() {
    // http://bl.ocks.org/mbostock/1021841
    force.nodes().forEach(function(d, i) {
        d.x += (Math.random() - 0.5) * 100;
        d.y += (Math.random() - 0.5) * 100;
    });
    force.resume();
}