require 'gosu'

module ZOrder
	BACKGROUND, MIDDLE, TOP =*0..2
end
		
class Menu < Gosu::Window
	def initialize
		#game resolution
		super 1280,720
		
		#caption of game
		self.caption = "Monster Dash.exe"

		#initial background
		@background3 = Gosu::Image.new("./Assets/Backgrounds/MORNING.png", :tileable => true)

		#title of game
		@menutext1 = Gosu::Image.new("./Assets/Texts/MONSTER_DASH.png")
		
		#music played in menu
		@menumusic = Gosu::Song.new("./Assets/Soundtracks/menu theme.mp3")
		
		#play button images
		@play = Array.new(2)
		for i in 0..@play.length-1
			@play[i] = Gosu::Image.new("./Assets/Texts/PLAYBUTTON#{i+1}.png")
		end

		#score button images
		@score = Array.new(2)
		for i in 0..@score.length-1 
			@score[i] = Gosu::Image.new("./Assets/Texts/SCORES#{i+1}.png")
		end

		#exit button images
		@exit = Array.new(2)
		for i in 0..@exit.length-1 
			@exit[i] = Gosu::Image.new("./Assets/Texts/EXIT#{i+1}.png")
		end
		
		#player at menu screen 
		@player_frames = 4
		@menuplayer = Array.new(@player_frames) 
		for i in 0..@player_frames
			@menuplayer[i] = Gosu::Image.new("./Assets/Overwatch sprites/Genji/Warrior Salute/#{i}.png")
		end	

		#monster at menu screen 
		@monster_frames = 16  
		@menumonster = Array.new(@monster_frames)
		for j in 0..@monster_frames
			@menumonster[j] = Gosu::Image.new("./Assets/Overwatch sprites/Robot/Stand/#{j}.png") 
		end
		
		#player text bubble
		@genjitextframes = 2 
		@genjitext = Array.new(@genjitextframes)
		for i in 1..@genjitextframes
			@genjitext[i-1] = Gosu::Image.new("./Assets/Texts/speechbubblegenji#{i}.png")
		end

		#monster text bubble
		@monstertextframes = 2 
		@monstertext = Array.new(@monstertextframes)
		for i in 1..@monstertextframes
			@monstertext[i-1] = Gosu::Image.new("./Assets/Texts/speechbubblerobot#{i}.png")
		end
	
		#frame control
		@framenum = @framenum1 = @framenum2 = @framenum3 = 0
		
		#player position 
		@player_postx = 420
		@player_posty = 540 

		#monster position 
		@monster_postx = 30
		@monster_posty = 355

		#player speech bubble position
		@player_speechx = 350
		@player_speechy = 400

		#monster speech bubble position 
		@monster_speechx = 70
		@monster_speechy = 270

		#player animation frame
		@player_frame = 1

		#monster animation frame
		@monster_frame = 1

		#player text frame
		@genjitext_frame = 1
	
		#monster text frame
		@monstertext_frame = 1

		#mouse location array
		@locs = [60,60]

		#play button position
		@playbuttonx = 900
		@playbuttony = 300

		#score button position
		@scorebuttonx = 900
		@scorebuttony = 400

		#exit button position
		@exitbuttonx = 900
		@exitbuttony = 500
		

		#display play button
		@displayplaybutton = @play[0] 

		#display score button
		@displayscorebutton = @score[0]

		#display exit button
		@displayexitbutton = @exit[0]
	end
	
	#display cursor on screen
	def needs_cursor?; true; end

	def update
		#player speech bubble animation
		@genjitext_frame += 0.00625
		if @genjitext_frame >= @genjitextframes + 1
			@genjitext_frame = 1
		end

		#monster speech bubble animation
		@monstertext_frame += 0.00625
		if @monstertext_frame >= @monstertextframes + 1
			@monstertext_frame = 1
		end
		
		#player model animation
		@player_frame += 0.1
		if @player_frame >= @player_frames + 2
			@player_frame = 1
		end

		#monster model animation
		@monster_frame += 0.1 
		if @monster_frame >= @monster_frames + 2
			@monster_frame = 1
		end 

		#player animation control
		@framenum += 0.1
		if @framenum >= @player_frames + 1
			@framenum = 0
		end

		#monster animation control
		@framenum1 += 0.1
		if @framenum1 >= @monster_frames + 1
			@framenum1 = 0
		end
		
		#player speech bubble animation control
		@framenum2 += 0.00625
		if @framenum2 >= @genjitextframes
			@framenum2 = 0
		end

		#monster speech bubble animation control
		@framenum3 += 0.00625
		if @framenum3 >= @monstertextframes 
			@framenum3 = 0
		end 

		#store mouse position
		@locs = [mouse_x,mouse_y]

		#play button 
		if ((@locs[0] >= @playbuttonx and @locs[0] <= @playbuttonx + 200) and (@locs[1] >= @playbuttony and @locs[1] <=@playbuttony +50))
			@displayplaybutton = @play[1] 
			if  Gosu.button_down? Gosu::MsLeft
				@menumusic.stop 
		 		Game.new.show
		 	end

		#score button
		elsif ((@locs[0]>=@scorebuttonx and @locs[0] <=@scorebuttonx + 300) and (@locs[1] >=@scorebuttony and @locs[1] <=@scorebuttony +50))		
			@displayscorebutton = @score[1] 
			if  Gosu.button_down? Gosu::MsLeft
				@menumusic.stop
				SCORES.new.show
			end

		#exit button
		elsif ((@locs[0]>=@exitbuttonx and @locs[0] <=@exitbuttonx + 200) and (@locs[1] >=@exitbuttony and @locs[1] <=@exitbuttony +50))
			@displayexitbutton = @exit[1]
			if  Gosu.button_down? Gosu::MsLeft
				@menumusic.stop
			
				exit
			end
		else
			#button doesnt light up when mouse hovers it
			@displayplaybutton = @play[0] 
			@displayscorebutton = @score[0] 
			@displayexitbutton = @exit[0]
		end
   	end

   	def draw 
   		#menu background
   		@background3.draw(0,0,0)

   		#for player at menu 
   		if  @framenum < @player_frame
   			@menuplayer[@player_frame-1].draw_rot(@player_postx,@player_posty,0,0)	
   		end
   		
   		#for monster at menu 
   		if @framenum1 < @monster_frame
   			@menumonster[@monster_frame-1].draw_rot(@monster_postx,@monster_posty,0,0,0,0,2.5,2.5)
   		end

   		#for player speech bubble at menu
   		if @framenum2 < @genjitext_frame
   			@genjitext[@genjitext_frame-1].draw(@player_speechx,@player_speechy,0,0.5,0.5)
   		end

   		#for monster speech bubble at menu
   		if @framenum3 < @monstertext_frame
   			@monstertext[@monstertext_frame-1].draw(@monster_speechx,@monster_speechy,0,0.5,0.5)
   		end

   		#display play button
 		@displayplaybutton.draw(@playbuttonx, @playbuttony, 0)

 		#display score button
 		@displayscorebutton.draw(@scorebuttonx, @scorebuttony, 0)

 		#display exit button
 		@displayexitbutton.draw(@exitbuttonx, @exitbuttony, 0 )

   		#display game title
   		@menutext1.draw(220,80,0)

   		#play menu music
   		@menumusic.play
   	end	
