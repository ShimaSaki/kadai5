# coding: utf-8

class Drop < Sprite
  def update
    self.y += 1
    if self.y >= Window.height - self.image.height
      self.vanish
    end
  end

  # 他のオブジェクトから衝突された際に呼ばれるメソッド
  def hit(obj)
    self.vanish
  end
end