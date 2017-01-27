package com.MCore.managers 
{
	import laya.display.Sprite;
	import laya.ui.View;

	/**
	 * ...
	 * @author cong
	 */
	public interface IPopUp 
	{
		function addPopUp(window : View, parent : Sprite, modal : Boolean = true, maskColor : uint = 0x000000, maskAlpha : Number = 0.5,tweener:Boolean = true):void;
		function centerPopUp(window : View):void;
		function removePopUp(window : View):void;
		function findPopupInfoByOwner(owner : Object):PopUpData;
		function findPopUpByOwner(owner : Object):View;
	}
	
}