end

class Game < Gosu::Window
	def initialize
		#game resolution
		super 1280,720
		
		#initialize font
		@font = Gosu::Font.new(self, Gosu::default_font_name, 20)
		
		#load distance travelled image
		@distance_travelled_text = Gosu::Image.new("./Assets/Texts/DISTANCE_TRAVELLED.png")

		#game background images loaded
		@background_frames = 7 
		@background = Array.new(@background_frames)
		@backgroundtime = ["MORNING", "LATEMORNING", "AFTERNOON", "LATEAFTERNOON", "EVENING", "LATEEVENING", "NIGHT", "LATENIGHT"]
		for i in 0..@background_frames-1
			@background[i] = Gosu::Image.new("./Assets/Backgrounds/#{@backgroundtime[i]}.png", :tileable => true)
		end
	
		#player model 
		@player = Player_and_Rock.new

		#monster model
		@monster = Monster.new
		
		#player model jump constant
		@jump = true
		@jumpy = 25

		#background position
		@x1,@y1 = 0, 0
		@local_x = 0

		#background animation
		@backgroundframenum = 0
		@background_frame = 1 
		@background_index = 0 
	end

	def update

		#if player dies command runs
		@player.death

		#player continuously moves backwards
		@player.movebackwards

		#background frame control
		@backgroundframenum += 0.0009765625
		if @backgroundframenum >= 8 
			@backgroundframenum = 0 
		end 

		for i in 1..8
			if @backgroundframenum == i 
				@background_index = i-1
			end
		end
	
		#move obstacles function
		@player.rock_move

		#monster animation function
		@monster.update

		#background moving
		@x1 -= 5

   		#player movement control
     	if  Gosu.button_down? Gosu::KB_RIGHT
     		@player.calculate_distance
     		@player.move_right
     	elsif  Gosu.button_down? Gosu::KB_LEFT
     		@player.move_left
     	else 
     		@player.dontmove
     	end
   		if Gosu.button_down? Gosu::KB_UP and @jump 	
   			@jump = false unless
   			@player.jump(@jumpy)
   		elsif Gosu.button_down? Gosu::KB_DOWN
   			@player.movedown
   		end 
   
   		#player update function
   		@player.update(@jumpy)
	end

	def button_up(id)
		
		#if use release player movement control
		if id == Gosu::KB_UP
			@jump = true
		end
		super
	end

	def draw
		#background animation
		@local_x = @x1 % -@background[@background_index].width
		@background[@background_index].draw(@local_x, @y1, 0)
		@background[@background_index].draw(@local_x + @background[@background_index].width, @y1, 0) if @local_x < (@background[@background_index].width - self.width)	
	
		#display player model
		@player.draw 

		#display distance travelled
		@distance_travelled_text.draw(400,10,0)

		#display monster model
		@monster.draw

		#display the distance the player has travelled
		@font.draw_text(@player.calculate_distance.to_s,885,14,1,1.5,1.5, Gosu::Color::BLACK)	
	end	
