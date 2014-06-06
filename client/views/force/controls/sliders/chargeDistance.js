initChargeDistanceSlider = function() {
    d3.select("#charge-distance-slider")
        .call(d3.slider()
            .min(-301)
            .max(-1)
            .step(5)
            .value(Session.get("chargeDistance"))
            .on("slide", function(evt, value) {
                Session.set("chargeDistance", value);
                force = force.chargeDistance(value);
                force.start();
            }));
}

Template.chargeDistance.rendered = function() {
    initChargeDistanceSlider();
}