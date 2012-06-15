#= require vendor/jquery
#= require vendor/bootstrap
#= require vendor/underscore
#= require vendor/backbone
#= require vendor/handlebars
#= require vendor/kendo

#= require models/Dossier
#= require views/ProfileView

$ ->
  ($ '#req-tree').kendoTreeView()

  dossier = new OAQ.Dossier _id:123

  new OAQ.ProfileView
    model: dossier
    el: ($ '#x-profile-info')


  dossier.fetch()