end

class Monster
	def initialize
		#position of monster
		@x2 = 50
		@y2 = 350

		#monster frame images
		@monster_frames = 4
		@monster = Array.new(@monster_frames) 
		for i in 0..@monster_frames
			@monster[i] = Gosu::Image.new("./Assets/Overwatch sprites/Robot/Walk/#{i}.png")
		end	

		#monster frame control
		@monsterwalkframe = 0
		@monster_frame = 1
	end

	def update
		#monster animation control
		@monster_frame += 0.1
		if @monster_frame >= @monster_frames + 2
			@monster_frame = 1
		end
		@monsterwalkframe += 0.1
		if @monsterwalkframe >= 5 
			@monsterwalkframe = 0
		end
	end

	def draw
		#display monster animation
		if @monsterwalkframe < @monster_frame
			@monster[@monster_frame-1].draw_rot(@x2,@y2, 0, 0, 0, 0, 2.5, 2.5)
		end
	end 
end

class Player_and_Rock
	def initialize	
		#distance travelled by player
		@distance_measure = 0
		@distance = 0

		#record player score
		@scorecount = 1
		@scorearr = Array.new(@scorecount)

		#load music for gameplay
		@gameplaymusic = Gosu::Song.new("./Assets/Soundtracks/gameplay theme.mp3")

		#player runnning images
		@playerrun = Array.new(4)
		for i in 0..@playerrun.length-1 
			@playerrun[i] = Gosu::Image.new("./Assets/Overwatch sprites/Genji/Run/#{i}.png")
		end
		
		#initial player model images
		@player = Array.new(4)
		for i in 0..@player.length-1
			@player[i] = @playerrun[i]
		end
	
		#player initialize position
		@x = 420
		@y = 540

		#angle of jump
		@angle = 0.0

		#initial score count
		@score = 0

		#jump conditions
		@allow = true
		@vel_x = @vel_y = @down_y = 0
		
		#window resolution
		@width = 1280
		@height = 720
	
		#player running left images
		@playerrunleft = Array.new(4)
		for i in 0..@playerrunleft.length-1 
			@playerrunleft[i] = Gosu::Image.new("./Assets/Overwatch sprites/Genji/RunLeft/#{i}.png")
		end
		
		#player jumping images
		@playerjump = Array.new(4)
		for i in 0..@playerjump.length-1 
			@playerjump[i] = Gosu::Image.new("./Assets/Overwatch sprites/Genji/Jump/#{i}.png")
		end
		
		#player idle images
		@standingplayer = Array.new(4)
		for i in 0..@standingplayer.length-1 
			@standingplayer[i] = Gosu::Image.new("./Assets/Overwatch sprites/Genji/Idle/#{i}.png")
		end
		
		#player jump down right images
		@playerdown = Array.new(4)
		for i in 0..@playerdown.length-1
			@playerdown[i] = Gosu::Image.new("./Assets/Overwatch sprites/Genji/Crouch/#{i}.png")
		end
		
		#player frame control
		@runningframe = 0

		#intialize obstacle positions and scales
		@rockx = Array.new(6)
		for i in 0..@rockx.length-1
			@rockx[i] = 1280
		end

		@rocky = [460,-90,460,-90,460,-90]

		@rocksizex = Array.new(6)
		for i in 0..@rocksizex.length-1
			@rocksizex[i] = 1 
		end

		@rocksizey = Array.new(6)
		for i in 0..@rocksizey.length-1
			@rocksizey[i] = 1 
		end

		#obstacle at top of screen
		@rocktop = -90

		#obstacle at bottom of screen
		@rockbottom = 460
		
		#obstacle vertical positions 
		@rockypost = Array.new(6)
		for i in 0..@rockypost.length-1
			@rockypost[i] = 0
		end
		
		#determines whether obstacle at top or bottom
		@randomposition = [1,2,1,2,1,2]
		
		#obstacle horizontal positions
		@rockdist = Array.new(6)
		for i in 0..@rockdist.length-1
			@rockdist[i] = rand(250..400)
		end
		
		#obstacle moving backwards constant
		@xrock = 0 
		
		#obstacle frame control
		@rockframe = 0

		#load obstacle image
		@rock1 = Gosu::Image.new("./Assets/Obstacle/obstacle2.png")

		#the horizontal speed the obstacle is moving
		@rockspeed = 10
		@rockspeedincrease = 25
	end

	def rock_move
		#speed and increase of speed of obstacle horizontal movement
		@rockx[0] -= @rockspeed
		if @distance == @rockspeedincrease
			@rockspeed += 1.25 unless @distance > 200 
			@rockspeedincrease += 25
		end
	end 
	
	def calculate_distance
		#calculates the distance travelled by the player
		if @distance_measure > 1
			@distance += 1
			@distance_measure = 0
		end
		return @distance
	end
	
	def update(jump_max)
		#Jump Up
		if @vel_y > 0
			@allow = false
			(@vel_y.to_i).times do 
				@y -= 0.5 
				
				
				break if @y < 400
			end
			@vel_y -= 1.0
		end

		#Jump Down
		if @vel_y < 0
			((@vel_y*-1).to_i).times do
			   @y += 0.5
			   break if @y > 540
			end
			@vel_y += 1
		end
		check_jump
		@x %= 1280
		@y %= 600

		if @y < 400
			@y = 400
		end

		#player runnning animation control
		@runningframe += 0.25
		if @runningframe >= 4
			@runningframe = 0
		end 

		#horizontal movement of obstacle
		if @xrock < 1280
			for i in 0..4
				@rockx[i+1] = @rockx[i] + @rockdist[i]
			end
			
		end

		#restarts obstacle positions on the right of screen at random
		if @rockx[5] < -100
			@rockx[0] = 1280
			for i in 0..@rockdist.length-1
				@rockdist[i] = rand(250..400)
			end
			
			for i in 0..5
				@randomposition[i] = rand(1..2)
				if @randomposition[i] == 1 
					@rockypost[i] = @rocktop
				elsif @randomposition[i]	== 2 
					@rockypost[i] = @rockbottom
				end
			end
			
			for i in 0..5
				@rocky[i] = @rockypost[i]
			end
		end
	end

	def jump(original)
		# player jump animation
		for i in 0..3 
			@player[i] = @playerjump[i]
		end
		@vel_y = original
		@down_y = (original*-1)
	end 

	def check_jump
		#player jump conditions
		if @vel_y == 0 and @allow == false
			@vel_y = @down_y
			@down_y = 0
			@allow = true
		end
	end

	def dontmove 
		#player movement when user doesnt move
		@x -= 6

		#stops player model when reaches obstacle positions
		for i in 0..5
			if @x < @rockx[i] + 80 and @x > @rockx[i] + 70
				if @y > 460 and @rocky[i]== 460  then
					@x = @rockx[i] + 80 
				elsif  @y < 550 and @rocky[i]== -90 then 
					@x = @rockx[i]+ 80 
				end
			elsif @x > @rockx[i] - 40 and @x < @rockx[i]- 30
				if @y > 460 and @rocky[i]== 460  then
					@x = @rockx[i] -40
				elsif  @y < 550 and @rocky[i]== -90 then 
					@x = @rockx[i]-40
				end
			end
		end
		
		#ensures player model doesnt exceed ground position
		@y = 540 unless @y < 540
		
		#player model animation when idle
		for i in 0..3	
			@player[i] = @standingplayer[i]
		end	
	end 

	def movebackwards
		#player continuously moves backward
		@x -= 3 
	end

	def move_left
		#player model moves left
		@x -= 8 

		#ensures player model stops when approach obstacle
		for i in 0..5
			if @x < @rockx[i] + 80 and @x > @rockx[i] + 70
				if @y > 460 and @rocky[i]== 460  then
					@x = @rockx[i] + 80 
				elsif  @y < 550 and @rocky[i]== -90 then 
					@x = @rockx[i]+ 80 
				end
			elsif @x > @rockx[i] - 40 and @x < @rockx[i]- 30
				if @y > 460 and @rocky[i]== 460  then
					@x = @rockx[i] -40
				elsif  @y < 550 and @rocky[i]== -90 then 
					@x = @rockx[i]-40
				end
			end
		end
		
		#player moving left animation
		for i in 0..3
			@player[i] = @playerrunleft[i]
		end

		#ensures player model doesnt exceed ground position
		@y = 540 unless @y < 540 

		#ensures player model doesnt exceed monster position
		if @x < 30
			@x = 30 
		end
	end

	def move_right
		# measures the distance travelled by player
		@distance_measure += 0.05

		#player model moves right
		@x += 8 unless @x > 1260
		
		#ensures player model stops when it reaches obstacle position
		for i in 0..5
			if @x > @rockx[i] - 40 and @x < @rockx[i] + 80 
				if @y > 460 and @rocky[i] == 460  then
					@x = @rockx[i] - 40 
				elsif  @y < 550 and @rocky[i] == -90 then 
					@x = @rockx[i] - 40 
				end
			end
		end


		#player running right animation
		for i in 0..3
			@player[i] = @playerrun[i]
		end
		
		#ensure player model doesnt exceed ground position
		@y = 540 unless @y < 540 
	end

	def movedown
		#player model moves down
		@y += 15 unless @y > 540

		#player move down animation
		for i in 0..3
			@player[i] = @playerdown[i]
		end
	end 
	
	def death
		#player dies if it reaches monster position
		if @x < 270 #monster position
			for i in 0..@scorecount-1
				@scorearr[i] = @distance.to_s #store distance travelled score		
			end
   			@scorecount += 1 #add scorecount

			#store player score in a file
			scoreFile = File.new("./Assets/Text Files/Highscore.txt", "a")
			for i in 0..@scorearr.length-1
				scoreFile.puts @scorearr[i]
			end
			scoreFile.close

			#stop playing gameplay music
			@gameplaymusic.stop

			#runs death class
			DeathScreen.new.show
		end
	end

	def accelerate
		#player jump velocity
		@vel_x += Gosu.offset_x(@angle, 2.0)
		@vel_y += Gosu.offset_y(@angle, 2.0)
	end	

	def draw
		#play gameplay music
		@gameplaymusic.play
		
		#player model animation
		if @runningframe < 1 
			@player[0].draw_rot(@x, @y,1, @angle)
		elsif @runningframe < 2
			@player[1].draw_rot(@x, @y,1, @angle)
		elsif @runningframe <3
			@player[2].draw_rot(@x, @y,1, @angle)
		elsif @runningframe <4
			@player[3].draw_rot(@x, @y,1, @angle)
		end 

		#obstacle animtaion
		for i in 0..5 
			@rock1.draw_rot(@rockx[i],@rocky[i],0,0,0,0,@rocksizex[i],@rocksizey[i])
		end
		
	end
