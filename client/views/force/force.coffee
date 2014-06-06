# file scope
svg = undefined

linkPath = undefined
nodeCircle = undefined
labelText = undefined

linkGroup = undefined
nodeGroup = undefined
labelGroup = undefined

drag = undefined
width = 400
height = 400

# global scope for controls to access
force = undefined
startForce = true

svgBounds = ->
    currentWidth = $("svg").width()
    currentHeight = $("svg").height()
    if currentWidth > currentHeight
        w = width * currentWidth / currentHeight
        h = height
        xMin = (width - w) / 2
        xMax = width + (w - width) / 2
        yMin = 0
        yMax = height
        return [xMin, xMax, yMin, yMax]
    else
        w = width
        h = height * currentHeight / currentWidth
        xMin = 0
        xMax = width
        yMin = (height - h) / 2
        yMax = height + (h - height) / 2
        return [xMin, xMax, yMin, yMax]

tick = ->
    # update link path 
    linkPath.attr("d", (data) -> "M" + data.source.x + "," + data.source.y + "L" + data.target.x + "," + data.target.y)

    # update nodes with bounded a window
    [xMin, xMax, yMin, yMax] = svgBounds()
    r = Session.get("nodeRadius")
    nodeCircle.attr("cx", (data) -> data.x = Math.max(xMin + r, Math.min(xMax - r, data.x)))
        .attr("cy", (data) -> data.y = Math.max(yMin, Math.min(yMax - r, data.y)))

    # update text position based on nodes
    labelText.attr("transform", (data) -> "translate(" + data.x + "," + data.y + ")")
    return

unselect = ->
    selected = Session.get "selected"
    # unclass the selected element
    if selected
        d3.selectAll("#id" + selected._id)
            .classed("selected", false)
    Session.set "selected", null

select = (nodeOrLink) ->
    d3.selectAll("#id" + nodeOrLink._id)
        .classed("selected", true)
    Session.set "selected", nodeOrLink

click = (nodeOrLink) ->
    unselect()
    select(nodeOrLink)

hover = (nodeOrLink) ->
    if Session.get "hover"
        unselect()
        select(nodeOrLink)
    
unstick = (node) ->
    node.fixed = false
    d3.select(this)
        .classed("fixed", false)
    force.resume()


dataJoinNodes = ->
    # create a selection
    # data join
    nodeCircle = nodeGroup.selectAll(".node")
        .data(force.nodes())

dataJoinLabels = ->
    labelText = labelGroup.selectAll(".label")
        .data(force.nodes())

dataJoinLinks = ->
    # create a selection
    # data dataJoinLinks
    linkPath = linkGroup.selectAll(".link")
        .data(force.links())

enterNodes = ->
    # enter all of the new nodes
    # create an svg circle element
    # class it as a node for CSS
    # set the radius
    # set the _id for selecting.
    # bind the dblclick to unstick the node
    # stop the node from escaping your click!
    # bind the click event
    # bind the hover event
    # make the node draggable
    nodeCircle.enter()
        .append("circle")
        .attr("class", "node")
        .attr("r", Session.get("nodeRadius"))
        .attr("id", (data) -> "id" + data._id)
        .on("dblclick", unstick)
        .on("mousedown", -> d3.event.stopPropagation())
        .on("click", click)
        .on("mouseover", hover)
        .call(drag)

enterLabels = ->
    # enter all of the new elements
    # create an svg text element
    # class it as a label for CSS
    # set the x offset
    # set the y offset
    # set the _id for selecting.
    labelText.enter()
        .append("text")
        .attr("class", "label " + Session.get("labelControl"))
        .attr("dx", 12)
        .attr("dy", ".35em")
        .attr("id", (data) -> "id" + data._id)

enterLinks = ->
    # enter all of the new elements
    # create an svg path element
    # class it as a link for CSS
    # set the _id for selecting.
    # bind the click event
    # bind the hover event
    linkPath.enter()
        .append("path")
        .attr("class", "link")
        .attr("id", (data) -> "id" + data._id)
        .on("click", click)
        .on("mouseover", hover)

updateLabels = ->
    # set the text of the label
    labelText.text((data) -> data.name)

exitRemoveNodes = ->
    nodeCircle.exit().remove();

exitRemoveLabels = ->
    labelText.exit().remove();

exitRemoveLinks = ->
    linkPath.exit().remove();

