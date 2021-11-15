local activeFont = nil

function lovr.graphics.setAlphaSampling(enabled)
  lovr.graphics.setAlphaToCoverage(enabled)
end

function lovr.graphics.setCullingEnabled(enabled)
  lovr.graphics.setCullMode(enabled and 'back' or 'none')
end

function lovr.graphics.setDepthTest(test, write)
  lovr.graphics.setDepthTest(test)
  lovr.graphics.setDepthWrite(write)
end

function lovr.graphics.stencil(fn, action, value, keep)
  lovr.graphics.push('pipeline')
  lovr.graphics.setColorMask(false, false, false, false)
  lovr.graphics.setStencilTest()
  if keep == false then
    lovr.graphics.setStencilWrite('zero')
    lovr.graphics.fill()
  elseif type(keep) == 'number' then
    lovr.graphics.setStencilWrite('replace', keep)
    lovr.graphics.fill()
  end
  lovr.graphics.setStencilWrite({ action, 'keep', 'keep' }, value)
  fn()
  lovr.graphics.pop('pipeline')
end

function lovr.graphics.cube(mode, ...)
  if mode == 'line' then
    error('line cube is not supported')
  end
  lovr.graphics.cube(...)
end

function lovr.graphics.getFont()
  return activeFont or lovr.graphics.getDefaultFont()
end

function lovr.graphics.setFont(font)
  activeFont = font
end

function lovr.graphics.print(...)
  if type(...) ~= 'userdata' then
    lovr.graphics.print(activeFont, ...)
  else
    lovr.graphics.print(...)
  end
end
