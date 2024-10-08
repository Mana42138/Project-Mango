local Main = {}
local value = 0
local pow = math.pow
local sin = math.sin
local cos = math.cos
local pi = math.pi
local sqrt = math.sqrt
local abs = math.abs
local asin	= math.asin

function Main:ClampedSpeed(speed, debug)
    value = value + g_GlobalVars.frametime * speed * 0.01
    local value_clamped = math.max(0, math.min(1, (value % 2) - 0.5))

	if not debug then return value_clamped else
    return (value_clamped), (print(value_clamped))
	end
end

function Main:clamp(val, min, max) 
    if val > max then
        return max
    end

    if val < min then
        return min
    end

    return val
end

function Main:linear(t, b, c, d)
	return c * t / d + b
end

function Main:inQuad(t, b, c, d)
	t = t / d
	return c * pow(t, 2) + b
end

function Main:outQuad(t, b, c, d)
	t = t / d
	return -c * t * (t - 2) + b
end

function Main:inOutQuad(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return c / 2 * pow(t, 2) + b
	else
		return -c / 2 * ((t - 1) * (t - 3) - 1) + b
	end
end

function Main:outInQuad(t, b, c, d)
	if t < d / 2 then
		return Main:outQuad (t * 2, b, c / 2, d)
	else
		return Main:inQuad((t * 2) - d, b + c / 2, c / 2, d)
	end
end

function Main:inCubic (t, b, c, d)
	t = t / d
	return c * pow(t, 3) + b
end

function Main:outCubic(t, b, c, d)
	t = t / d - 1
	return c * (pow(t, 3) + 1) + b
end

function Main:inOutCubic(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return c / 2 * t * t * t + b
	else
		t = t - 2
		return c / 2 * (t * t * t + 2) + b
	end
end

function Main:outInCubic(t, b, c, d)
	if t < d / 2 then
		return Main:outCubic(t * 2, b, c / 2, d)
	else
		return Main:inCubic((t * 2) - d, b + c / 2, c / 2, d)
	end
end

function Main:inQuart(t, b, c, d)
	t = t / d
	return c * pow(t, 4) + b
end

function Main:outQuart(t, b, c, d)
	t = t / d - 1
	return -c * (pow(t, 4) - 1) + b
end

function Main:inOutQuart(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return c / 2 * pow(t, 4) + b
	else
		t = t - 2
		return -c / 2 * (pow(t, 4) - 2) + b
	end
end

function Main:outInQuart(t, b, c, d)
	if t < d / 2 then
		return Main:outQuart(t * 2, b, c / 2, d)
	else
		return Main:inQuart((t * 2) - d, b + c / 2, c / 2, d)
	end
end

function Main:inQuint(t, b, c, d)
	t = t / d
	return c * pow(t, 5) + b
end

function Main:outQuint(t, b, c, d)
	t = t / d - 1
	return c * (pow(t, 5) + 1) + b
end

function Main:inOutQuint(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return c / 2 * pow(t, 5) + b
	else
		t = t - 2
		return c / 2 * (pow(t, 5) + 2) + b
	end
end

function Main:outInQuint(t, b, c, d)
	if t < d / 2 then
		return Main:outInQuart(t * 2, b, c / 2, d)
	else
		return Main:inQuint((t * 2) - d, b + c / 2, c / 2, d)
	end
end

function Main:inSine(t, b, c, d)
	return -c * cos(t / d * (pi / 2)) + c + b
end

function Main:outSine(t, b, c, d)
	return c * sin(t / d * (pi / 2)) + b
end

function Main:inOutSine(t, b, c, d)
	return -c / 2 * (cos(pi * t / d) - 1) + b
end

function Main:outInSine(t, b, c, d)
	if t < d / 2 then
		return Main:outSine(t * 2, b, c / 2, d)
	else
		return Main:inSine((t * 2) -d, b + c / 2, c / 2, d)
	end
end

function Main:inExpo(t, b, c, d)
	if t == 0 then
		return b
	else
		return c * pow(2, 10 * (t / d - 1)) + b - c * 0.001
	end
end

function Main:outExpo(t, b, c, d)
	if t == d then
		return b + c
	else
		return c * 1.001 * (-pow(2, -10 * t / d) + 1) + b
	end
end

function Main:inOutExpo(t, b, c, d)
	if t == 0 then return b end
	if t == d then return b + c end
	t = t / d * 2
	if t < 1 then
		return c / 2 * pow(2, 10 * (t - 1)) + b - c * 0.0005
	else
		t = t - 1
		return c / 2 * 1.0005 * (-pow(2, -10 * t) + 2) + b
	end
end

function Main:outInExpo(t, b, c, d)
	if t < d / 2 then
		return Main:outExpo(t * 2, b, c / 2, d)
	else
		return Main:inExpo((t * 2) - d, b + c / 2, c / 2, d)
	end
end

function Main:inCirc(t, b, c, d)
	t = t / d
	return(-c * (sqrt(1 - pow(t, 2)) - 1) + b)
end

function Main:outCirc(t, b, c, d)
	t = t / d - 1
	return(c * sqrt(1 - pow(t, 2)) + b)
end

function Main:inOutCirc(t, b, c, d)
	t = t / d * 2
	if t < 1 then
		return -c / 2 * (sqrt(1 - t * t) - 1) + b
	else
		t = t - 2
		return c / 2 * (sqrt(1 - t * t) + 1) + b
	end
end

function Main:outInCirc(t, b, c, d)
	if t < d / 2 then
		return Main:outCirc(t * 2, b, c / 2, d)
	else
		return Main:inCirc((t * 2) - d, b + c / 2, c / 2, d)
	end
end

function Main:inElastic(t, b, c, d, a, p)
	if t == 0 then return b end

	t = t / d

	if t == 1	then return b + c end

	if not p then p = d * 0.3 end

	local s

	if not a or a < abs(c) then
		a = c
		s = p / 4
	else
		s = p / (2 * pi) * asin(c/a)
	end

	t = t - 1

	return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
end

-- a: amplitud
-- p: period
function Main:outElastic(t, b, c, d, a, p)
	if t == 0 then return b end

	t = t / d

	if t == 1 then return b + c end

	if not p then p = d * 0.3 end

	local s

	if not a or a < abs(c) then
		a = c
		s = p / 4
	else
		s = p / (2 * pi) * asin(c/a)
	end

	return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p) + c + b
end

-- p = period
-- a = amplitud
function Main:inOutElastic(t, b, c, d, a, p)
	if t == 0 then return b end

	t = t / d * 2

	if t == 2 then return b + c end

	if not p then p = d * (0.3 * 1.5) end
	if not a then a = 0 end

	local s

	if not a or a < abs(c) then
		a = c
		s = p / 4
	else
		s = p / (2 * pi) * asin(c / a)
	end

	if t < 1 then
		t = t - 1
		return -0.5 * (a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
	else
		t = t - 1
		return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p ) * 0.5 + c + b
	end
end

-- a: amplitud
-- p: period
function Main:outInElastic(t, b, c, d, a, p)
	if t < d / 2 then
		return Main:outElastic(t * 2, b, c / 2, d, a, p)
	else
		return Main:inElastic((t * 2) - d, b + c / 2, c / 2, d, a, p)
	end
end

function Main:inBack(t, b, c, d, s)
	if not s then s = 1.70158 end
	t = t / d
	return c * t * t * ((s + 1) * t - s) + b
end

function Main:outBack(t, b, c, d, s)
	if not s then s = 1.70158 end
	t = t / d - 1
	return c * (t * t * ((s + 1) * t + s) + 1) + b
end

function Main:inOutBack(t, b, c, d, s)
	if not s then s = 1.70158 end
	s = s * 1.525
	t = t / d * 2
	if t < 1 then
		return c / 2 * (t * t * ((s + 1) * t - s)) + b
	else
		t = t - 2
		return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b
	end
end

function Main:outInBack(t, b, c, d, s)
	if t < d / 2 then
		return Main:outBack(t * 2, b, c / 2, d, s)
	else
		return Main:inBack((t * 2) - d, b + c / 2, c / 2, d, s)
	end
end

function Main:outBounce(t, b, c, d)
	t = t / d
	if t < 1 / 2.75 then
		return c * (7.5625 * t * t) + b
	elseif t < 2 / 2.75 then
		t = t - (1.5 / 2.75)
		return c * (7.5625 * t * t + 0.75) + b
	elseif t < 2.5 / 2.75 then
		t = t - (2.25 / 2.75)
		return c * (7.5625 * t * t + 0.9375) + b
	else
		t = t - (2.625 / 2.75)
		return c * (7.5625 * t * t + 0.984375) + b
	end
end

function Main:inBounce(t, b, c, d)
	return c - Main:outBounce(d - t, 0, c, d) + b
end

function Main:inOutBounce(t, b, c, d)
	if t < d / 2 then
		return Main:inBounce(t * 2, 0, c, d) * 0.5 + b
	else
		return Main:outBounce(t * 2 - d, 0, c, d) * 0.5 + c * .5 + b
	end
end

function Main:outInBounce(t, b, c, d)
	if t < d / 2 then
		return Main:outBounce(t * 2, b, c / 2, d)
	else
		return Main:inBounce((t * 2) - d, b + c / 2, c / 2, d)
	end
end

return Main
