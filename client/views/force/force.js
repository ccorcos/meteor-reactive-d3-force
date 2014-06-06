// // var click, dataJoinLabels, dataJoinLinks, dataJoinNodes, drag, enterLabels, enterLinks, enterNodes, exitRemoveLabels, exitRemoveLinks, exitRemoveNodes, force, height, hover, labelGroup, labelText, linkGroup, linkPath, nodeCircle, nodeGroup, select, svg, svgBounds, unselect, unstick, updateLabels, width;

// svg = void 0;

// linkPath = void 0;

// nodeCircle = void 0;

// labelText = void 0;

// linkGroup = void 0;

// nodeGroup = void 0;

// labelGroup = void 0;

// drag = void 0;

// width = 800;

// height = 800;

// force = void 0;

// svgBounds = function() {
//     var currentHeight, currentWidth, h, w, xMax, xMin, yMax, yMin;
//     currentWidth = $("svg").width();
//     currentHeight = $("svg").height();
//     if (currentWidth > currentHeight) {
//         w = width * currentWidth / currentHeight;
//         h = height;
//         xMin = (width - w) / 2;
//         xMax = width + (w - width) / 2;
//         yMin = 0;
//         yMax = height;
//         return [xMin, xMax, yMin, yMax];
//     } else {
//         w = width;
//         h = height * currentHeight / currentWidth;
//         xMin = 0;
//         xMax = width;
//         yMin = (height - h) / 2;
//         yMax = height + (h - height) / 2;
//         return [xMin, xMax, yMin, yMax];
//     }
// };

// tick = function() {
//     var r, xMax, xMin, yMax, yMin, _ref;
//     console.log("tick");
//     linkPath.attr("d", function(data) {
//         return "M" + data.source.x + "," + data.source.y + "L" + data.target.x + "," + data.target.y;
//     });
//     _ref = svgBounds(), xMin = _ref[0], xMax = _ref[1], yMin = _ref[2], yMax = _ref[3];
//     r = Session.get("nodeRadius");
//     nodeCircle.attr("cx", function(data) {
//         return data.x = Math.max(xMin + r, Math.min(xMax - r, data.x));
//     }).attr("cy", function(data) {
//         return data.y = Math.max(yMin, Math.min(yMax - r, data.y));
//     });
//     labelText.attr("transform", function(data) {
//         return "translate(" + data.x + "," + data.y + ")";
//     });
// };

// unselect = function() {
//     var selected;
//     selected = Session.get("selected");
//     if (selected) {
//         d3.select("[mongoId=" + selected._id + "]").classed("selected", false);
//     }
//     return Session.set("selected", null);
// };

// select = function(nodeOrLink) {
//     d3.select("[mongoId=" + nodeOrLink._id + "]").classed("selected", true);
//     return Session.set("selected", nodeOrLink);
// };

// click = function(nodeOrLink) {
//     unselect();
//     return select(nodeOrLink);
// };

// hover = function(nodeOrLink) {
//     if (Session.get("hover")) {
//         unselect();
//         return select(nodeOrLink);
//     }
// };

// unstick = function(node) {
//     node.fixed = false;
//     d3.select(this).classed("fixed", false);
//     return force.resume();
// };

// dataJoinNodes = function() {
//     return nodeCircle = nodeGroup.selectAll(".node").data(force.nodes());
// };

// dataJoinLabels = function() {
//     return labelText = labelGroup.selectAll(".title").data(force.nodes());
// };

// dataJoinLinks = function() {
//     return linkPath = linkGroup.selectAll(".link").data(force.links());
// };

// enterNodes = function() {
//     return nodeCircle.enter().append("circle").attr("class", "node").attr("r", Session.get("nodeRadius")).attr("mongoId", function(data) {
//         return data._id;
//     }).on("dblclick", unstick).on("mousedown", function() {
//         return d3.event.stopPropagation();
//     }).on("click", click).on("mouseover", hover).call(drag);
// };

// enterLabels = function() {
//     return labelText.enter().append("text").attr("class", "label").attr("dx", 12).attr("dy", ".35em").attr("mongoId", function(data) {
//         return data._id;
//     });
// };

// enterLinks = function() {
//     return linkPath.enter().append("path").attr("class", "link").attr("mongoId", function(data) {
//         return data._id;
//     }).on("click", click).on("mouseover", hover);
// };

