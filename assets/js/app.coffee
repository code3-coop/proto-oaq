#= require vendor/jquery
#= require vendor/bootstrap
#= require vendor/underscore
#= require vendor/backbone
#= require vendor/handlebars
#= require vendor/kendo

#= require models/Dossier
#= require models/Application
#= require views/ProfileView
#= require views/ContextView

$ ->
  ($ '#req-tree').kendoTreeView()

  application = new OAQ.Application()
  application.set 'currDossier', new OAQ.Dossier(_id:Math.floor((Math.random()*100)+1))

  new OAQ.ProfileView
    model: application
    el: ($ '#x-profile-info-curr')

  new OAQ.ContextView
    model: application
    el: ($ '#x-current-context')

  ($ '#x-profile-nav-next').on 'click', ->
    application.cycleToNext()
  ($ '#x-profile-nav-prev').on 'click', ->
    application.cycleToPrev()

  application.fetchAll()
