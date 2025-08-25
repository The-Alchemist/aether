Aether = require '../aether'

describe "Karl's Simple Closer/Clojure Test", ->
  describe "Try requiring closer", ->
    it "doesn't immediately break", ->
      closer = require 'closer'
      expect(closer).toBeDefined()
      result = closer.parse "(+ 3 45)"
      escodegen = require('escodegen')
      expect(eval(escodegen.generate(result))).toBe(48)

    it "run through Aether", ->
      aether = new Aether(language: 'clojure')
      aether.transpile "(+ 3 45)"
      expect(aether.run()).toBe(48)
