initChargeSlider = function() {

    d3.select("#charge-slider")
        .call(d3.slider()
            .min(-301)
            .max(-1)
            .step(5)
            .value(Session.get("charge"))
            .on("slide", function(evt, value) {
                Session.set("charge", value);
                // force.stop();
                force = force.charge(value);
                force.start();
            }));
}

Template.charge.rendered = function() {
    initChargeSlider();
};