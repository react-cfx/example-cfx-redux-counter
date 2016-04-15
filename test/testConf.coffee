CounterApp = require '../src/index'
{ actions } = CounterApp

{
  increment
  incrementAsync
  decrement
  decrementAsync
} = actions

module.exports = [
    actual:
      sync: -> increment()
      async: -> incrementAsync()
    expected: counterApp: count: 1
    msg: '0 + 1 = 1'
  ,
    actual:
      sync: -> increment 5
      async: -> incrementAsync 5
    expected: counterApp: count: 6
    msg: '1 + 5 = 6'
  ,
    actual:
      sync: -> decrement 2
      async: -> decrementAsync 2
    expected: counterApp: count: 4
    msg: '6 - 2 = 4'
  ,
    actual:
      sync: -> decrement 3
      async: -> decrementAsync 3
    expected: counterApp: count: 1
    msg: '4 - 3 = 1'
  ,
    actual:
      sync: -> increment 4
      async: -> incrementAsync 4
    expected: counterApp: count: 5
    msg: '1 + 4 = 5'
]
