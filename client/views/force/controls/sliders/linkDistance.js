initLinkDistanceSlider = function() {
    d3.select("#link-distance-slider")
        .call(d3.slider()
            .min(1)
            .max(100)
            .step(1)
            .value(Session.get("linkDistance"))
            .on("slide", function(evt, value) {
                Session.set("linkDistance", value);
                // force.stop();
                force = force.linkDistance(value);
                force.start();
            }));
}

Template.linkDistance.rendered = function() {
    initLinkDistanceSlider();
}