Meteor.startup ->
    if Nodes.find().count() is 0
        for i in [1..20]
            insertRandomNode()
    if Links.find().count() is 0
        for i in [1..50]
            insertRandomLink()
