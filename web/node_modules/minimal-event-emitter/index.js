'use strict';

/**
 * @class
 * @classdesc Minimalistic event emitter mixin.
 */
function EventEmitter() {}

/**
 * Registers an event listener for the specified event. If the listener has
 * already been registered for the event, this is a no-op.
 *
 * @param {string} name The event name.
 * @param {function} fn The listener function.
 */
EventEmitter.prototype.addEventListener = function(name, fn) {
  var eventMap = this.__events = this.__events || {};
  var handlerList = eventMap[name] = eventMap[name] || [];
  if (handlerList.indexOf(fn) < 0) {
    handlerList.push(fn);
  }
};

/**
 * Unregisters an event listener from the specified event. If the listener
 * hasn't been registered for the event, this is a no-op.
 *
 * @param {string} name The event name.
 * @param {function} fn The listener function.
 */
EventEmitter.prototype.removeEventListener = function(name, fn) {
  var eventMap = this.__events = this.__events || {};
  var handlerList = eventMap[name];
  if (handlerList) {
    var index = handlerList.indexOf(fn);
    if (index >= 0) {
      handlerList.splice(index, 1);
    }
  }
};

/**
 * Emits an event, causing all registered event listeners for that event to be
 * called in registration order.
 *
 * @param {string} name The event name.
 * @param {...*} var_args Arguments to call listeners with.
 */
EventEmitter.prototype.emit = function(name, var_args) {
  var eventMap = this.__events = this.__events || {};
  var handlerList = eventMap[name];
  var args = Array.prototype.slice.call(arguments, 1);
  if (handlerList) {
    for (var i = 0; i < handlerList.length; i++) {
      var fn = handlerList[i];
      fn.apply(this, args);
    }
  }
};

/**
 * Mixes in {@link EventEmitter} into a constructor function.
 *
 * @param {function} ctor The constructor function.
 */
function eventEmitter(ctor) {
  for (var prop in EventEmitter.prototype) {
    if (EventEmitter.prototype.hasOwnProperty(prop)) {
      ctor.prototype[prop] = EventEmitter.prototype[prop];
    }
  }
}

module.exports = eventEmitter;
