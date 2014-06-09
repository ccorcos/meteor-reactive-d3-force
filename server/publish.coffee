Meteor.publish "nodes",  ->
    Nodes.find()

Meteor.publish "links",  ->
    Links.find()
    