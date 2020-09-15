//
DefinitionBlock ("", "SSDT", 2, "ACDT", "BATS", 0)
{
    External (_SB.PCI0.LPCB.H_EC.BAT1, DeviceObj)
    External (_SB.PCI0.LPCB.H_EC.ECAV, IntObj)
    //
    //External (_SB.PCI0.LPCB.H_EC.B1T1, FieldUnitObj)
    //External (_SB.PCI0.LPCB.H_EC.B1T2, FieldUnitObj)
    External (_SB.PCI0.LPCB.H_EC.FUSH, FieldUnitObj)
    External (_SB.PCI0.LPCB.H_EC.FUSL, FieldUnitObj)
    External (_SB.PCI0.LPCB.H_EC.BMIH, FieldUnitObj)
    External (_SB.PCI0.LPCB.H_EC.BMIL, FieldUnitObj)
    External (_SB.PCI0.LPCB.H_EC.FMVH, FieldUnitObj)
    External (_SB.PCI0.LPCB.H_EC.FMVL, FieldUnitObj)
    External (_SB.PCI0.LPCB.H_EC.HIDH, FieldUnitObj)
    External (_SB.PCI0.LPCB.H_EC.HIDL, FieldUnitObj)
    External (_SB.PCI0.LPCB.H_EC.DAVH, FieldUnitObj)
    External (_SB.PCI0.LPCB.H_EC.DAVL, FieldUnitObj)
    //
    Scope (\_SB.PCI0.LPCB.H_EC.BAT1)
    {
        Method (B1B2, 2, NotSerialized)
        {
            Local0 = (Arg1 << 0x08)
            Local0 |= Arg0
            Return (Local0)
        }
        
        Method (CBIS, 0, Serialized)
        {
            Name (PKG1, Package (0x08)
            {
                // config, double check if you have valid AverageRate before
                // fliping that bit to 0x007F007F since it will disable quickPoll
                0x006F007F,
                // ManufactureDate (0x1), AppleSmartBattery format
                0xFFFFFFFF, 
                // PackLotCode (0x2)
                0xFFFFFFFF, 
                // PCBLotCode (0x3)
                0xFFFFFFFF, 
                // FirmwareVersion (0x4)
                0xFFFFFFFF, 
                // HardwareVersion (0x5)
                0xFFFFFFFF, 
                // BatteryVersion (0x6)
                0xFFFFFFFF, 
                0xFFFFFFFF, 
            })
            // Check your _BST method for similiar condition of EC accessibility
            If (\_SB.PCI0.LPCB.H_EC.ECAV)
            {
                //PKG1 [One]  = B1B2 (B1T1, B1T2)
                PKG1 [0x02] = B1B2 (FUSL, FUSH)
                PKG1 [0x03] = B1B2 (BMIL, BMIH)
                PKG1 [0x04] = B1B2 (FMVL, FMVH)
                PKG1 [0x05] = B1B2 (HIDL, HIDH)
                PKG1 [0x06] = B1B2 (DAVL, DAVH)
            }

            Return (PKG1)
        } // CBIS

        Method (CBSS, 0, Serialized)
        {
            Return (Buffer (Zero){})
        } // CBSS
        
    } // BAT1
}
//EOF
