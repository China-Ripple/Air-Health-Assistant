//
//  CiGateTypes.h
//  iGate
//
//  Created by Zhan on 12-11-19.
//
//

#ifndef iGate_CiGateTypes_h
#define iGate_CiGateTypes_h

/*!
 *  @enum CiGateState
 *
 *  @discussion Represents the current state of a iGate.
 *
 */
enum {
	CiGateStateInit = 0,	// State unknown, update imminent.
    CiGateStatePoweredOff,  // Bluetooth is currently powered off.
    CiGateStateUnknown,     // State unknown, update imminent.
    CiGateStateResetting,   // The connection with the system service was momentarily lost, update imminent.
	CiGateStateUnsupported,	// Something wrong, iOS device not support BTLE or not power on.
    CiGateStateUnauthorized,// The app is not authorized to use Bluetooth Low Energy.
    CiGateStateIdle,        // Bluetooth is currently powered on and available to use.
	CiGateStateSearching,	// The iGate is searching to a device.
	CiGateStateConnecting,	// the iGate is connecting to a device.
	CiGateStateConnected,	// The igate is connected with a device.
    CiGateStateBonded,	    // The igate is bondeded (and the connection is encypted) with a device.
};
typedef NSInteger CiGateState;

typedef struct {
    UInt8 type;
    UInt16 nap;
    unsigned uap:8;
    unsigned lap:24;
} CBluetoothAddr;
//typedef const struct CBluetoothAddr* CBtAddrRef;

/*!
 *  @macro IGATE_MAX_SEND_DATE_LEN
 *
 *  @discussion There's a limitation in packet size in low level BTLE data packet,
 *              so for each time
 *
 */
#define IGATE_MAX_SEND_DATE_LEN 20


#endif
