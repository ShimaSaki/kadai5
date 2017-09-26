# coding: utf-8

class Player < Sprite
  def update
    self.x += Input.x
  end
end