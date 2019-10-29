local insert = table.insert

local assign, bind, clamp, compose, concat, converge, flatten, identity, inRange, keys, map, mapreduce, min, max, path, prop, reduce, sample, unfold

-- `({ s = a }, { s = a }) -> { s = a }`.
assign = function(a, b)
  for k, v in pairs(b) do
    a[k] = v
  end
  return a
end

-- `((a, b, ...) -> c, a) -> (b, ...) -> c`.
bind = function(f, ctx)
  return function(...)
    return f(ctx, ...)
  end
end

-- `(number, number, number) -> number`.
clamp = function(lo, hi, x)
  return x < lo and lo
      or x > hi and hi
      or x
end

-- `((y -> z), ..., (a -> b)) -> a -> z`.
compose = function(...)
  local fs = {...}
  return function(...)
    local res = fs[#fs](...)
    for i = #fs-1, 1, -1 do
      res = fs[i](res)
    end
    return res
  end
end

-- `([a], [a]) -> [a]`.
concat = function(a, b)
  for _, v in ipairs(b) do
    insert(a, v)
  end
  return a
end

-- `((a, b) -> c, [ d -> a, d -> b ]) -> d -> c`.
converge = function(after, diverge)
  return function(...)
    local a = diverge[1](...)
    local b = diverge[2](...)
    return after(a, b)
  end
end

-- `[[a]] -> [a]`.
flatten = function(lists)
  return reduce(concat, {}, lists)
end

-- `a -> a`.
identity = function(...)
  return ...
end

-- `(number, number, number) -> boolean`.
inRange = function(lo, hi, x)
  return x >= lo and x < hi
end

-- `{ s = a } -> [s]`.
keys = function(obj)
  local res = {}
  for k in pairs(obj) do
    insert(res, k)
  end
  return res
end

-- `(a -> b, [a]) -> [b]`.
map = function(f, list)
  for i, v in ipairs(list) do
    list[i] = f(v, i)
  end
  return list
end

-- `(b -> c, (a, c) -> a, a, [b]) -> a`.
mapreduce = function(f, g, init, list)
  for _, v in ipairs(list) do
    init = g(init, f(v))
  end
  return init
end

-- `(number, number) -> number`.
max = function(a, b)
  return a > b and a or b
end

-- `(number, number) -> number`.
min = function(a, b)
  return a < b and a or b
end

-- `[string] -> { s = a } -> a`.
path = function(ks)
  return function(obj)
    for _, k in ipairs(ks) do
      obj = obj[k]
    end
    return obj
  end
end

-- `string -> { s = a } -> a`.
prop = function(k)
  return function(obj)
    return obj[k]
  end
end

-- `((a, b) -> a, a, [b]) -> a`.
reduce = function(f, init, list)
  for _, v in ipairs(list) do
    init = f(init, v)
  end
  return init
end

-- `[a] -> a`.
sample = function(list)
  return list[math.random(1,#list)]
end

-- `(a -> { b, a } | boolean, a) -> [b]`.
unfold = function(f, seed)
  local res = {}
  local pair = f(seed)
  while pair do
    insert(res, pair[1])
    pair = f(pair[2])
  end
  return res
end

local util = {
  assign    = assign,
  bind      = bind,
  clamp     = clamp,
  compose   = compose,
  concat    = concat,
  converge  = converge,
  flatten   = flatten,
  identity  = identity,
  inRange   = inRange,
  keys      = keys,
  map       = map,
  mapreduce = mapreduce,
  max       = max,
  min       = min,
  path      = path,
  prop      = prop,
  reduce    = reduce,
  sample    = sample,
  unfold    = unfold
}

util.import = function(ctx)
  ctx = ctx or _G
  assign(ctx, util)
  return ctx
end

return util
