dd = require 'ddeyes'

{ createStore } = require 'cfx.redux'

CounterApp = require '../src/index'
{ reducers } = CounterApp

taskConf = require './testConf'

module.exports = (t) ->

  tasks = taskConf.slice()

  store = createStore
    counterApp: reducers

  dd store.getState()

  unsubscribe = store.subscribe ->
    state = store.getState()
    task = tasks.shift()
    dd state
    t.deepEqual state
    , task.expected
    , task.msg

  for task in tasks.slice()
    store.dispatch task.actual.sync()

  unsubscribe()

  t.end()
