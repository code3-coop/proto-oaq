#= require vendor/jquery
#= require vendor/bootstrap
#= require vendor/underscore
#= require vendor/backbone
#= require vendor/kendo

#= require models/Dossier

$ ->
  ($ '#req-tree').kendoTreeView()

  dossier = new OAQ.Dossier _id:123

  dossier.on 'change', ->
    console.log dossier.get 'nomFamille'

  dossier.fetch()