Template.force.rendered = ->
    # handle scopes to keep the code cleaner
    # console.log(Object.keys(this))
    # console.log(window)

    # init css for links and labels
    $.rule(".link").append "stroke-width:" + Session.get("linkSize") + "px;"
    $.rule(".label").append "font-size:" + Session.get("fontSize") + "px;"

    # nodes = Nodes.find().fetch()
    # links = Links.find().fetch()
    # nodes = [{"_id":"yhoyLhFNB5iwqBQby","name":"Esnoing"},{"_id":"29LZEwHL75YhSob4v","name":"Inga"},{"_id":"H5ZGQMtWb7bv3KyNY","name":"Unty"},{"_id":"Ahe4A2y8yHYznKeeE","name":"Pero"},{"_id":"oaqxHTheQRJ3pvZw6","name":"Ein"},{"_id":"7b48fSkXZAAs5e5nT","name":"Diryry"},{"_id":"n3ak5G3rTp6oeHWDK","name":"Alen"},{"_id":"tnREiRt63ajSDMFEG","name":"Torpen"},{"_id":"vcbEnBJv68zT4sEEF","name":"Al"},{"_id":"tc8t7wjySEEK9zeZ5","name":"Esri"},{"_id":"qKXYi3Ai6ZxwtrHcv","name":"Efulperun"},{"_id":"Wkx96CkwNtsqfxCKs","name":"Is"},{"_id":"Xmwfhxfr6hCXThgWZ","name":"Utial"},{"_id":"dsgcZvgCrokbSHxpf","name":"Ty"},{"_id":"YrTwm6NyKBozFoFXg","name":"Exinged"},{"_id":"7D9g7kCN8qJwRokJK","name":"Bere"},{"_id":"ZLCFqSChzk4XGHCxD","name":"Ingining"},{"_id":"Q6KLWpx8umvmh9N3d","name":"Landoexing"},{"_id":"2NAfE8tdmhh2wzyHB","name":"Esineecon"},{"_id":"mimvNwWQ9anfuePAb","name":"Manema"}]
    # links = [{"_id":"A4GASvPJ2rErEF4Ys","source":"ZLCFqSChzk4XGHCxD","target":"H5ZGQMtWb7bv3KyNY"},{"_id":"b4GPZCxKsMRsSZKJA","source":"7D9g7kCN8qJwRokJK","target":"tnREiRt63ajSDMFEG"},{"_id":"bP9SCpXMHfbJmtgPp","source":"YrTwm6NyKBozFoFXg","target":"yhoyLhFNB5iwqBQby"},{"_id":"ijguRcZeXFTtGuapb","source":"H5ZGQMtWb7bv3KyNY","target":"qKXYi3Ai6ZxwtrHcv"},{"_id":"t8BvCvv9qqbDEiHJs","source":"qKXYi3Ai6ZxwtrHcv","target":"tc8t7wjySEEK9zeZ5"},{"_id":"4ZRoRWTkBLAffoW8j","source":"Q6KLWpx8umvmh9N3d","target":"oaqxHTheQRJ3pvZw6"},{"_id":"GW2j2bbe4mYj2izqt","source":"Xmwfhxfr6hCXThgWZ","target":"Q6KLWpx8umvmh9N3d"},{"_id":"fYBshwo9ivLBkHDXA","source":"mimvNwWQ9anfuePAb","target":"tnREiRt63ajSDMFEG"},{"_id":"PoctrotqQw6S84iWn","source":"n3ak5G3rTp6oeHWDK","target":"Ahe4A2y8yHYznKeeE"},{"_id":"KkdSes4jgd7EoTq7C","source":"Xmwfhxfr6hCXThgWZ","target":"mimvNwWQ9anfuePAb"},{"_id":"EHM7qiwzHzHXnJF97","source":"vcbEnBJv68zT4sEEF","target":"7D9g7kCN8qJwRokJK"},{"_id":"wiKuSJBbm8j2cN3k9","source":"Ahe4A2y8yHYznKeeE","target":"7D9g7kCN8qJwRokJK"},{"_id":"N4DvGn5MvFFeeXe8h","source":"vcbEnBJv68zT4sEEF","target":"29LZEwHL75YhSob4v"},{"_id":"jw78ovizuvJtZpuCP","source":"vcbEnBJv68zT4sEEF","target":"yhoyLhFNB5iwqBQby"},{"_id":"kEmDoXcbioHEkCggB","source":"YrTwm6NyKBozFoFXg","target":"7D9g7kCN8qJwRokJK"},{"_id":"AfhumgPkPJptPSsvk","source":"mimvNwWQ9anfuePAb","target":"29LZEwHL75YhSob4v"},{"_id":"emLFTK9EEeKnwGWyM","source":"YrTwm6NyKBozFoFXg","target":"vcbEnBJv68zT4sEEF"},{"_id":"o4eBfLWDEXzqshSKH","source":"Wkx96CkwNtsqfxCKs","target":"qKXYi3Ai6ZxwtrHcv"},{"_id":"rXJxrE4Ys3iT7uyvH","source":"H5ZGQMtWb7bv3KyNY","target":"29LZEwHL75YhSob4v"},{"_id":"8kmZX2pByJwgooWky","source":"7b48fSkXZAAs5e5nT","target":"Q6KLWpx8umvmh9N3d"},{"_id":"hLLcgZAv6a4Y7HMvT","source":"Ahe4A2y8yHYznKeeE","target":"vcbEnBJv68zT4sEEF"},{"_id":"bE3T9XeMqpMvNDj7s","source":"oaqxHTheQRJ3pvZw6","target":"tc8t7wjySEEK9zeZ5"},{"_id":"6bYF5ZvsBdrgqGZKJ","source":"mimvNwWQ9anfuePAb","target":"Ahe4A2y8yHYznKeeE"},{"_id":"BDtqJ6KoWcdd7iBuF","source":"ZLCFqSChzk4XGHCxD","target":"tc8t7wjySEEK9zeZ5"},{"_id":"rijmuN9ArPX5QQ5tM","source":"29LZEwHL75YhSob4v","target":"ZLCFqSChzk4XGHCxD"},{"_id":"SQNsG3kvex7z5zGqW","source":"mimvNwWQ9anfuePAb","target":"vcbEnBJv68zT4sEEF"},{"_id":"uYZW6B2zTNiQpv6eb","source":"Ahe4A2y8yHYznKeeE","target":"Xmwfhxfr6hCXThgWZ"},{"_id":"P8RupLroFqrphMZ7o","source":"tnREiRt63ajSDMFEG","target":"vcbEnBJv68zT4sEEF"},{"_id":"G62Q5xYt3LQemSqZG","source":"Ahe4A2y8yHYznKeeE","target":"H5ZGQMtWb7bv3KyNY"},{"_id":"G4keyNCcrxxd35tSv","source":"tnREiRt63ajSDMFEG","target":"7b48fSkXZAAs5e5nT"},{"_id":"tbqEMrCALoE3wQj3b","source":"dsgcZvgCrokbSHxpf","target":"n3ak5G3rTp6oeHWDK"},{"_id":"599XWpyDD82vzryWy","source":"tnREiRt63ajSDMFEG","target":"Wkx96CkwNtsqfxCKs"},{"_id":"Cnpv7Ai6czJErq4JQ","source":"dsgcZvgCrokbSHxpf","target":"yhoyLhFNB5iwqBQby"},{"_id":"cZJpAm5s3FSsY7EcH","source":"Wkx96CkwNtsqfxCKs","target":"YrTwm6NyKBozFoFXg"},{"_id":"QTjwbLGNQZxbZyBSs","source":"n3ak5G3rTp6oeHWDK","target":"7D9g7kCN8qJwRokJK"},{"_id":"bmTk5Po3H3JkQmdCK","source":"yhoyLhFNB5iwqBQby","target":"ZLCFqSChzk4XGHCxD"},{"_id":"6QbczoLuXCJefee2P","source":"Xmwfhxfr6hCXThgWZ","target":"n3ak5G3rTp6oeHWDK"},{"_id":"rKZL72Xxik9cstDbT","source":"7b48fSkXZAAs5e5nT","target":"mimvNwWQ9anfuePAb"},{"_id":"WWhy46x57zvMGBJGw","source":"H5ZGQMtWb7bv3KyNY","target":"mimvNwWQ9anfuePAb"},{"_id":"obfBRReZBFipSSim7","source":"2NAfE8tdmhh2wzyHB","target":"7b48fSkXZAAs5e5nT"},{"_id":"ojzvQqEvN4uzcKiwS","source":"2NAfE8tdmhh2wzyHB","target":"dsgcZvgCrokbSHxpf"},{"_id":"y3p7twPTBCAWhy7xk","source":"n3ak5G3rTp6oeHWDK","target":"Q6KLWpx8umvmh9N3d"},{"_id":"4XupBAzSTvo5tpahm","source":"Q6KLWpx8umvmh9N3d","target":"dsgcZvgCrokbSHxpf"},{"_id":"3TwpBvQed4bgFJdXA","source":"dsgcZvgCrokbSHxpf","target":"ZLCFqSChzk4XGHCxD"},{"_id":"Gg2S8bSRmCNzi3oxg","source":"mimvNwWQ9anfuePAb","target":"qKXYi3Ai6ZxwtrHcv"}]
    # _.each links, (link) ->
        # link.source = _.findWhere(nodes, {_id: link.source})
        # link.target = _.findWhere(nodes, {_id: link.target})

    nodes = []
    links = []

    # init the force layout
    force = d3.layout.force()
        .linkDistance(Session.get("linkDistance"))
        .linkStrength(Session.get("linkStrength"))
        .friction(Session.get("friction"))
        .charge(Session.get("charge"))
        .theta(Session.get("theta"))
        .gravity(Session.get("gravity"))
        .size([width, height])
        .nodes(nodes)
        .links(links)

    # update the global scope
    window.force = force

    # create the drag function
    drag = force.drag()
        .on "dragstart", (d) ->
            if Session.get("stick")
                # set the data property to true
                d.fixed = true
                # set the class to fixed
                d3.select(this).classed("fixed", true)
    
    # create an svg element to the body with resizing
    svg = d3.select("#force")
        .append("svg")
        .attr("viewBox", "0 0 " + width + " " + height)
        .attr("preserveAspectRatio", "xMidYMid meet")
    
    # sexy fade-in
    svg.style("opacity", 1e-6).transition().duration(2000).style "opacity", 1
    
    # make a group for the links, nodes and labels
    linkGroup = svg.append("g").attr("class", "links")
    nodeGroup = svg.append("g").attr("class", "nodes")
    labelGroup = svg.append("g").attr("class", "labels")
    
    # data join
    dataJoinNodes()
    dataJoinLabels()
    dataJoinLinks()
    # enter the data
    enterNodes()
    enterLabels()
    enterLinks()
    # update the labels
    updateLabels()

    if startForce
        force.on("tick", tick)
            .start()

    Nodes.find().observe
        added: (node) ->
            # enter the new node and label in the force layout
            force.nodes().push node
            # data join
            dataJoinNodes()
            dataJoinLabels()
            # enter the data
            enterNodes()
            enterLabels()
            # update the labels
            updateLabels()
            force.start()
            return

        changed: (newNode, oldNode) ->
            # update the node in the force layout
            # remove old node
            nodes = _.filter(force.nodes(), (node) -> node._id isnt oldNode._id)
            # add new node
            nodes.push newNode
            # update the force nodes
            force.nodes(nodes)
            # the force graph keeps track of nodes and links through the object references
            # so we need to update the source and target references of the links as well
            _.each force.links(), (link) ->
                link.source = newNode if link.source._id is oldNode._id
                link.target = newNode if link.source._id is oldNode._id            

            # data join
            dataJoinNodes()
            dataJoinLabels()
            # enter
            enterNodes()
            enterLabels()
            # update
            updateLabels()
            # exit remove
            exitRemoveNodes()
            exitRemoveLabels()
            force.start()
            return

        removed: (oldNode) ->
            # update the node in the force layout
            # remove old node
            nodes = _.filter(force.nodes(), (node) -> node._id isnt oldNode._id)
            # update the force nodes
            force.nodes(nodes)

            # remove links pointing to this node
            links = _.filter(force.links(), (link) -> link.source._id isnt oldNode._id and link.target._id isnt oldNode._id)
            # update the force links
            force.links(links)
            
            # data join
            dataJoinNodes()
            dataJoinLabels()
            dataJoinLinks()
            # exit remove
            exitRemoveNodes()
            exitRemoveLabels()
            exitRemoveLinks()
            force.start()
            return

    Links.find().observe
        added: (link) ->
            # we need to convert the source and target _id 
            # to the actual object references for d3.
            link.source = _.findWhere(force.nodes(), {_id: link.source})
            link.target = _.findWhere(force.nodes(), {_id: link.target})
            force.links().push link
            # data join
            dataJoinLinks()
            # enter the data
            enterLinks()
            force.start()
            return

        changed: (newLink, oldLink) ->
            # remove old link
            links = _.filter(force.links(), (link) -> link._id isnt oldLink._id)
            # add new link
            newLink.source = _.findWhere(force.nodes(), {_id: newLink.source})
            newLink.target = _.findWhere(force.nodes(), {_id: newLink.target})
            links.push newLink
            # update the force links
            force.links(links)

            # data join
            dataJoinLinks()
            # enter
            enterLinks()
            # exit remove
            exitRemoveLinks()
            force.start()
            return

        removed: (oldLink) ->
            # remove old link
            links = _.filter(force.links(), (link) -> link._id isnt oldLink._id)
            force.links(links)
            
            # data join
            dataJoinLinks()
            # exit remove
            exitRemoveLinks()
            force.start()
            return

Template.force.destroyed = () ->
    force.stop()