end 

class DeathScreen < Gosu::Window
	def initialize 
		super 1280,720
		#load game over music
		@gameovermusic = Gosu::Song.new("./Assets/Soundtracks/game_over.mp3")

		#load game over background
		@gameoverscreen = Gosu::Image.new("./Assets/Backgrounds/GAME_OVER.png")

		#load continue text
		@deathcontinuetext = Gosu::Image.new("./Assets/Texts/DEATHCONTINUE.png")

		#load you have died text
		@youhavediedtext = Gosu::Image.new("./Assets/Texts/YOU-HAVE-DIED.png")
	end

	def update
		#moves on to highscore screen when user press spacebar
   		if Gosu.button_down? Gosu::KB_SPACE
   			@gameovermusic
   			HighScoreScreen.new.show
   		end
	end

	def draw
		#play game over music 
		@gameovermusic.play

		#draw game over screen
		@gameoverscreen.draw(0,0,0)

		#draw continue text
		@deathcontinuetext.draw(155,600,0)

		#draw you have died text
		@youhavediedtext.draw(270,100,0)
	end
end

class HighScoreScreen < Gosu::Window
	def initialize
		super 1280,720
		#initialize font
		@fontscore = Gosu::Font.new(self,Gosu::default_font_name, 40)

		#initialize score array
		@scorearr = Array.new()
		
		#load high score screen background
		@Highscorebackground = Gosu::Image.new("./Assets/Backgrounds/HIGHSCORESCREEN.jpg")

		#load continue button
		@Continuebutton = Gosu::Image.new("./Assets/Texts/SCORECONTINUE.png")

		#load player's high score
		@playerHighScore = Gosu::Image.new("./Assets/Texts/YOURHIGHSCORE.png")

		#load new highscore text
		@newhighscoretext = Gosu::Image.new("./Assets/Texts/NEWHIGHSCORE.png")

		#initialize highest score
		@max = 0
	end

	def update
		#read Highscore.txt file
		scoreFile = File.open("./Assets/Text Files/Highscore.txt", "r")

		#lines in Highscore.txt file is inputted into score array
		@scorearr = scoreFile.readlines

		#find the highest value in score array
		for i in 0..@scorearr.length-1
			if @scorearr[i].to_i > @max
				@max = @scorearr[i].to_i
			end
		end
		
		#closes file if finish reading lines
		if (scoreFile.eof?)
			scoreFile.close
		end
	end

	def button_down(id)
		#go back to menu when user press spacebar
		if id == Gosu::KB_SPACE
			Menu.new.show
		end
	end

	def draw
		#draw highscore background
		@Highscorebackground.draw(0,0,0)

		#draw player's high score
		@playerHighScore.draw(263,150,0)

		#draw continue button
		@Continuebutton.draw(155,600,0)
		
		#draw "NEW HIGHSCORE" if player has achieved a new record
		@fontscore.draw_text(@scorearr[@scorearr.length-1].to_s,630,275,1,1.5,1.5, Gosu::Color::CYAN)
		if @scorearr[@scorearr.length-1].to_i == @max
			@newhighscoretext.draw(350,400,0)
			
		end
	end
