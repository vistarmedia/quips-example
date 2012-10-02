$         = require 'jqueryify2'
Backbone  = require 'backbone'
Quips     = require 'quips'

LoginView = require 'views/login_view'

loginLayout = require 'templates/login/layout'
navTemplate = require 'templates/navigation/index'

class App

  constructor: (@apiRoot) ->
    module.exports.apiRoot = @apiRoot

    root = $('body')
    @loginController = new Quips.LoginController(loginLayout,
                            LoginView, el: root)

    (do @login)
      .pipe(@showUI)

  login: =>
    Quips.User.authenticateAgainst(@apiRoot)
    @loginController.login()

  showUI: =>
    layout = $('body').empty().append(require 'templates/layout')

    main        = layout.find('.body')
    navigation  = layout.find('.navigation')

    new Quips.NavigationController(Quips.User.current,
          navTemplate, el: navigation).activate()

    Backbone.history.start()

module.exports.app = App
