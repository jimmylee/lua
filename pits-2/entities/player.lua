local config  = require('lib.config')
local machine = require('vendor.statemachine')

local physics, tile = config.physics, config.tile

local padB = 4

local function Player(opts)
  return {
    bump = 'touch',
    camera = true,
    collision = {},
    controls = {},
    inputs = {
      actions = {
        jump = 'space',
        quit = 'q'
      },
      states = {
        up    = 'w',
        left  = 'a',
        down  = 's',
        right = 'd',
        turbo = ';'
      }
    },
    minimap = true,
    motion = {
      vx = 0,
      vy = 0,
      ax = 0,
      ay = physics.g
    },
    pad = {
      b = padB
    },
    player = true,
    pos = {
      x = opts.x,
      y = opts.y
    },
    size = {
      h = tile.h + padB,
      w = tile.w
    },
    sprite = {
      type = 'player',
      r = 255,
      g = 0,
      b = 0
    },
    state = machine.create({
      initial = 'running',
      events = {
        {
          name = 'climb',
          from = { 'falling', 'running' },
          to   = 'climbing'
        },
        {
          name = 'fall',
          from = { 'climbing', 'running' },
          to   = 'falling'
        },
        {
          name = 'jump',
          from = { 'climbing', 'running' },
          to   = 'falling'
        },
        {
          name = 'land',
          from = { 'falling', 'climbing' },
          to   = 'running'
        }
      }
    }),
    wrap = true,
    zIndex = 1000
  }
end

return Player
