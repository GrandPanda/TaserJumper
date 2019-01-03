#include <sourcemod>
 
public Plugin myinfo =
{
	name = "Taser Jumper",
	author = "Grand Panda",
	description = "Jump with a taser",
	version = "0.1",
	url = "https://github.com/GrandPanda/TaserJumper"
};
 
public void OnPluginStart()
{
	PrintToServer("Hello world!");
}