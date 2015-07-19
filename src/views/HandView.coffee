class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'remove change', => @render()
    @collection.on 'add', =>
      @addCard()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text @collection.highestLegalScore()

  addCard: ->
    @$el.append new CardView(model: @collection.last()).$el
    @$('.score').text @collection.highestLegalScore()
