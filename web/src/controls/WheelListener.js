/*
 * Copyright 2016 Google Inc. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *   http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
'use strict';

var clearOwnProperties = require('../util/clearOwnProperties');

// Cross-browser mouse wheel event listener.
// Adapted from: https://developer.mozilla.org/en-US/docs/Web/Events/wheel
// This version requires eventShim.
function WheelListener(elem, callback, useCapture) {
  var eventName = getEventName();

  if (eventName === 'wheel') {
    this._fun = callback;
    this._elem = elem;
    this._elem.addEventListener('wheel', this._fun, useCapture);
  } else if (eventName === 'mousewheel') {
    this._fun = fallbackHandler(callback);
    this._elem = elem;
    this._elem.addEventListener('mousewheel', this._fun, useCapture);
  } else {
    throw new Error('Browser does not support mouse wheel events');
  }
}

/**
 * Destructor.
 */
WheelListener.prototype.destroy = function() {
  this._elem.removeEventListener(getEventName(), this._fun);
  clearOwnProperties(this);
};

function fallbackHandler(callback) {
  return function handleWheelEvent(originalEvent) {
    if (!originalEvent) {
      originalEvent = window.event;
    }

    // Create a normalized event object.
    var event = {
      originalEvent: originalEvent,
      target: originalEvent.target || originalEvent.srcElement,
      type: "wheel",
      deltaMode: 1,
      deltaX: 0,
      deltaZ: 0,
      timeStamp: originalEvent.timeStamp || Date.now(),
      preventDefault: originalEvent.preventDefault.bind(originalEvent)
    };

    // Calculate deltaY.
    event.deltaY = - 1/40 * originalEvent.wheelDelta;
    if (originalEvent.wheelDeltaX) {
      // Calculate deltaX.
      event.deltaX = - 1/40 * originalEvent.wheelDeltaX;
    }

    // Fire the callback.
    return callback(event);
  };
}

// Detect the supported wheel event name and cache the result.
var eventName;
function getEventName() {
  if (eventName !== undefined) {
    return eventName;
  }
  if ('onwheel' in document.createElement('div')) {
    // Modern browsers support 'wheel'.
    return (eventName = 'wheel');
  } else if (document.onmousewheel !== undefined) {
    // Webkit and IE support at least 'mousewheel'.
    return (eventName = 'mousewheel');
  } else {
    return (eventName = null);
  }
}

module.exports = WheelListener;
