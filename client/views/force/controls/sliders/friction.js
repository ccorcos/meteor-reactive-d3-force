initFrictionSlider = function() {
    d3.select("#friction-slider")
        .call(d3.slider()
            .min(0)
            .max(1)
            .step(0.05)
            .value(Session.get("friction"))
            .on("slide", function(evt, value) {
                Session.set("friction", value);
                // force.stop();
                force = force.friction(value);
                force.start();
            }));
}

Template.friction.rendered = function() {
    initFrictionSlider();
}