# coding: utf-8

class Enemy < Sprite
  def update
    self.y += rand(5)
    self.x += rand(6)-3
    if self.y >= Window.height - self.image.height
      self.vanish
    end
  end

  # 他のオブジェクトから衝突された際に呼ばれるメソッド
  def hit(obj)
    self.vanish
  end
end