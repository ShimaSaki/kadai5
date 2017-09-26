# coding: utf-8
require 'dxruby'

require_relative 'player'
require_relative 'enemy'
require_relative 'drop'

Window.width  = 800
Window.height = 600

player_img = Image.load_tiles("player.png", 6, 1)
enemy_img = Image.load("enemy.png")
drop_img = Image.load("water.png")

# フォントの設定
font1 = Font.new(32)
font2 = Font.new(50)

# あたり判定・花の成長度・時間の初期化
col = [0, 80, 100, 224]
growth = 0
count = 7200
time = count / 60

player = Player.new(400, 400, player_img[0])
player.collision = col

enemies = []
drops = []

Window.loop do
  break if Input.keyPush?(K_ESCAPE)

  if rand(500) == 0 && growth < 50
    enemies << Enemy.new(rand(800), rand(200), enemy_img)
  end

  if rand(100) == 0 && growth < 50
    drops << Drop.new(rand(800), rand(200), drop_img)
  end

  Sprite.update(enemies)
  Sprite.draw(enemies)

  Sprite.update(drops)
  Sprite.draw(drops)

  player.update
  player.draw

  # 当たり判定
  if Sprite.check(player, enemies) && growth > 0
    growth -= 1
  end

  # しずくを取ったら成長度+2
  # 成長度に合わせて花の見た目を変化させる
  if Sprite.check(player, drops)
    growth += 2
    case
      when growth < 10
        player = Player.new(player.x, player.y, player_img[0])
      when growth >= 10 && growth < 20
        player = Player.new(player.x, player.y, player_img[1])
      when growth >= 20 && growth < 30
        player = Player.new(player.x, player.y, player_img[2])
      when growth >= 30 && growth < 40
        player = Player.new(player.x, player.y, player_img[3])
      when growth >= 40 && growth < 50
        player = Player.new(player.x, player.y, player_img[4])
      when growth >= 50
        player = Player.new(player.x, player.y, player_img[5])
    end
    player.collision = col
  end

  # ゲームクリア
  if growth >= 50
    Window.draw_font(240, 200, "GAME CLEAR!!", font2)
    Window.draw_font(240, 250, "  Continue -> Space", font1)
    Window.draw_font(240, 290, "     End   ->  Esc ", font1)
    
    # コンティニュー
    if Input.keyPush?(K_SPACE)
      growth = 0
      count = 7200
      player = Player.new(400, 400, player_img[0])
      player.collision = col
    end
  end

  # ゲームオーバー
  if count <= 0
    Window.draw_font(240, 200, "GAME OVER!!", font2)
    Window.draw_font(240, 250, "  Continue -> Space", font1)
    Window.draw_font(240, 290, "     End   ->  Esc ", font1)
    
    # コンティニュー
    if Input.keyPush?(K_SPACE)
      growth = 0
      count = 7200
      player = Player.new(400, 400, player_img[0])
      player.collision = col
    end
  end

  # 残り時間の表示
  Window.draw_font(0, 0, "残り時間：#{time}秒", font1)
  
  # カウントダウンと秒数の計算
  if count >= 0 && growth < 50
    count -= 1
    time = count / 60
  end
end