Router.map(function() {
    this.route('home', {
        path: '/'
    })
});

Router.configure({
    layoutTemplate: 'layout',
    notFoundTemplate: 'notFound',
    loadingTemplate: 'loading',
});