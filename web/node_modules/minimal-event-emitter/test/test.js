const sinon = require('sinon');

const eventEmitter = require('../index.js');

suite('EventEmitter', () => {

  let obj;

  setup(() => {
    const Class = function() {};
    eventEmitter(Class);
    obj = new Class();
  });

  teardown(() => {
    sinon.restore();
  });

  test('no listeners', () => {
    obj.emit('foo', 1, 2, 3);
  });

  test('single listener', () => {
    const listener = sinon.fake();
    obj.addEventListener('foo', listener);
    obj.emit('foo');
    sinon.assert.calledOnce(listener);
    obj.removeEventListener('foo', listener);
    obj.emit('foo');
    sinon.assert.calledOnce(listener);
  });

  test('different listeners for same event', () => {
    const firstListener = sinon.fake();
    const secondListener = sinon.fake();
    obj.addEventListener('foo', firstListener);
    obj.addEventListener('foo', secondListener);
    obj.emit('foo');
    sinon.assert.calledOnce(firstListener);
    sinon.assert.calledOnce(secondListener);
    obj.removeEventListener('foo', firstListener);
    obj.emit('foo');
    sinon.assert.calledOnce(firstListener);
    sinon.assert.calledTwice(secondListener);
    obj.removeEventListener('foo', secondListener);
    obj.emit('foo');
    sinon.assert.calledOnce(firstListener);
    sinon.assert.calledTwice(secondListener);
  });

  test('same listener for different events', () => {
    const listener = sinon.fake();
    obj.addEventListener('foo', listener);
    obj.addEventListener('bar', listener);
    obj.emit('foo');
    sinon.assert.calledOnce(listener);
    obj.emit('bar');
    sinon.assert.calledTwice(listener);
    obj.removeEventListener('foo', listener);
    obj.emit('foo');
    sinon.assert.calledTwice(listener);
    obj.emit('bar');
    sinon.assert.calledThrice(listener);
    obj.removeEventListener('bar', listener);
    obj.emit('bar');
    sinon.assert.calledThrice(listener);
  });

  test('different listeners for different events', () => {
    const fooListener = sinon.fake();
    const barListener = sinon.fake();
    obj.addEventListener('foo', fooListener);
    obj.addEventListener('bar', barListener);
    obj.emit('foo');
    sinon.assert.calledOnce(fooListener);
    sinon.assert.notCalled(barListener);
    obj.emit('bar');
    sinon.assert.calledOnce(fooListener);
    sinon.assert.calledOnce(barListener);
  });

  test('argument forwarding', () => {
    const listener = sinon.fake();
    const array = [];
    obj.addEventListener('foo', listener);
    obj.emit('foo');
    obj.emit('foo', 42, 'abc', null, undefined, array);
    obj.emit('foo', 1, 2, 3);
    sinon.assert.calledThrice(listener);
    sinon.assert.calledWithExactly(
        listener.getCall(0));
    sinon.assert.calledWithExactly(
        listener.getCall(1), 42, 'abc', null, undefined, array);
    sinon.assert.calledWithExactly(
        listener.getCall(2), 1, 2, 3);
    sinon.assert.alwaysCalledOn(listener, obj);
  });

  test('call order', () => {
    const firstListener = sinon.fake();
    const secondListener = sinon.fake();
    obj.addEventListener('foo', firstListener);
    obj.addEventListener('foo', secondListener);
    obj.emit('foo');
    sinon.assert.callOrder(firstListener, secondListener);
    firstListener.resetHistory();
    secondListener.resetHistory();
    obj.removeEventListener('foo', firstListener);
    obj.addEventListener('foo', firstListener);
    obj.emit('foo');
    sinon.assert.callOrder(secondListener, firstListener);
  });

  test('already registered listener', () => {
    const listener = sinon.fake();
    obj.addEventListener('foo', listener);
    obj.addEventListener('foo', listener);
    obj.emit('foo');
    sinon.assert.calledOnce(listener);
  });

  test('never registered listener', () => {
    const listener = sinon.fake();
    obj.addEventListener('foo', listener);
    obj.removeEventListener('foo', () => {});
    obj.emit('foo');
    sinon.assert.calledOnce(listener);
  });

});
