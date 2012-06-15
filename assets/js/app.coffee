#= require vendor/jquery
#= require vendor/bootstrap
#= require vendor/underscore
#= require vendor/backbone
#= require vendor/handlebars
#= require vendor/kendo

#= require models/Dossier
#= require views/ProfileView
#= require views/ContextView

$ ->
  ($ '#req-tree').kendoTreeView()

  dossier = new OAQ.Dossier _id:123

  new OAQ.ProfileView
    model: dossier
    el: ($ '#x-profile-info')

  new OAQ.ContextView
    model: dossier
    el: ($ '#x-current-context')

  dossier.fetch()
