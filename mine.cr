require "./miner"
require "json"

DATA = JSON.parse(File.read("data/all.json"))

miner = Miner.new(data_hash: DATA)

miner.dump
