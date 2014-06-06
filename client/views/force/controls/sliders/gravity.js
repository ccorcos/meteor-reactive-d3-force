initGravitySlider = function() {
    d3.select("#gravity-slider")
        .call(d3.slider()
            .min(0)
            .max(1)
            .step(0.01)
            .value(Session.get("gravity"))
            .on("slide", function(evt, value) {
                Session.set("gravity", value);
                // force.stop();
                force = force.gravity(value);
                force.start();
            }));
}

Template.gravity.rendered = function() {
    initGravitySlider();
}