initThetaSlider = function() {
    d3.select("#theta-slider")
        .call(d3.slider()
            .min(0)
            .max(1)
            .step(0.05)
            .value(Session.get("theta"))
            .on("slide", function(evt, value) {
                Session.set("theta", value);
                // force.stop();
                force = force.theta(value);
                force.start();
            }));
}

Template.theta.rendered = function() {
    initThetaSlider();
}