end

class SCORES < Gosu::Window
  def initialize 
    super 1280,720
    #load score screen background
    @scorescreen = Gosu::Image.new("./Assets/Backgrounds/SCORES.jpg")

    #load score screen music
    @scoresmusic = Gosu::Song.new("./Assets/Soundtracks/score.mp3")

    #load leaderboard text
    @leaderboardtext = Gosu::Image.new("./Assets/Texts/LEADERBOARD.png")

    #load top 5 highest scores text
    @top5 = Gosu::Image.new("./Assets/Texts/TOP5.png")

    #load back button 
    @backbutton = Gosu::Image.new("./Assets/Texts/SCORESBACKBUTTON.png")

    #number images array
    @no = Array.new(5)

    #position of numbers
    @nox = 545
    @noy = 250

    #position of scores 
    @fontx = @nox + 100

    #load images of numbers 1 to 5
    for i in 1..5
   		@no[i-1] = Gosu::Image.new("./Assets/Texts/#{i}..png")
   	end

   	#initialize score array
   	@scorearr = Array.new()

   	#initialize top 5 highest scores array
    @top5arr = Array.new()

    #initialize score font
    @fonttop5 = Gosu::Font.new(self, Gosu::default_font_name,40)

    #max array
    @max = Array.new(5)
    for i in 0..@max.length-1
    	@max[i] = 0
    end
  end

  def update
  	#reads Highscore.txt file
	scoreFile = File.open("./Assets/Text Files/Highscore.txt", "r")

	#lines in Highscore.txt file are inputted into score array 
	@scorearr = scoreFile.readlines

	#check values in score array for top 5 highest values
	for i in 0..@scorearr.length-1
		if @scorearr[i].to_i > @max[0] 
			@max[0] = @scorearr[i].to_i
		elsif @scorearr[i].to_i > @max[1] and @scorearr[i].to_i< @max[0]
			@max[1] = @scorearr[i].to_i
		elsif @scorearr[i].to_i > @max[2] and @scorearr[i].to_i< @max[1]
			@max[2] = @scorearr[i].to_i
		elsif @scorearr[i].to_i > @max[3] and @scorearr[i].to_i< @max[2]
			@max[3] = @scorearr[i].to_i
		elsif @scorearr[i].to_i > @max[4] and @scorearr[i].to_i< @max[3]
			@max[4] = @scorearr[i].to_i
		end
	end

	#goes back to main menu when use presses spacebar
	if Gosu.button_down? Gosu::KB_SPACE
		@scoresmusic.stop
		Menu.new.show
	end
  end

  def draw
  	#play score screen music
    @scoresmusic.play

    #draw score screen background
    @scorescreen.draw(0,0,0)

    #draw leaderboard text
    @leaderboardtext.draw(255,10,0)

    #draw top 5 text 
    @top5.draw(220,150,0)

    #draw number 1 to 5 
    @no[0].draw(@nox,@noy,0)
    @no[1].draw(@nox,@noy + 75,0)
    @no[2].draw(@nox,@noy + 150,0)
    @no[3].draw(@nox,@noy + 225,0)
    @no[4].draw(@nox,@noy + 300,0)

    #draw back button
    @backbutton.draw(345,650,0)

    #draw top 5 scores
    @fonttop5.draw_text(@max[0],@fontx,@noy,1,1.5,1.5,Gosu::Color::RED)
    @fonttop5.draw_text(@max[1],@fontx,@noy + 75,1,1.5,1.5,Gosu::Color::BLACK)
    @fonttop5.draw_text(@max[2],@fontx,@noy + 150,1,1.5,1.5,Gosu::Color::BLACK)
    @fonttop5.draw_text(@max[3],@fontx,@noy + 225,1,1.5,1.5,Gosu::Color::BLACK)
    @fonttop5.draw_text(@max[4],@fontx,@noy + 300,1,1.5,1.5,Gosu::Color::BLACK)
  end
end

#start program
Menu.new.show