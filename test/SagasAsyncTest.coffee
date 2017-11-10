import dd from 'ddeyes'

import isEqual from 'is-equal'
import co from 'co'

import onStateChange from 'redux-on-state-change'

import { getStore } from 'cfx.redux'
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

  store = getStore {
    appName: 'counterApp'
    reducers
    sagas
    subscriber:
      async: subscriber
  }

  co do ->
    store.dispatch tasks[0].actual.async()

  t.end()
