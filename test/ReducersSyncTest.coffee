import dd from 'ddeyes'
import { createStore } from 'cfx.redux'
import { reducers } from '../src'

import taskConf from './testConf'

export default (t) ->

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
