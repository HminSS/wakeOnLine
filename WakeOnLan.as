package 
{
	import flash.net.DatagramSocket;
	import flash.utils.ByteArray;
	import flash.events.Event;

	public class WakeOnLan
	{
		private var datagramSocket:DatagramSocket;
		
		public function wakeOnLan(ip:String = "192.168.1.255", mac:String = "FC-AA-14-5C-46-16", port:uint = 7):void
		{	
			if (datagramSocket == null)
			{
				datagramSocket = new DatagramSocket();
				
			}	
			//datagramSocket.addEventListener(Event.ACTIVATE, ondatagramSocketHandler);
			//datagramSocket.addEventListener(Event.DEACTIVATE, ondatagramSocketHandler);
			//if(RegExpUtil.MACADDRESS.test(mac) && RegExpUtil.IPADDRESS.test(ip))
			//{
				var ba:ByteArray = getWOLPackage(mac);
				try
				{
					trace(ba.length, ip, port)
					datagramSocket.send(ba, 0, 0, ip, port);
				}
				catch(e:Error)
				{
					trace("Warning:" + e.message);
				}
				
				try
				{
					datagramSocket.close();
				}
				catch(e:Error)
				{
					trace("sss");
				}
				finally
				{
					datagramSocket = null;
				}
				
			//}
			//else
			//{
				//throw new ArgumentError("ComputerControl类,wakeOnLan方法，ip或是mac参数格式错误！！");
			//}
		}	
		
		public static function getWOLPackage(mac:String):ByteArray
		{
			var ba:ByteArray = new ByteArray();
			var macArray:Array = [];
			
			var macRegExp:RegExp = /([[:xdigit:]]{2}[-:]){5}[[:xdigit:]]{2}/gi;
			
			//if(macRegExp.test(mac))
			//{
				/**
				 * @internal
				 * 添加头部数据，拆分MAC地址。
				 */ 
				for(var i:int = 0; i < 6; i ++)
				{
					ba.writeByte(255);		//写入6个0xFF头包
					macArray[i] = mac.substr(i * 3, 2);
				}
				
				/**
				 * @internal
				 * 添加十六次，把MAC拆分
				 */ 
				for(var j:int = 0; j < 16; j ++)
				{
					//写16次MAC地址包
					for(var k:int = 0; k < 6; k ++)
					{
						var num:int = parseInt(macArray[k], 16);
						ba.writeByte(num);
					}
				}
			//}
			//else
			//{
				///throw new ArgumentError("MAC地址格式错误！！");
			//}
			
			return ba;
		}

	}
	
}