extends Control

signal close

func onCloseButtonPressed():
	close.emit()
