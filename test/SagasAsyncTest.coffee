dd = require 'ddeyes'

isEqual = require 'is-equal'
co = require 'co'
onStateChange = (
  require 'redux-on-state-change'
).default

{ createStore } = require 'cfx.redux'
{ createSagaMiddleware } = require 'cfx.redux-saga'

CounterApp = require '../src/index'
{
  reducers
  sagas
} = CounterApp

taskConf = require './testConf'

module.exports = (t) ->

  tasks = taskConf.slice()

  subscriber = (
    prevState
    nextState
    action
    dispatch
  ) ->
    return if isEqual prevState, nextState
    dd nextState
    task = tasks.shift()
    t.deepEqual nextState
    , task.expected
    , task.msg
    dispatch tasks[0].actual.async()

  store = createStore
    counterApp: reducers
  , [
    createSagaMiddleware sagas
    onStateChange subscriber
  ]

  co do ->
    store.dispatch tasks[0].actual.async()

  t.end()
