#pragma newdecls required

#include <sourcemod>
#include <sdktools_functions>
 
public Plugin myinfo = {
	name = "Taser Jumper",
	author = "Grand Panda",
	description = "Jump with a taser",
	version = "0.1",
	url = "https://github.com/GrandPanda/TaserJumper"
};

ConVar JumpScale;
ConVar RequireCrouch;
 
public void OnPluginStart() {
	JumpScale = CreateConVar("tj_jumpscale", "1000", "Scales the velocity a player receives from taser jumping.");
	RequireCrouch = CreateConVar("tj_requirecrouch", "1", "Whether crouching should be required to taser jump.");

	HookEvent("weapon_fire", Event_WeaponFire);
}

public void Event_WeaponFire(Event event, const char[] name, bool dontBroadcast) {
	char weapon[13];
	event.GetString("weapon", weapon, 13);

	if (StrEqual(weapon, "weapon_taser")) {
		int userid = event.GetInt("userid");
		int client = GetClientOfUserId(userid);

		int buttons = GetClientButtons(client);
		if (RequireCrouch.BoolValue &&  !(buttons & IN_DUCK)) {
			return;
		}

		float curVelocity[3];
		GetEntPropVector(client, Prop_Data, "m_vecVelocity", curVelocity);
		
		float angle[3];
		GetClientEyeAngles(client, angle);

		float fwd[3];
		float right[3];
		float up[3];
		GetAngleVectors(angle, fwd, right, up);
		NegateVector(fwd);
		ScaleVector(fwd, JumpScale.FloatValue);

		float newVelocity[3];
		AddVectors(fwd, curVelocity, newVelocity);

		TeleportEntity(client, NULL_VECTOR, NULL_VECTOR, newVelocity);
	}
}