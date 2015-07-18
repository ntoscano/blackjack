# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    ##debugger
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'stand', ->
      @get('dealerHand').first().flip()
      setTimeout( @get('dealerHand').dealerHit.bind( @get('dealerHand'), @get('playerHand')), 100)
    , @
    @get('playerHand').on 'bust', ->
      alert 'You busted. Dealer wins!'
      @initialize()
      @trigger 'newGame'
    , @
    @get('dealerHand').on 'bust', ->
      alert 'Player wins!'
      @initialize()
      @trigger 'newGame'
    , @
    @get('dealerHand').on 'tie', ->
      alert 'It\'s a draw!'
      @initialize()
      @trigger 'newGame'
    , @
    @get('dealerHand').on 'dealerWin', ->
      alert 'Dealer wins!'
      @initialize()
      @trigger 'newGame'
    , @