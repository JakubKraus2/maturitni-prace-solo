extends Node2D


func play_main_menu():
	$MainMenuMusic.play()
	$IdleMusic.stop()
	$BossStoneGolemMusic.stop()
	$BossHeartHorderMusic.stop()

func play_idle():
	$IdleMusic.play()
	$MainMenuMusic.stop()
	$BossStoneGolemMusic.stop()
	$BossHeartHorderMusic.stop()

func play_stone_golem():
	$BossStoneGolemMusic.play()
	$MainMenuMusic.stop()
	$IdleMusic.stop()
	$BossHeartHorderMusic.stop()

func play_heart_horder():
	$BossHeartHorderMusic.play()
	$MainMenuMusic.stop()
	$IdleMusic.stop()
	$BossStoneGolemMusic.stop()
