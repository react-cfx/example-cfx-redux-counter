dd = require 'ddeyes'

isEqual = require 'is-equal'
co = require 'co'

onStateChange = (
  require 'redux-on-state-change'
).default

# { createStore } = require 'cfx.redux'
{ createStore, applyMiddleware, combineReducers } = require 'redux'
# { SagaMiddleware } = require 'cfx.redux-saga'
createSagaMiddleware = (
  require 'redux-saga'
).default

CounterApp = (require '../dest/index').default
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
    dispatch tasks[0].actual.async() if tasks[0]

  # SagaMW = new SagaMiddleware()
  sagaMiddleware = createSagaMiddleware()

  store = createStore (
    combineReducers
      counterApp: reducers
  )
  , applyMiddleware sagaMiddleware , (onStateChange subscriber)
  # [
  #   # SagaMW.getMiddleware()
  #   sagaMiddleware
  #   onStateChange subscriber
  # ]

  # SagaMW.runSagas sagas
  for saga in sagas
    sagaMiddleware.run saga

  co do ->
    store.dispatch tasks[0].actual.async()

  t.end()
