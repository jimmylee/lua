require "objects/entity"

DynamicEntity = Entity:extend()

local PHYSICS_MULTIPLIER = 65;

function DynamicEntity:new(x, y, w, h, image, world, mvx, mvy, name, mass)
  DynamicEntity.super.new(self, x, y, w, h, image, world, name)
  self.mvx = mvx;
  self.mvy = mvy;
  self.xv = 0;
  self.yv = 0;
  self.direction = 1;
  self.grounded = false;
  self.mass = mass or 1
  
  GRAVITY = world.gravity or 9.8
end

function DynamicEntity:checkCols(cols)
  self.grounded = false
	for i,v in ipairs (cols) do
		if cols[i].normal.y == -1 then
			self.yv = 0
			self.grounded = true
		elseif cols[i].normal.y == 1 then
			self.yv = -self.yv / 4
		end

		if cols[i].normal.x ~= 0 then
			self.xv = 0
		end
	end
end

function DynamicEntity:updatePhysics(dt)
  if self.grounded == true then
    self.xv = self.xv - 50 * dt * PHYSICS_MULTIPLIER
  else
    self.xv = self.xv - (8 * self.mass) * dt * PHYSICS_MULTIPLIER
  end
	
	self.yv = self.yv + (GRAVITY) * dt * PHYSICS_MULTIPLIER

	if self.xv > self.mvx then 
    self.xv = self.mvy
  end

	if self.xv < 0 then 
    self.xv = 0 
  end

	self.x = self.x + self.direction * self.xv * dt
	self.y = self.y + (self.yv) * dt
end
