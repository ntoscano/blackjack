class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="money"></div>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('game').get('playerHand').hit()
    'click .stand-button': -> @model.get('game').get('playerHand').stand()

  initialize: ->
    @render()
    @model.get('game').on 'newGame', ->
      @render()
    , @
    test = @
    $('body').on 'keydown', (e) =>
      if e.keyCode is 72 then test.model.get('game').get('playerHand').hit()
      if e.keyCode is 74 then test.model.get('game').get('playerHand').stand()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.money').text(@model.get('money'))
    @$('.player-hand-container').html new HandView(collection: @model.get('game').get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get('game').get 'dealerHand').el

