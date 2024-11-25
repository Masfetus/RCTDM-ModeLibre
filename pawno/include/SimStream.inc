//========================================================//
//=============[MidoStream - Object Streamer]=============//
//=====================[by MidoBan]=======================//
//=====================EDIT BY SIM========================//

/*

native CreateStreamObject(modelid,Float:xpos,Float:ypos,Float:zpos,Float:xrot,Float:yrot,Float:zrot) - Create a streamed object
native DestroyStreamObject(id) - Destroy a streamed object
native AddMovingObject(modelid,Float:X1,Float:Y1,Float:Z1,Float:X2,Float:Y2,Float:Z2,Float:RX,Float:RY,Float:RZ,Float:Speed2)
native MoveStreamObject(id,Float:X,Float:Y,Float:Z,Float:Speed)
native StopStreamObject(id);
native GetStreamObjectPos(id, &Float:x, &Float:y, &Float:z)
native GetStreamObjectRot(id, &Float:rx, &Float:ry, &Float:rz)
native SetStreamObjectRot(objectid, Float:xrot, Float:yrot, Float:zrot)
*/

#if defined _SIM_STREAM_INCLUDED
	#endinput
#endif
#define _SIM_STREAM_INCLUDED

#include <a_samp>

forward OnStreamObjectMoved(objectid);

//----------------------------------------------------------
stock CreateStreamObject(modelid,Float:xpos,Float:ypos,Float:zpos,Float:xrot,Float:yrot,Float:zrot,Float:viewdist=250.0)
{
	#pragma unused viewdist
	return CallRemoteFunction("Core_CreateStreamObject","iffffff",modelid,xpos,ypos,zpos,xrot,yrot,zrot);
}

//----------------------------------------------------------

stock DestroyStreamObject(id)
{
/*	MaxObjects--;  */
	CallRemoteFunction("Core_DestroyStreamObject","i",id);
}

//----------------------------------------------------------

stock GetStreamObjectPos(id, &Float:x, &Float:y, &Float:z)
{
	x = Float:CallRemoteFunction("Core_GetXPos", "i", id);
	y = Float:CallRemoteFunction("Core_GetYPos", "i", id);
	z = Float:CallRemoteFunction("Core_GetZPos", "i", id);
	return 1;
}

//----------------------------------------------------------

stock GetStreamObjectRot(id, &Float:rx, &Float:ry, &Float:rz)
{
	rx = Float:CallRemoteFunction("Core_GetXRot", "i", id);
	ry = Float:CallRemoteFunction("Core_GetYRot", "i", id);
	rz = Float:CallRemoteFunction("Core_GetZRot", "i", id);
	return 1;
}

//----------------------------------------------------------

stock GetStreamObjectXRot(id, &Float:rx)
{
	rx = Float:CallRemoteFunction("Core_GetXRot", "i", id);
	return 1;
}

//----------------------------------------------------------

stock GetStreamObjectYRot(id, &Float:ry)
{
	ry = Float:CallRemoteFunction("Core_GetYRot", "i", id);
	return 1;
}

//----------------------------------------------------------

stock GetStreamObjectZRot(id, &Float:rz)
{
	rz = Float:CallRemoteFunction("Core_GetZRot", "i", id);
	return 1;
}

//----------------------------------------------------------

stock MoveStreamObject(id,Float:X,Float:Y,Float:Z,Float:Speed)
{
	return CallRemoteFunction("Core_PutMovingObject","iffff",id,X,Y,Z,Speed);
}

//----------------------------------------------------------

stock AddMovingObject(modelid,Float:X1,Float:Y1,Float:Z1,Float:X2,Float:Y2,Float:Z2,Float:RX,Float:RY,Float:RZ,Float:Speed2,Float:DIST=250.0)
{
	#pragma unused DIST
	return CallRemoteFunction("Core_AddMovingObject","iffffffffff",modelid,X1,Y1,Z1,X2,Y2,Z2,RX,RY,RZ,Speed2);
}

//----------------------------------------------------------

stock StopStreamObject(id)
{
	CallRemoteFunction("Core_StopMovingObject","i",id);
}

//----------------------------------------------------------

stock SetStreamObjectRot(objectid, Float:xrot, Float:yrot, Float:zrot)
{
	CallRemoteFunction("core_SetObjRot", "ifff", objectid, xrot, yrot, zrot);
}