// updateLabels = function() {
//     return labelText.text(function(data) {
//         return data.title;
//     });
// };

// exitRemoveNodes = function() {
//     return nodeCircle.exit().remove();
// };

// exitRemoveLabels = function() {
//     return labelText.exit().remove();
// };

// exitRemoveLinks = function() {
//     return linkPath.exit().remove();
// };

// Template.force.rendered = function() {
//     $.rule(".link").append("stroke-width:" + Session.get("linkSize") + "px;");
//     $.rule(".label").append("font-size:" + Session.get("fontSize") + "px;");
//     force = d3.layout.force().linkDistance(Session.get("linkDistance")).linkStrength(Session.get("linkStrength")).friction(Session.get("friction")).charge(Session.get("charge")).theta(Session.get("theta")).gravity(Session.get("gravity")).size([width, height]).nodes(Nodes.find().fetch()).links(Links.find().fetch()).on("tick", tick);
//     drag = force.drag().on("dragstart", function(d) {
//         if (Session.get("stick")) {
//             d.fixed = true;
//             return d3.select(this).classed("fixed", true);
//         }
//     });
//     svg = d3.select("#force").append("svg").attr("viewBox", "0 0 " + width + " " + height).attr("preserveAspectRatio", "xMidYMid meet");
//     svg.style("opacity", 1e-6).transition().duration(2000).style("opacity", 1);
//     linkGroup = svg.append("g").attr("class", "links");
//     nodeGroup = svg.append("g").attr("class", "nodes");
//     labelGroup = svg.append("g").attr("class", "labels");
//     dataJoinNodes();
//     dataJoinLabels();
//     dataJoinLinks();
//     enterNodes();
//     enterLabels();
//     enterLinks();
//     updateLabels();
//     force.start()

//     Nodes.find().observe({
//         added: function(node) {
//             force.nodes().push(node);
//             dataJoinNodes();
//             dataJoinLabels();
//             enterNodes();
//             enterLabels();
//             updateLabels();
//         },
//         changed: function(newNode, oldNode) {
//             var nodes;
//             nodes = _.filter(force.nodes(), function(node) {
//                 return node._id !== oldNode._id;
//             });
//             nodes.push(newNode);
//             force.nodes(nodes);
//             _.each(force.links(), function(link) {
//                 if (link.source._id === oldNode._id) {
//                     link.source = newNode;
//                 }
//                 if (link.source._id === oldNode._id) {
//                     return link.target = newNode;
//                 }
//             });
//             dataJoinNodes();
//             dataJoinLabels();
//             enterNodes();
//             enterLabels();
//             updateLabels();
//             exitRemoveNodes();
//             exitRemoveLabels();
//         },
//         removed: function(oldNode) {
//             var links, nodes;
//             nodes = _.filter(force.nodes(), function(node) {
//                 return node._id !== oldNode._id;
//             });
//             force.nodes(nodes);
//             links = _.filter(force.links(), function(link) {
//                 return link.source._id !== oldNode._id && link.target._id !== oldNode._id;
//             });
//             force.links(links);
//             dataJoinNodes();
//             dataJoinLabels();
//             dataJoinLinks();
//             exitRemoveNodes();
//             exitRemoveLabels();
//             exitRemoveLinks();
//         }
//     });
//     return Links.find().observe({
//         added: function(link) {
//             link.source = _.findWhere(force.links(), {
//                 _id: link.source
//             });
//             link.target = _.findWhere(force.links(), {
//                 _id: link.target
//             });
//             force.links().push(link);
//             dataJoinLinks();
//             enterLinks();
//         },
//         changed: function(newLink, oldLink) {
//             var links;
//             links = _.filter(force.links(), function(link) {
//                 return link._id !== oldLink._id;
//             });
//             newLink.source = _.findWhere(force.links(), {
//                 _id: newLink.source
//             });
//             newLink.target = _.findWhere(force.links(), {
//                 _id: newLink.target
//             });
//             links.push(newLink);
//             force.links(links);
//             dataJoinLinks();
//             enterLinks();
//             exitRemoveLinks();
//         },
//         removed: function(oldLink) {
//             var links;
//             links = _.filter(force.links(), function(link) {
//                 return link._id !== oldLink._id;
//             });
//             force.links(links);
//             dataJoinLinks();
//             exitRemoveLinks();
//         }
//     });
// };

// Template.force.destroyed = function() {
//     return force.stop();
// };