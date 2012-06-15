#= require_tree vendor
#= require models/Dossier

$ ->
  ($ '#req-tree').kendoTreeView()

  dossier = new OAQ.Dossier _id:123

  dossier.on 'change', ->
    console.log dossier.get 'nomFamille'

  dossier.fetch()
