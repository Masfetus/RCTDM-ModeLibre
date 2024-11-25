#define RECORDING "John" // Nom de l'enregistrement test.rec
#define RECORDING_TYPE 1 //1 pour un enregistrement dans un Véhicule et 2 pour un Ped

#include <a_npc>
main(){}
public OnRecordingPlaybackEnd() StartRecordingPlayback(RECORDING_TYPE, RECORDING);
public OnNPCEnterVehicle(vehicleid, seatid) StartRecordingPlayback(RECORDING_TYPE, RECORDING);
public OnNPCExitVehicle() StopRecordingPlayback();

