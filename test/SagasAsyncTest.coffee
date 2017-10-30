import dd from 'ddeyes'

import isEqual from 'is-equal'
import co from 'co'

import onStateChange from 'redux-on-state-change'

import { createStore } from 'cfx.redux'
import { SagaMiddleware } from 'cfx.redux-saga'

import {
  reducers
  sagas
} from '../src'

import taskConf from './testConf'

export default (t) ->

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

  SagaMW = new SagaMiddleware()

  store = createStore
    counterApp: reducers
  , [
    SagaMW.getMidleware()
    onStateChange subscriber
  ]

  SagaMW.runSagas sagas

  co do ->
    store.dispatch tasks[0].actual.async()

  t.end()
