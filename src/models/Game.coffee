class window.Game extends Backbone.Model
  initialize: ->
    ##debugger
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on 'stand', ->
      @get('dealerHand').first().flip()
      setTimeout( @get('dealerHand').dealerHit.bind( @get('dealerHand'), @get('playerHand')), 500)
    , @
    @get('playerHand').on 'bust', ->
      @winner 'You busted. Dealer wins!'
      @initialize()
    , @
    @get('dealerHand').on 'bust', ->
      @winner 'Player wins!'
      @trigger 'playerWin'
      @initialize()
    , @
    @get('dealerHand').on 'tie', ->
      @winner 'It\'s a draw!'
      @trigger 'tie'
      @initialize()
    , @
    @get('dealerHand').on 'dealerWin', ->
      @winner 'Dealer wins!'
      @initialize()
    , @

  winner: (message) ->
    setTimeout(=>
      alert(message)
      @trigger 'newGame'
    , 300)
